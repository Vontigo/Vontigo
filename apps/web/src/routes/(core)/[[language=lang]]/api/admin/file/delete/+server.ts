import type { RequestHandler } from './$types';
import fs from 'fs';
import path from 'path';

import { config } from '$lib/themes/casper/config.json';

export const PUT = (async ({ url, params, request }) => {
	const resJson = await request.json();
	const filePath = '/static' + resJson.body;
	const fullPath = path.join(process.cwd(), filePath);
	console.log('file to delete:', fullPath);

	try {
		fs.unlinkSync(fullPath);
		await saveImageWithSizes(fullPath);
		console.log(`${filePath} has been deleted!`);
		return new Response(JSON.stringify({ msg: `${filePath} has been deleted!` }), { status: 200 });
	} catch (err) {
		console.error(`Error deleting ${filePath}:`, err);
		return new Response(JSON.stringify({ error: `Error deleting ${filePath}` }), { status: 300 });
	}
}) satisfies RequestHandler;

async function saveImageWithSizes(fullPath: string) {
	const imageSizes = config.image_sizes;
	for (const sizeKey in imageSizes) {
		const fullPathSize = fullPath.replace('_raw', `w${imageSizes[sizeKey].width}`);
		try {
			fs.unlinkSync(fullPathSize);
			console.log(`${fullPath} has been deleted!`);
		} catch (err) {
			console.error(`Error deleting ${fullPath}:`, err);
		}
	}
}
