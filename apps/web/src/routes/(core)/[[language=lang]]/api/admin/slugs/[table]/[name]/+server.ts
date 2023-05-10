import { knexInstance } from '$lib/core/core/server/data/db/connection';
import { ENUM_DATABASE_TABLE } from '$lib/core/shared/enum.js';
import type { RequestHandler } from './$types';
import { slugify } from 'transliteration';

/** @type {import('./$types').RequestHandler} */
export const GET = (async ({ request, params }) => {
	let dataQuery: any;
	const asciiSlug = await convertToAsciiSlug(params.name);

	const uniqueSlug = await createUniqueSlug(params.table, asciiSlug);
	// console.log(uniqueSlug);
	return new Response(
		JSON.stringify({
			slugs: [
				{
					slug: uniqueSlug
				}
			]
		})
	);

	// for (const slugObj of slugs) {
	// 	knexInstance(ENUM_DATABASE_TABLE.posts).insert({
	// 		slug: JSON.stringify(slugObj)
	// 	}).then(result => {
	// 		dataQuery = result;
	// 		console.log('Inserted:', result);
	// 	}).catch(error => {
	// 		console.error(error);
	// 	});
	// }
}) satisfies RequestHandler;

async function createUniqueSlug(table: string, slug: string): Promise<string> {
	// console.log('createUniqueSlug: ', slug);

	const existingSlugCount = await knexInstance(table).where('slug', slug).count();
	const count = parseInt(existingSlugCount[0]['count(*)'] || '0', 10);
	// console.log(count);

	if (count === 0) {
		return slug;
	}

	const newSlug = `${slug}-${count}`;
	return createUniqueSlug(table, newSlug);
}
async function convertToAsciiSlug(input: string): string {
	const latinString = slugify(input, { lowercase: true, separator: '-' });
	return latinString.replace(/[^a-z0-9-]/g, '');
}
