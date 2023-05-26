import { DATABASE_TYPE } from '$env/static/private';
import { genSlug } from '$lib/core/core/frontend/helpers/slug.js';
import { knexInstance } from '$lib/core/core/server/data/db/connection.js';
import { generateHash } from '$lib/core/core/server/helpers/security/token.js';
import { dynamicDefault } from '$lib/core/core/server/helpers/settings/settings.js';
import { CONST_ONE_DAY_MS, CONST_ONE_HOUR_MS } from '$lib/core/shared/const.js';
import { ENUM_DATABASE_TABLE, ENUM_DATABASE_TYPE } from '$lib/core/shared/enum.js';
import fs from 'fs';

let setupBody = {
	siteTitle: '',
	fullName: '',
	email: '',
	password: ''
};

/** @type {import('./$types').RequestHandler} */
export async function POST({ url, params, request }) {
	const resJson = await request.json();

	if (await initDatabase()) {
		updateSiteInfo({
			value: resJson.siteTitle
		});
		const defaultSettings = updateSettings();

		updateUser(
			{
				name: resJson.fullName,
				slug: await genSlug(ENUM_DATABASE_TABLE.users, resJson.fullName),
				email: resJson.email,
				password: resJson.password
			},
			defaultSettings
		);
	}

	return new Response(JSON.stringify({ message: 'Setup Done!', code: 2000 }), { status: 200 });
}
async function initDatabase() {
	if (DATABASE_TYPE === ENUM_DATABASE_TYPE.postgres) {
		try {
			const dbFilePath = 'database/vontigo.blank.db';
			const destinationPath = 'database/vontigo.db';

			fs.copyFileSync(dbFilePath, destinationPath);

			console.log('File copied successfully!');
			return true;
			//updateData(setupBody);
		} catch (err) {
			console.error(err);
			return false;
		}
	} else {
		const sqlFile = fs.readFileSync('database/migration/pg/1-create-tables.sql', 'utf8');
		await knexInstance
			.raw(sqlFile)
			.then(() => {
				console.log('Migration complete');
				knexInstance.destroy();
			})
			.catch((error) => {
				console.error('Error during migration:', error);
				knexInstance.destroy();
			});
	}
}

async function updateSiteInfo(value: any) {
	// Update site info
	await knexInstance(ENUM_DATABASE_TABLE.settings)
		.where({ value: 'Vontigo' }) // vontigo
		.update(value);
}

async function updateSettings() {
	const defaultSettings = {
		db_hash: dynamicDefault.db_hash(),
		public_hash: dynamicDefault.public_hash(),
		admin_session_secret: dynamicDefault.admin_session_secret(),
		theme_session_secret: dynamicDefault.theme_session_secret(),
		members_public_key: dynamicDefault.members_public_key(),
		members_private_key: dynamicDefault.members_private_key(),
		members_email_auth_secret: dynamicDefault.members_email_auth_secret(),
		vontigo_public_key: dynamicDefault.vontigo_public_key(),
		vontigo_private_key: dynamicDefault.vontigo_private_key()
	};
	for (const key in defaultSettings) {
		if (defaultSettings.hasOwnProperty(key)) {
			const value = defaultSettings[key];
			console.log(`${key}: ${value}`);
			await knexInstance(ENUM_DATABASE_TABLE.settings).where({ key: key }).update({ value: value });
		}
	}
	return defaultSettings;
}

async function updateUser(userInfo: any, defaultSettings: any) {
	// const options = {
	// 	expires: Date.now() + CONST_ONE_DAY_MS, // expires in 1 day
	// 	email: userInfo.email,
	// 	dbHash: 'abc123',
	// 	password: userInfo.password
	// };

	// userInfo.password = generateHash(options);

	// Update user info
	const count = await knexInstance(ENUM_DATABASE_TABLE.users).where({ id: 1 }).update(userInfo);

	const navigation = [
		{
			label: 'Home',
			url: '/'
		},
		{
			label: 'About us',
			url: '/about-us/'
		},
		{
			label: 'Collection',
			url: '/tag/getting-started/'
		},
		{
			label: 'Author',
			url: `/author/${userInfo.slug}/`
		}
	];
	await knexInstance(ENUM_DATABASE_TABLE.settings)
		.where({ key: 'navigation' })
		.update({ value: JSON.stringify(navigation) });

	if (count > 0) {
		return true;
	} else {
		return false;
	}
}
