import type { RequestHandler } from './$types';
import fs from 'fs';
import path from 'path';

export const PUT = (async ({ url, params, request }) => {
	const resJson = await request.json();
	const filePath = '/static' + resJson.body;
	const fullPath = path.join(process.cwd(), filePath);
	console.log('file to delete:', fullPath);

	try {
		fs.unlinkSync(fullPath);
		console.log(`${filePath} has been deleted!`);
		return new Response(JSON.stringify({ msg: `${filePath} has been deleted!` }), { status: 200 });
	} catch (err) {
		console.error(`Error deleting ${filePath}:`, err);
		return new Response(JSON.stringify({ error: `Error deleting ${filePath}` }), { status: 300 });
	}
}) satisfies RequestHandler;
