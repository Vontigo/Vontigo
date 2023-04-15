import { ENUM_IMAGE_SIZE } from '$lib/core/shared/conts';

export function img_url(origin: string = '', image: string, size: string = ENUM_IMAGE_SIZE.M) {
	let rtnImgUrl = origin + '/images/size/' + size + image;

	// switch (size) {
	// 	case ENUM_IMAGE_SIZE.S:
	// 		rtnImgUrl = '/sizes/' + ENUM_IMAGE_SIZE.S + image;
	// 		break;
	// }

	return rtnImgUrl;
}
