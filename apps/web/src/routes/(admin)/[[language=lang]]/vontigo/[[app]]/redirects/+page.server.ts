import type { PageLoad } from "./$types";

export const load = (async ({fetch}) => {
    const response = await fetch(`/api/database/redirects/read`);
    const data = await response.json();
    return {
        records: data.rows
    };
}) satisfies PageLoad;