const autoprefixer = require('autoprefixer');

const config = {
	plugins: [
		require('postcss-import'),
		require('@tailwindcss/postcss'),
		//But others, like autoprefixer, need to run after,
		autoprefixer
	]
};

module.exports = config;
