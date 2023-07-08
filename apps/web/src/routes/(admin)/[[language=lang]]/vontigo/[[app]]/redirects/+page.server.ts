import type { PageLoad } from "./$types";

export const load = (async () => {
    return {
        redirects: [
            {
                slug: 'a',
                from: '/a',
                to: '/b',
                status: 301,
            },
            {
                slug: 'c',
                from: '/c',
                to: '/d',
                status: 302,
            },
        ]
    };
}) satisfies PageLoad;