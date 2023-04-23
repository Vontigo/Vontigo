import crypto from 'crypto';
import ObjectID from 'bson-objectid';

/** @type {import('./$types').RequestHandler} */
export async function GET({ url }) {
	const title = 'My Blog Post Title';
	const postId = new ObjectID();
	//console.log(postId); // prints a 64-character hexadecimal string
	return new Response(JSON.stringify({ message: postId }), { status: 200 });
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
