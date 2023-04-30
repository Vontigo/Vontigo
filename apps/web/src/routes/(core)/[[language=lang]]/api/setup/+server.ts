import { knexInstance } from '$lib/core/core/server/data/db/connection.js';
import fs from 'fs';
import { slugify } from 'transliteration';
let setupBody = {
	siteTitle: '',
	fullName: '',
	email: '',
	password: ''
};

/** @type {import('./$types').RequestHandler} */
export async function POST({ url, params, request }) {

	const resJson = await request.json();

	setupBody.siteTitle = resJson.siteTitle;
	setupBody.fullName = resJson.fullName;
	setupBody.email = resJson.email;
	setupBody.password = resJson.password;
	console.log(setupBody);

	try {
		const dbFilePath = 'database/vontigo.blank.db';
		const destinationPath = 'database/vontigo.db';

		fs.copyFileSync(dbFilePath, destinationPath);

		console.log('File copied successfully!');

		updateData(setupBody);
	} catch (err) {
		console.error(err);
	}

	return new Response(JSON.stringify({ message: 'done' }), { status: 200 });
}

async function updateData(setupBody: any) {


	// console.log(value);

	// Check if the table exists in the database
	const tableExists = await knexInstance.schema.hasTable('users');
	if (!tableExists) {
		return { status: 404, body: `Table users not found` };
	}
	// console.log(value);


	const asciiSlug = await convertToAsciiSlug(setupBody.fullName);
	const uniqueSlug = await createUniqueSlug('users', asciiSlug);

	const count = await knexInstance('users')
		.where({ id: 1 })
		.update({ name: setupBody.fullName, slug: uniqueSlug, email: setupBody.email, password: setupBody.password });

	if (count > 0) {
		const row = await knexInstance('users').where({ id: 1 }).first();
		return new Response(JSON.stringify({ row }), { status: 200 });
	} else {
		return new Response(JSON.stringify({ error: 'Row not found' }), { status: 404 });
	}
}


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