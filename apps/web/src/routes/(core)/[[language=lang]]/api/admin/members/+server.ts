import { Container } from '../../../../../../application/Container';
import type { RequestHandler } from './$types';

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
	try {
		const container = Container.getInstance();
		const memberService = container.getMemberService();
		
		const members = await memberService.getAllMembers();
		return members;
	} catch (error) {
		console.error(error);
		return null;
	}
}
