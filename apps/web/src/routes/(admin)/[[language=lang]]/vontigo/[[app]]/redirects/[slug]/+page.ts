import type { PageLoad } from "./$types";

export const load = (async ({ fetch, url, params }) => {

    const response = await fetch(`/api/database/redirects/read/${params.slug}`);
    const data = await response.json();

    return {
        record: data.row
    };
}) satisfies PageLoad;