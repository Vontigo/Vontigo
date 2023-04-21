import { knexInstance } from '$lib/core/core/server/data/db/connection';
import { ENUM_DATABASE_TABLE } from '$lib/core/shared/enum.js';

// CREATE POST

/** @type {import('./$types').RequestHandler} */
export async function POST({ url, params }) {

    let returnRows: any;

    knexInstance(ENUM_DATABASE_TABLE.posts).insert({
        id: '',
        uuid: '',
        title: '',
        slug: '',
        mobiledoc: '',
        lexical: '',
        html: '',
        comment_id: '',
        plaintext: '',
        feature_image: '',
        featured: '0',
        type: params.type,
        status: 'draft',
        locale: '',
        visibility: 'public',
        email_recipient_filter: '',
        created_at: '',
        created_by: '',
        updated_at: '',
        updated_by: '',
        published_at: '',
        published_by: '',
        custom_excerpt: '',
        codeinjection_head: '',
        codeinjection_foot: '',
        custom_template: '',
        canonical_url: '',
        newsletter_id: ''
    });

    return new Response(JSON.stringify(returnRows), { status: 200 });
}
