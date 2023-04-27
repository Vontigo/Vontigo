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
		textareaHeight = `${textareaRef.scrollHeight}px`;
		rows = Math.ceil(textareaRef.scrollHeight / (parentFontSize * 1.2));
		dispatch('input');
	};

	onMount(() => {
		const parentEl = textareaRef.parentElement;
		parentFontSize = parseFloat(getComputedStyle(parentEl).fontSize);
		handleInput();
	});
</script>

<textarea
	bind:value
	bind:this={textareaRef}
	{rows}
	on:input={handleInput}
	style={`height: ${textareaHeight}px;`}
	{...$$restProps}
	class={classes}
	{placeholder}
/>
