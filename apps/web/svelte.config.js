// import preprocess from 'svelte-preprocess';
import { mdsvex } from "mdsvex";
import adapter from '@sveltejs/adapter-auto';
// import adapter from '@sveltejs/adapter-node';
// import adapter from '@sveltejs/adapter-vercel';
import { vitePreprocess } from '@sveltejs/vite-plugin-svelte';//'@sveltejs/kit/vite';

/** @type {import('@sveltejs/kit').Config} */
const config = {
	// Consult https://kit.svelte.dev/docs/integrations#preprocessors
	// for more information about preprocessors
	preprocess: [vitePreprocess(), mdsvex()],

	kit: {
		// adapter-auto only supports some environments, see https://svelte.dev/docs/kit/adapter-auto for a list.
		// If your environment is not supported, or you settled on a specific environment, switch out the adapter.
		// See https://svelte.dev/docs/kit/adapters for more information about adapters.
		adapter: adapter(),
		alias: {
			'@application': 'src/application'
		}
	},

	extensions: [".svelte", ".svx"]
};

export default config;
