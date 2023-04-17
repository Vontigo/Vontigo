import knex, { Knex } from 'knex';
import { tables } from '../../schema/schema';

const schemaTables = Object.keys(tables);

export async function up(knex: Knex): Promise<any> {
	try {
		await knex.schema.createTable('newsletters', (table) => {
			table.string('id', 24).notNullable().primary();
			table.string('uuid', 36).notNullable().unique();
			table.string('name', 191).notNullable().unique();
			table.string('description', 2000).nullable();
			table.boolean('feedback_enabled').notNullable().defaultTo(false);
			table.string('slug', 191).notNullable().unique();
			table.string('sender_name', 191).nullable();
			table.string('sender_email', 191).nullable();
			table.string('sender_reply_to', 191).notNullable().defaultTo('newsletter');
			table.enu('status', ['active', 'archived']).notNullable().defaultTo('active');
			table.enu('visibility', ['members']).notNullable().defaultTo('members');
			table.boolean('subscribe_on_signup').notNullable().defaultTo(true);
			table.integer('sort_order').notNullable().unsigned().defaultTo(0);
			table.string('header_image', 2000).nullable();
			table.boolean('show_header_icon').notNullable().defaultTo(true);
			table.boolean('show_header_title').notNullable().defaultTo(true);
			table
				.enu('title_font_category', ['serif', 'sans_serif'])
				.notNullable()
				.defaultTo('sans_serif');
			table.enu('title_alignment', ['center', 'left']).notNullable().defaultTo('center');
			table.boolean('show_feature_image').notNullable().defaultTo(true);
			table
				.enu('body_font_category', ['serif', 'sans_serif'])
				.notNullable()
				.defaultTo('sans_serif');
			table.text('footer_content').nullable();
			table.boolean('show_badge').notNullable().defaultTo(true);
			table.boolean('show_header_name').notNullable().defaultTo(true);
			table.boolean('show_post_title_section').notNullable().defaultTo(true);
			table.boolean('show_comment_cta').notNullable().defaultTo(true);
			table.boolean('show_subscription_details').notNullable().defaultTo(false);
			table.boolean('show_latest_posts').notNullable().defaultTo(false);
			table.enu('background_color', ['light']).notNullable().defaultTo('light');
			table.string('border_color', 50).nullable();
			table.string('title_color', 50).nullable();
			table.dateTime('created_at').notNullable();
			table.dateTime('updated_at').nullable();
		});
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
		// create users table
		await knex.schema.createTable('users', (table) => {
			table.string('id', 24).notNullable().primary();
			table.string('name', 191).notNullable();
			table.string('slug', 191).notNullable().unique();
			table.string('password', 60).notNullable();
			table.string('email', 191).notNullable().unique();
			table.string('profile_image', 2000).nullable();
			table.string('cover_image', 2000).nullable();
			table.text('bio', 'longtext').nullable();
			table.string('website', 2000).nullable();
			table.text('location', 'longtext').nullable();
			table.string('facebook', 2000).nullable();
			table.string('twitter', 2000).nullable();
			table.text('accessibility', 'longtext').nullable();
			table.string('status', 50).notNullable().defaultTo('active');
			table.string('locale', 6).nullable();
			table.string('visibility', 50).notNullable().defaultTo('public');
			table.string('meta_title', 2000).nullable();
			table.string('meta_description', 2000).nullable();
			table.text('tour', 'longtext').nullable();
			table.dateTime('last_seen').nullable();
			table.boolean('comment_notifications').notNullable().defaultTo(true);
			table.boolean('free_member_signup_notification').notNullable().defaultTo(true);
			table.boolean('paid_subscription_started_notification').notNullable().defaultTo(true);
			table.boolean('paid_subscription_canceled_notification').notNullable().defaultTo(false);
			table.boolean('mention_notifications').notNullable().defaultTo(true);
			table.boolean('milestone_notifications').notNullable().defaultTo(true);
			table.dateTime('created_at').notNullable();
			table.string('created_by', 24).notNullable();
			table.dateTime('updated_at').nullable();
			table.string('updated_by', 24).nullable();
		});

		// create posts_authors table
		await knex.schema.createTable('posts_authors', (table) => {
			table.string('id', 24).notNullable().primary();
			table.string('post_id', 24).notNullable().references('posts.id');
			table.string('author_id', 24).notNullable().references('users.id');
			table.integer('sort_order').notNullable().unsigned().defaultTo(0);
		});

		// create roles table
		await knex.schema.createTable('roles', (table) => {
			table.string('id', 24).notNullable().primary();
			table.string('name', 50).notNullable().unique();
			table.string('description', 2000).nullable();
			table.dateTime('created_at').notNullable();
			table.string('created_by', 24).notNullable();
			table.dateTime('updated_at').nullable();
			table.string('updated_by', 24).nullable();
		});

		// create roles_users table
		await knex.schema.createTable('roles_users', (table) => {
			table.string('id', 24).notNullable().primary();
			table.string('role_id', 24).notNullable().references('roles.id');
			table.string('user_id', 24).notNullable().references('users.id');
		});

		await knex.schema.createTable('permissions', (table) => {
			table.string('id', 24).notNullable().primary();
			table.string('name', 50).notNullable().unique();
			table.string('object_type', 50).notNullable();
			table.string('action_type', 50).notNullable();
			table.string('object_id', 24).nullable();
			table.dateTime('created_at').notNullable();
			table.string('created_by', 24).notNullable();
			table.dateTime('updated_at').nullable();
			table.string('updated_by', 24).nullable();
		});
		await knex.schema.createTable('permissions_users', (table) => {
			table.string('id', 24).notNullable().primary();
			table.string('user_id', 24).notNullable();
			table.string('permission_id', 24).notNullable();
		});
		await knex.schema.createTable('permissions_roles', (table) => {
			table.string('id', 24).notNullable().primary();
			table.string('role_id', 24).notNullable();
			table.string('permission_id', 24).notNullable();
		});
	} catch (error) {
		console.log(error);
	}
}

export async function down(knex: Knex): Promise<any> {
	try {
		await knex.schema.dropTableIfExists('newsletters');
		await knex.schema.dropTableIfExists('posts_meta');
		await knex.schema.dropTableIfExists('posts');
		await knex.schema.dropTableIfExists('users');
		await knex.schema.dropTableIfExists('posts_authors');
		await knex.schema.dropTableIfExists('roles');
		await knex.schema.dropTableIfExists('roles_users');
		await knex.schema.dropTableIfExists('permissions');
		await knex.schema.dropTableIfExists('permissions_users');
		await knex.schema.dropTableIfExists('permissions_roles');
	} catch (error) {
		console.log(error);
	}
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
