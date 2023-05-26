// "image_sizes": {
// 	"xxs": {
// 		"width": 30
// 	},
// 	"xs": {
// 		"width": 100
// 	},
// 	"s": {
// 		"width": 300
// 	},
// 	"m": {
// 		"width": 600
// 	},
// 	"l": {
// 		"width": 1000
// 	},
// 	"xl": {
// 		"width": 2000
// 	}
// }

export enum ENUM_DATABASE_TYPE {
	sqlite = 'sqlite',
	postgres = 'postgres'
}

export enum ENUM_USER_ROLE {
	Owner = 'Owner',
	Administrator = 'Administrator'
}

export enum ENUM_IMAGE_SIZE {
	XXS = 'xxs',
	XS = 'xs',
	S = 's',
	M = 'm',
	L = 'l',
	XL = 'xl'
}
export enum ENUM_DATABASE_TABLE {
	posts = 'posts',
	tags = 'tags',
	users = 'users',
	roles = 'roles',
	roles_users = 'roles_users',
	settings = 'settings'
}
export enum ENUM_POSTS_STATUS {
	published = 'published',
	draft = 'draft',
	scheduled = 'scheduled',
	sent = 'sent'
}
export enum ENUM_POST_TYPE {
	post = 'post',
	page = 'page',
	product = 'product'
}

export enum ENUM_APP_TYPE {
	website = 'website',
	base = 'base',
	ecommerce = 'ecommerce'
}
