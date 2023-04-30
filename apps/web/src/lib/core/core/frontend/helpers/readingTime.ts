/**
 * Word count Utility
 * @param {string} text
 * @returns {integer} word count
 * @description Takes a string and returns the number of words after sanitizing any html
 * This code is taken from https://github.com/sparksuite/simplemde-markdown-editor/blob/6abda7ab68cc20f4aca870eb243747951b90ab04/src/js/simplemde.js#L1054-L1067
 * with extra diacritics character matching.
 **/
function countWords(text) {
	if (!text) {
		return 0;
	}
	// protect against Handlebars.SafeString
	if (Object.prototype.hasOwnProperty.call(text, 'string')) {
		text = text.string;
	}

	text = text.replace(/<(.|\n)*?>/g, ' '); // strip any HTML tags

	const pattern =
		/[a-zA-ZÀ-ÿ0-9_\u0392-\u03c9\u0410-\u04F9]+|[\u4E00-\u9FFF\u3400-\u4dbf\uf900-\ufaff\u3040-\u309f\uac00-\ud7af]+/g;

	const RTLPattern = /([\u0600-\u06ff]+|[\u0591-\u05F4]+)/g;

	const match = text.match(pattern) || text.match(RTLPattern);

	let count = 0;

	if (match === null) {
		return count;
	}

	for (var i = 0; i < match.length; i += 1) {
		if (match[i].charCodeAt(0) >= 0x4e00) {
			count += match[i].length;
		} else {
			count += 1;
		}
	}

	return count;
}

/**
 * Image count Utility
 * @param {string} html
 * @returns {integer} image count
 * @description Takes an HTML string and returns the number of images
 **/
function countImages(html) {
	if (!html) {
		return 0;
	}
	// protect against Handlebars.SafeString
	if (Object.prototype.hasOwnProperty.call(html, 'string')) {
		html = html.string;
	}
	return (html.match(/<img(.|\n)*?>/g) || []).length;
}

function estimatedReadingTimeInMinutes({ wordCount, imageCount }) {
	const wordsPerMinute = 275;
	const wordsPerSecond = wordsPerMinute / 60;
	let readingTimeSeconds = wordCount / wordsPerSecond;

	// add 12 seconds for the first image, 11 for the second, etc. limiting at 3
	for (var i = 12; i > 12 - imageCount; i -= 1) {
		readingTimeSeconds += Math.max(i, 3);
	}

	let readingTimeMinutes = Math.round(readingTimeSeconds / 60);

	return readingTimeMinutes;
}
/**
 * Reading minutes method
 *
 * @param {string} html - HTML that we want to calculate reading time for
 * @param {string} additionalImages - additional images that need to be taken into account outside HTML
 * @returns {number} estimated reading in minutes
 */

function readingMinutes(html, additionalImages) {
	if (!html) {
		return '';
	}

	let imageCount = countImages(html);
	let wordCount = countWords(html);

	if (additionalImages) {
		imageCount += additionalImages;
	}

	return estimatedReadingTimeInMinutes({ wordCount, imageCount });
}

/**
 * Reading Time Helper
 *
 * @param {{html: String, feature_image: [String|null]}} post - post with HTML that we want to calculate reading time for
 * @param {object} options - output options
 * @param {string} [options.minute="1 min read"] - format for reading times <= 1 minute
 * @param {string} [options.minutes="% min read"] - format for reading times > 1 minute
 * @returns {string} estimated reading in minutes
 */

export function readingTime(post, options = {}) {
	if (post == null) return '';
	// console.log(post);

	const minuteStr = typeof options.minute === 'string' ? options.minute : '1 min read';
	const minutesStr = typeof options.minutes === 'string' ? options.minutes : '% min read';

	// TODO: cache?
	// if (!post.html && !post.reading_time) {
	//     return '';
	// }

	let imageCount = 0;

	if (post?.feature_image) {
		imageCount += 1;
	}

	const time = post?.reading_time || readingMinutes(post.html, imageCount);
	let readingTime = '';

	if (time <= 1) {
		readingTime = minuteStr;
	} else {
		readingTime = minutesStr.replace('%', time);
	}

	return readingTime;
}
