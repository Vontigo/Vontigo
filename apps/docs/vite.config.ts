import { sveltekit } from '@sveltejs/kit/vite';
import icons from 'unplugin-icons/vite';
import { defineConfig } from 'vitest/config';
import kitDocs from '@svelteness/kit-docs/node';
export default defineConfig({
	plugins: [icons({ compiler: 'svelte' }), kitDocs(), sveltekit()],
	test: {
		include: ['src/**/*.{test,spec}.{js,ts}']
	}
});
