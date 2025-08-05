const tailwindcss = require('@tailwindcss/postcss');
const autoprefixer = require('autoprefixer');

const config = {
	plugins: [
		require('postcss-import'),
		tailwindcss(),
		//Some plugins, like tailwindcss/nesting, need to run before Tailwind,
		//But others, like autoprefixer, need to run after,
		autoprefixer
	]
};

module.exports = config;
