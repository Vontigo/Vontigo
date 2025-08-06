import { Container } from '@application/Container';

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
		const settingsService = container.getSettingsService();
		
		const groups = await settingsService.getGroups();
		return groups;
	} catch (error) {
		console.error(error);
		return null;
	}
}
