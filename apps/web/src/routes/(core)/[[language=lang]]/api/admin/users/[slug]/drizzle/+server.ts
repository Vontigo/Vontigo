import type { RequestHandler } from './$types';
import { Container } from '../../../../../../application/Container';
import { json, error } from '@sveltejs/kit';

export const GET = (async ({ params }) => {
	try {
		const { slug } = params;
		
		if (!slug) {
			throw error(400, { message: 'User slug is required' });
		}

		const container = Container.getInstance();
		const userService = container.getUserService();

		// Get user by slug using domain service
		const user = await userService.getUserBySlug(slug);

		if (!user) {
			throw error(404, { message: 'User not found' });
		}

		// Return user data in a clean, type-safe format
		const response = {
			user: {
				id: user.id,
				name: user.name,
				slug: user.slug,
				email: user.email,
				profileImage: user.profileImage,
				coverImage: user.coverImage,
				bio: user.bio,
				website: user.website,
				location: user.location,
				facebook: user.facebook,
				twitter: user.twitter,
				status: user.status,
				visibility: user.visibility,
				createdAt: user.createdAt,
				updatedAt: user.updatedAt,
				lastSeen: user.lastSeen,
				// Additional computed properties
				isActive: user.isActive(),
				isPublic: user.isPublic()
			},
			meta: {
				retrieved_at: new Date().toISOString(),
				version: '2.0' // New architecture version
			}
		};

		return json(response);
	} catch (err) {
		console.error(`Error fetching user by slug ${params.slug}:`, err);
		
		if (err instanceof Error && 'status' in err) {
			throw err; // Re-throw SvelteKit errors
		}
		
		throw error(500, {
			message: 'Failed to fetch user',
			details: err instanceof Error ? err.message : 'Unknown error'
		});
	}
}) satisfies RequestHandler;