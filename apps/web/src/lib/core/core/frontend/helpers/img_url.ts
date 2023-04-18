import { ENUM_IMAGE_SIZE } from '$lib/core/shared/enum';

export function img_url(origin: string = '', image: string, size: string = ENUM_IMAGE_SIZE.M) {
	if (image.indexOf('http') == 0) {
		return image;
	}
	let rtnImgUrl = origin + '/images/size/' + size + image;

	// switch (size) {
	// 	case ENUM_IMAGE_SIZE.S:
	// 		rtnImgUrl = '/sizes/' + ENUM_IMAGE_SIZE.S + image;
	// 		break;
	// }

	return rtnImgUrl;
}
