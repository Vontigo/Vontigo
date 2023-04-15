import knex, { Knex } from 'knex';

export async function up(knex: Knex): Promise<any> {
	await knex.schema.createTable('posts', (table) => {
		table.string('id', 24).notNullable().primary();
		table.string('uuid', 36).notNullable().unique().index();
		table.string('title', 255).notNullable();
		table.string('slug', 191).notNullable().index();
		table.text('mobiledoc', 'longtext');
		table.text('lexical', 'longtext');
		table.text('markdown', 'longtext');
		table.text('html', 'longtext');
		table.string('comment_id', 50);
		table.text('plaintext', 'longtext');
		table.string('feature_image', 2000);
		table.boolean('featured').notNullable().defaultTo(false);
		table.enum('type', ['post', 'page']).defaultTo('post').notNullable();
		table
			.enum('status', ['published', 'draft', 'scheduled', 'sent'])
			.defaultTo('draft')
			.notNullable();
		table.string('locale', 6);
		table.enum('visibility', ['public']).defaultTo('public').notNullable();
		table.text('email_recipient_filter', 'longtext').notNullable();
		table.dateTime('created_at').notNullable();
		table.string('created_by', 24).notNullable();
		table.dateTime('updated_at');
		table.string('updated_by', 24);
		table.dateTime('published_at');
		table.string('published_by', 24);
		table.string('custom_excerpt', 300);
		table.text('codeinjection_head', 'mediumtext');
		table.text('codeinjection_foot', 'mediumtext');
		table.string('custom_template', 100);
		table.text('canonical_url', 'longtext');
		table.string('newsletter_id', 24).references('id').inTable('newsletters');
		table.unique(['slug', 'type']);
	});

	await knex.schema.createTable('posts_meta', (table) => {
		table.string('id', 24).notNullable().primary();
		table.string('post_id', 24).notNullable().references('id').inTable('posts').unique();
		table.string('og_image', 2000);
		table.string('og_title', 300);
		table.string('og_description', 500);
		table.string('twitter_image', 2000);
		table.string('twitter_title', 300);
		table.string('twitter_description', 500);
		table.string('meta_title', 300);
		table.string('meta_description', 500);
		table.string('email_subject', 300);
		table.text('frontmatter', 'mediumtext');
		table.string('feature_image_alt', 125);
	});
}

export async function down(knex: Knex): Promise<any> {
	await knex.schema.dropTableIfExists('posts_meta');
	await knex.schema.dropTableIfExists('posts');
}

// export function up(options: string) {
// 	const connection = options.connection;

// 	const existingTables = await commands.getTables(connection);
// 	const missingTables = schemaTables.filter((t) => !existingTables.includes(t));

// 	await Promise.mapSeries(missingTables, async (table) => {
// 		logging.info('Creating table: ' + table);
// 		await commands.createTable(table, connection);
// 	});
// }
