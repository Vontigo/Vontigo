<script lang="ts">
	import { onMount, createEventDispatcher } from 'svelte';

	export let value: string;
	export let classes: string;
	export let placeholder: string;
	const dispatch = createEventDispatcher();

	let textareaRef: any;
	let textareaHeight = 'auto';
	let rows = 1;
	let parentFontSize: number;

	const handleInput = () => {
		textareaRef.style.height = '0px';
		textareaHeight = textareaRef.scrollHeight + 8;
		textareaRef.style.height = `${textareaHeight}px`;
		rows = Math.ceil(textareaRef.scrollHeight / (parentFontSize * 1.2));
		dispatch('input');
	};
	const handleDelete = (event) => {
		if (event.key === 'Backspace' || event.key === 'Delete' || event.key === 'Enter') {
			handleInput();
		}
	};

	onMount(() => {
		const parentEl = textareaRef.parentElement;
		parentFontSize = parseFloat(getComputedStyle(parentEl).fontSize);
		handleInput();
	});
	$: if (value) {
		value = value.replace(/[\r\n]/g, '');
	}
</script>

<textarea
	bind:value
	bind:this={textareaRef}
	{rows}
	on:input={handleInput}
	on:keydown={handleDelete}
	style={`height: ${textareaHeight}px;`}
	{...$$restProps}
	class={classes}
	{placeholder}
	tabindex="0"
/>

<style>
	textarea:focus-visible {
		@apply outline-none;
	}
</style>
