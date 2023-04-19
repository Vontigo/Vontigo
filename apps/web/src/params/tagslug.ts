import type { ParamMatcher } from '@sveltejs/kit';
const regexSafeSlug = /^[a-z0-9]+(?:-[a-z0-9]+)*$/;
const regexNoImageTypes = /^(?:(?!\.(?:jpe?g|png|gif|bmp)$).)*$/;

export const match = ((param) => {
	return regexSafeSlug.test(param) && regexNoImageTypes.test(param);
}) satisfies ParamMatcher;
