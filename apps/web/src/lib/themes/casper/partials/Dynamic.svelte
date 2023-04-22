<script lang="ts">
	// import { onMount } from 'svelte';
	// import * as svelte from 'svelte/compiler';

	// let container: HTMLDivElement;

	// onMount(async () => {
	// 	// Define the name of the Svelte component file you want to load
	// 	const componentFile = '/api/theme';

	// 	// Fetch the Svelte component file
	// 	const response = await fetch(componentFile);
	// 	const source = `<p>Hello!</p>`; //await response.text();

	// 	// Compile the component source code into a JavaScript module
	// 	const { js, css, ast, warnings, vars, stats } = svelte.compile(source, { format: 'esm' });

	// 	console.log('__________________', js.code);

	// 	// Create a blob URL for the compiled JavaScript code
	// 	const blob = new Blob([js], { type: 'application/javascript' });
	// 	const url = URL.createObjectURL(blob);

	// 	// Import the module and create a new instance of the component
	// 	const { default: Component } = await import(/* @vite-ignore */ url);
	// 	new Component({ target: container });

	// 	// // Compile the component source code into a JavaScript module
	// 	// const module = new Function('return ' + js)();

	// 	// // Create a new instance of the component and mount it inside the container element
	// 	// const Component = module.default;
	// 	// new Component({ target: container });
	// });
	let IconFire: any;
	import('./icons/IconFire.svelte').then((res) => (IconFire = res.default));
</script>

<svelte:component this={IconFire} />
