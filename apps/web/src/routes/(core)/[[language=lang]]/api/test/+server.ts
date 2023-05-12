import crypto from 'node:crypto';
import ObjectID from 'bson-objectid';
import { v4 as uuidv4 } from 'uuid';

/** @type {import('./$types').RequestHandler} */
export async function GET({ url }) {
	// const title = 'My Blog Post Title';
	// const postId = new ObjectID();
	//console.log(postId); // prints a 64-character hexadecimal string
	return new Response(JSON.stringify({ message: uuidv4() }), { status: 200 });
}

function generatePostId(title: string): string {
	const hash = crypto.createHash('sha256').update(title).digest('hex');
	return hash;
}
function generateId(): string {
	const timestamp = Date.now().toString(36);
	const randomStr = Math.random().toString(36).substr(2, 6);
	return `${timestamp}${randomStr}`.substr(0, 24);
}
