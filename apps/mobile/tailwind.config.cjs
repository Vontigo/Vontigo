/** @type {import('tailwindcss').Config} */
const config = {
	darkMode: 'class',
	content: [
		'./src/**/*.{html,js,svelte,ts}'
	],
	theme: {
		extend: {}
	},
	plugins: [
		require('daisyui')
	],
	daisyui: {
		themes: ["light", "dark"]
	}
};

module.exports = config;
