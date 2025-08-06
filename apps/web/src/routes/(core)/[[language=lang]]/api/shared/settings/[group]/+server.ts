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
		
		const settings = await settingsService.getByGroup(params.group);
		// Return only the public fields for shared endpoint
		return settings.map(setting => ({
			group: setting.group,
			key: setting.key,
			value: setting.value,
			type: setting.type,
			flags: setting.flags
		}));
	} catch (error) {
		console.error(error);
		return null;
	}
}
