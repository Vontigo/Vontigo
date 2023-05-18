import { knexInstance } from '$lib/core/core/server/data/db/connection';
import { ENUM_DATABASE_TABLE, ENUM_POSTS_STATUS } from '$lib/core/shared/enum.js';
import { language } from '$lib/core/shared/stores/site';
import type { RequestHandler } from '../../$types';
import ObjectID from 'bson-objectid';
import { get } from 'svelte/store';
import { v4 as uuidv4 } from 'uuid';

/** @type {import('./$types').RequestHandler} */
export async function GET({ url, params }) {
	let returnRows: any;
	await getAllRows(params)
		.then((rows) => {
			// console.log(rows);
			returnRows = rows;
		})
		.catch((error) => {
			console.error(error);
			returnRows = error;
		});
	return new Response(JSON.stringify(returnRows), { status: 200 });
}

async function getAllRows(params: any): Promise<any[] | null> {
	const PAGE_SIZE = 10; // number of results per page

	try {
		const countQuery = await knexInstance('posts as p')
			.count('id as totalRows')
			.where({
				'p.type': params.type,
				'p.visibility': 'public'
			})
			.where('p.status', params.status != 'undefined' ? '=' : '<>', params.status)
			.where({ 'p.locale': get(language) });

		const rows: any[] = await knexInstance
			.limit(PAGE_SIZE)
			.offset((params.page_number - 1) * PAGE_SIZE)
			.select(
				'p.*',
				// 'p.uuid',
				// 'p.title',
				// 'p.status',

				// 'p.created_at',
				// 'p.created_by',
				// 'p.updated_at',
				// 'p.updated_by',

				't.id as primary_tag',
				't.name as primary_tag_name',
				't.slug as primary_tag_slug',
				'u.name as author_name'
			)
			.from('posts as p')
			.leftJoin('posts_tags as pt', 'p.id', 'pt.post_id')
			.leftJoin('tags as t', 't.id', 'pt.tag_id')
			.leftJoin('users as u', 'p.created_by', 'u.id')
			.where({
				'p.type': params.type,
				'p.visibility': 'public'
			})
			.where('p.status', params.status != 'undefined' ? '=' : '<>', params.status)
			.where({ 'p.locale': get(language) })
			.orderBy('p.updated_at', 'desc');

		const [totalRowsResult, results] = await Promise.all([countQuery, rows]);

		const totalRows = totalRowsResult[0].totalRows;
		const totalPages = Math.ceil(totalRows / PAGE_SIZE);

		return {
			items: await rows,
			pagination: {
				page: Number.parseInt(params.page_number),
				totalRows: totalRows,
				totalPages: totalPages
			}
		};
	} catch (error) {
		console.error(error);
		return null;
	}
}

// CREATE POST

export const POST = (async ({ request, params }) => {
	const reqJsonData = await request.json();
	let returnRows: any;

	knexInstance(ENUM_DATABASE_TABLE.posts)
		.insert({
			id: new ObjectID(),
			uuid: uuidv4(),
			title: reqJsonData.title,
			slug: reqJsonData.slug,
			mobiledoc: reqJsonData.mobiledoc,
			lexical: reqJsonData.lexical,
			html: reqJsonData.html,
			comment_id: new ObjectID(),
			plaintext: reqJsonData.plaintext,
			feature_image: reqJsonData.feature_image,
			featured: '0',
			type: params.type,
			status: ENUM_POSTS_STATUS.draft,
			locale: params.language,
			visibility: 'public',
			email_recipient_filter: 'all',
			created_at: new Date(reqJsonData.created_at),
			created_by: reqJsonData.created_by,
			updated_at: new Date(reqJsonData.updated_at),
			updated_by: reqJsonData.updated_by,
			published_at: new Date(reqJsonData.published_at),
			published_by: reqJsonData.published_by,
			custom_excerpt: reqJsonData.custom_excerpt,
			codeinjection_head: reqJsonData.codeinjection_head,
			codeinjection_foot: reqJsonData.codeinjection_foot,
			custom_template: reqJsonData.custom_template,
			canonical_url: reqJsonData.canonical_url,
			newsletter_id: reqJsonData.newsletter_id
		})
		.then((result) => {
			// console.log('Inserted:', result);
			return new Response(JSON.stringify(result), { status: 200 });
		})
		.catch((error) => {
			console.error(error);
			return new Response(JSON.stringify(error), { status: 500 });
		});

	return new Response(JSON.stringify(returnRows), { status: 200 });
}) satisfies RequestHandler;
