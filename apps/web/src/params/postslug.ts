import type { ParamMatcher } from '@sveltejs/kit';
const regexSafeSlug = /^[a-z0-9]+(?:-[a-z0-9]+)*$/;
const regexNoImageTypes = /^(?:(?!\.(?:jpe?g|png|gif|bmp|ico)$).)*$/;

export const match = ((param) => {
	return regexSafeSlug.test(param) && regexNoImageTypes.test(param) && param.length > 5;
}) satisfies ParamMatcher;
