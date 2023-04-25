
import type { RequestHandler } from './$types';
import fs from 'fs';
import path from 'path';


export const PUT = (async ({ url, params, request }) => {
    const resJson = await request.json();
    const base64Image = resJson.fileBase64.split(';base64,').pop();
    const currentYear = new Date().getFullYear();
    const currentMonth = (new Date().getMonth() + 1).toString().padStart(2, '0');
    const folderPath = `./static/content/images/${currentYear}/${currentMonth}`;
    const filename = resJson.fileName;

    const filePath = path.join(folderPath, filename);

    try {
        // Create the directory if it doesn't exist
        fs.mkdirSync(folderPath, { recursive: true });

        // Write the file
        fs.writeFileSync(filePath, base64Image, { encoding: 'base64' });

        console.log(`${filename} has been saved to ${folderPath}!`);

        return new Response(JSON.stringify({ filePath: filePath }), { status: 200 });
    } catch (err) {
        console.error(`Error saving ${filename} to ${folderPath}:`, err);

        return new Response(JSON.stringify({ error: `Error saving ${filename} to ${folderPath}:` }), { status: 300 });
    }


}) satisfies RequestHandler;