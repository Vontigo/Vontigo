import { knexInstance } from '$lib/core/core/server/data/db/connection';
import { language } from '$lib/core/shared/stores/site.js';
import { get } from 'svelte/store';

/** @type {import('./$types').RequestHandler} */
export async function GET({ url, params }) {
	console.log(params);

	const PAGE_SIZE = params.posts_per_page;

	try {
		const countQuery = await knexInstance('posts as p')
			.count('id as totalRows')
			.where({ 'p.type': 'post', 'p.status': 'published', 'p.locale': get(language) });

		const posts: any[] = await knexInstance
			.limit(PAGE_SIZE)
			.offset((params.page_number - 1) * PAGE_SIZE)
			.select(
				'p.*',
				't.id as primary_tag',
				't.name as primary_tag_name',
				't.slug as primary_tag_slug'
			)
			.from('posts as p')
			.leftJoin('posts_tags as pt', 'p.id', 'pt.post_id')
			.leftJoin('tags as t', 't.id', 'pt.tag_id')
			.where({ 'p.type': 'post', 'p.status': 'published', 'p.locale': get(language) })
			.orderBy('p.published_at', 'desc');

		console.log('api accessing posts');
		console.log(get(language));

		const [totalRowsResult, results] = await Promise.all([countQuery, posts]);

		const totalRows = totalRowsResult[0].totalRows;
		const totalPages = Math.ceil(totalRows / PAGE_SIZE);

		return new Response(
			JSON.stringify({
				items: await posts,
				pagination: {
					page: Number.parseInt(params.page_number),
					totalRows: totalRows,
					totalPages: totalPages
				}
			}),
			{ status: 200 }
		);
	} catch (error) {
		console.error(error);
		console.log(error);

		return null;
	}

	// let returnRows: any;
	// await getAllRows(params)
	// 	.then((rows) => {
	// 		// console.log(rows);
	// 		returnRows = rows;
	// 	})
	// 	.catch((error) => {
	// 		console.error(error);
	// 		returnRows = error;
	// 	});
	// return new Response(JSON.stringify(returnRows), { status: 200 });
}

// async function getAllRows(params: any): Promise<any[] | null> {
// 	const PAGE_SIZE = params.posts_per_page;

// }
// async function totalPages(params: any): Promise<any[] | null> {
// 	const PAGE_SIZE = params.posts_per_page;
// 	try {
// 		const countQuery = await knexInstance('posts as p')
// 			.count('id as totalRows')
// 			.where({ 'p.type': 'post', 'p.status': 'published', 'p.locale': get(language) });
// 		return query.totalRows;
// 	} catch (error) {
// 		console.error(error);
// 		return null;
// 	}
// }

// import { db } from '$lib/core/core/server/data/db/connection';
// import Database from 'better-sqlite3';

// /** @type {import('./$types').RequestHandler} */
// export function GET({ url }) {
// 	const sql = `
//     select * from posts;
//     `;
// 	const stmnt = db.prepare(sql);
// 	const rows = stmnt.all({ limit: 50 });

// 	return new Response(JSON.stringify(rows));
// }
