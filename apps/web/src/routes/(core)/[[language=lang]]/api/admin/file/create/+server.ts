import { language } from '$lib/core/shared/stores/site';
import { get } from 'svelte/store';
import type { RequestHandler } from '../$types';
import fs from 'fs';
import path from 'path';
import sharp from 'sharp';

import { config } from '$lib/themes/casper/config.json';

export const PUT = (async ({ url, params, request }) => {
	const resJson = await request.json();
	const base64Image = resJson.fileBase64.split(';base64,').pop();
	const currentYear = new Date().getFullYear();
	const currentMonth = (new Date().getMonth() + 1).toString().padStart(2, '0');
	const folderPath = `./static/content/${get(
		language
	)}/images/size/_raw/${currentYear}/${currentMonth}`;
	const filename = resJson.fileName;

	const filePath = path.join(folderPath, filename);

	try {
		// Create the directory if it doesn't exist
		fs.mkdirSync(folderPath, { recursive: true });

		// Write the file
		fs.writeFileSync(filePath, base64Image, { encoding: 'base64' });
		await saveImageWithSizes(base64Image, filename);

		console.log(`${filename} has been saved to ${folderPath}!`);

		return new Response(JSON.stringify({ filePath: filePath }), { status: 200 });
	} catch (err) {
		console.error(`Error saving ${filename} to ${folderPath}:`, err);

		return new Response(JSON.stringify({ error: `Error saving ${filename} to ${folderPath}:` }), {
			status: 300
		});
	}
}) satisfies RequestHandler;

async function saveImageWithSizes(base64Image: string, filename: string) {
	const imageSizes = config.image_sizes;
	const buffer = Buffer.from(base64Image, 'base64');
	const currentYear = new Date().getFullYear();
	const currentMonth = (new Date().getMonth() + 1).toString().padStart(2, '0');

	// Loop through the image sizes and generate each resized image
	for (const sizeKey in imageSizes) {
		// Get the size object for the current key
		const size = imageSizes[sizeKey];

		// Define the output path for the resized image
		const folderPath = `./static/content/${get(language)}/images/size/w${
			imageSizes[sizeKey].width
		}/${currentYear}/${currentMonth}`;

		// Create the directory if it doesn't exist
		fs.mkdirSync(folderPath, { recursive: true });
		const filePath = path.join(folderPath, filename);

		// Use the Sharp library to resize and save the image
		sharp(buffer)
			.resize(size.width, null)
			.toFile(filePath, (err, info) => {
				if (err) throw err;
				console.log(`Image resized to ${size.width}px: ${filePath}`);
			});
	}
}
