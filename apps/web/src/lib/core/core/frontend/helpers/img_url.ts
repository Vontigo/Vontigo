import { ENUM_IMAGE_SIZE } from '$lib/core/shared/enum';

import { config } from '$lib/themes/casper/config.json';

export function img_url(image: string, sizeKey: string = ENUM_IMAGE_SIZE.M) {
	const imageSizes = config.image_sizes;
	const filePath = image.replace('_raw', `w${imageSizes[sizeKey].width}`);

	// if (image.indexOf('http') == 0) {
	// 	return image;
	// }
	// let rtnImgUrl = origin + '/images/size/' + size + image;

	// switch (size) {
	// 	case ENUM_IMAGE_SIZE.S:
	// 		rtnImgUrl = '/sizes/' + ENUM_IMAGE_SIZE.S + image;
	// 		break;
	// }

	return filePath;
}
