import type { RequestHandler } from './$types';
import { Container } from '../../../../../../application/Container';
import { json, error } from '@sveltejs/kit';

export const GET = (async ({ url }) => {
	try {
		const container = Container.getInstance();
		const userService = container.getUserService();

		// Parse query parameters
		const limitParam = url.searchParams.get('limit');
		const offsetParam = url.searchParams.get('offset');
		const orderBy = url.searchParams.get('orderBy') as 'createdAt' | 'name' | 'email' | null;
		const order = url.searchParams.get('order') as 'asc' | 'desc' | null;

		const options = {
			limit: limitParam ? parseInt(limitParam, 10) : undefined,
			offset: offsetParam ? parseInt(offsetParam, 10) : undefined,
			orderBy: orderBy || 'createdAt',
			order: order || 'desc'
		};

		// Get users using domain service
		const users = await userService.getAllUsers(options);
		const totalCount = await userService.getUserCount();

		// Transform to API response format
		const response = {
			users: users
				.filter((user) => user.isActive()) // Only active users
				.map((user) => ({
					id: user.id,
					name: user.name,
					slug: user.slug,
					email: user.email,
					profileImage: user.profileImage,
					bio: user.bio,
					website: user.website,
					location: user.location,
					status: user.status,
					visibility: user.visibility,
					createdAt: user.createdAt,
					updatedAt: user.updatedAt,
					lastSeen: user.lastSeen
				})),
			meta: {
				total: totalCount,
				limit: options.limit,
				offset: options.offset
			}
		};

		return json(response);
	} catch (err) {
		console.error('Error fetching users:', err);
		throw error(500, {
			message: 'Failed to fetch users',
			details: err instanceof Error ? err.message : 'Unknown error'
		});
	}
}) satisfies RequestHandler;