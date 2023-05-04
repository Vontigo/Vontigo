// import { knexInstance } from '$lib/core/core/server/data/db/connection';
// import { language } from '$lib/core/shared/stores/site.js';
// import { get } from 'svelte/store';

// /** @type {import('./$types').RequestHandler} */
// export async function GET({ url }) {
// 	// console.log(1);

// 	let returnRows: any;
// 	await getAllRows()
// 		.then((rows) => {
// 			// console.log(rows);
// 			returnRows = rows;
// 		})
// 		.catch((error) => {
// 			console.error(error);
// 			returnRows = error;
// 		});
// 	return new Response(JSON.stringify(returnRows), { status: 200 });
// }

// async function getAllRows(): Promise<any[] | null> {
// 	const PAGE_SIZE = 25;
// 	try {
// 		const rows: any[] = await knexInstance
// 			.limit(PAGE_SIZE)
// 			.offset((1 - 1) * PAGE_SIZE)
// 			.select(
// 				'p.*',
// 				't.id as primary_tag',
// 				't.name as primary_tag_name',
// 				't.slug as primary_tag_slug'
// 			)
// 			.from('posts as p')
// 			.leftJoin('posts_tags as pt', 'p.id', 'pt.post_id')
// 			.leftJoin('tags as t', 't.id', 'pt.tag_id')
// 			.where({ 'p.type': 'post', 'p.status': 'published', 'p.locale': get(language) });
// 		return rows;
// 	} catch (error) {
// 		console.error(error);
// 		return null;
// 	}
// }

// // import { db } from '$lib/core/core/server/data/db/connection';
// // import Database from 'better-sqlite3';

// // /** @type {import('./$types').RequestHandler} */
// // export function GET({ url }) {
// // 	const sql = `
// //     select * from posts;
// //     `;
// // 	const stmnt = db.prepare(sql);
// // 	const rows = stmnt.all({ limit: 50 });

// // 	return new Response(JSON.stringify(rows));
// // }
