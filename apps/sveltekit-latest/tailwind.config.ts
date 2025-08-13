import type { Config } from 'tailwindcss';
import forms from '@tailwindcss/forms';
import typography from '@tailwindcss/typography';
import containerQueries from '@tailwindcss/container-queries';

const config = {
	darkMode: 'class',
	content: ['./src/**/*.{html,js,svelte,ts}', './src/stories/**/*.{js,ts,svelte,mdx}'],
	theme: {
		extend: {}
	},
	plugins: [forms, typography, containerQueries]
} satisfies Config;

export default config;
