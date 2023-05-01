
import { slugify } from 'transliteration';
import { knexInstance } from '$lib/core/core/server/data/db/connection.js';

export async function genSlug(table: string, input: string) {
    const asciiSlug = await convertToAsciiSlug(input);
    const uniqueSlug = await createUniqueSlug(table, asciiSlug);

    return uniqueSlug;
}
export async function createUniqueSlug(table: string, slug: string): Promise<string> {
    // console.log('createUniqueSlug: ', slug);

    const existingSlugCount = await knexInstance(table).where('slug', slug).count();
    const count = parseInt(existingSlugCount[0]['count(*)'] || '0', 10);
    // console.log(count);

    if (count === 0) {
        return slug;
    }

    const newSlug = `${slug}-${count}`;
    return createUniqueSlug(table, newSlug);
}

export async function convertToAsciiSlug(input: string): string {
    const latinString = slugify(input, { lowercase: true, separator: '-' });
    return latinString.replace(/[^a-z0-9-]/g, '');
}