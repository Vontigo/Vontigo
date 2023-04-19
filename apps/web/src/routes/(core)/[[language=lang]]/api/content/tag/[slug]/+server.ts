import { knexInstance } from '$lib/core/core/server/data/db/connection';

/** @type {import('./$types').RequestHandler} */
export async function GET({ url, params }) {
	let content: any;
	let posts: any[];
	// console.log(params);
	try {
		content = await knexInstance
			.select(
				't.*',
			)
			.from('tags as t')
			.where({
				't.slug': params.slug
			})
			.first();

		// console.log(content);


		posts = await knexInstance
			.select('p.*')
			.from('posts as p')
			.leftJoin('posts_tags as pt', 'p.id', 'pt.post_id')
			.where({
				'pt.tag_id': content.id
			});

		// console.log(posts);
	} catch (error) {
		return new Response(JSON.stringify(error), { status: 300 });
	}
	return new Response(
		JSON.stringify({
			content: content,
			authors: posts
		}),
		{ status: 200 }
	);
}

async function getAllRows(tableName: string): Promise<any[] | null> {
	try {
		const rows: any[] = await knexInstance(tableName).select();
		return rows;
	} catch (error) {
		console.error(error);
		return null;
	}
}

// export function GET({ url, params }) {
// 	let returnRows: any;
// 	console.log(params);

// 	const sql = `
//     select * from posts p where p.slug = $slug and p.status = $status;
//     `;
// 	const stmnt = db.prepare(sql);
// 	const rows = stmnt.get(params);
// 	// console.log(rows);
// 	return new Response(JSON.stringify(rows), { status: 200 });
// }
