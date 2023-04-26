// import { knexInstance } from '$lib/core/core/server/data/db/connection';
// import { slugify } from 'transliteration';

// export async function createUniqueSlug(params: any): Promise<string> {
//     // console.log('createUniqueSlug: ', slug);

//     const existingSlugCount = await knexInstance(ENUM_DATABASE_TABLE.posts).where('slug', params.slug).count();
//     const count = parseInt(existingSlugCount[0]['count(*)'] || '0', 10);
//     // console.log(count);

//     if (count === 0) {
//         return params.slug;
//     }

//     const newSlug = `${params.slug}-${count}`;
//     return createUniqueSlug(newSlug);
// }
// export async function convertToAsciiSlug(input: string): string {
//     const latinString = slugify(input, { lowercase: true, separator: '-' });
//     return latinString.replace(/[^a-z0-9-]/g, '');
// }