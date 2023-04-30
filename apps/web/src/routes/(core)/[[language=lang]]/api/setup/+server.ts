import fs from 'fs';

/** @type {import('./$types').RequestHandler} */
export async function GET({ url }) {
	try {
		const dbFilePath = 'database/vontigo.blank.db';
		const destinationPath = 'database/vontigo.db';
		fs.copyFileSync(dbFilePath, destinationPath);
		console.log('File copied successfully!');
	} catch (err) {
		console.error(err);
	}

	return new Response(JSON.stringify({ message: 'done' }), { status: 200 });
}
