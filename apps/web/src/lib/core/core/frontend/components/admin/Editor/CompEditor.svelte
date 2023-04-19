<script lang="ts">
	import './CompEditor.css';

	import StarterKit from '@tiptap/starter-kit';
	import Image from '@tiptap/extension-image';
	import { Editor } from '@tiptap/core';
	import { onMount } from 'svelte';
	import IconBold from '$lib/icons/IconBold.svelte';
	import IconItalic from '$lib/icons/IconItalic.svelte';
	import IconStrike from '$lib/icons/IconStrike.svelte';
	import IconCode from '$lib/icons/IconCode.svelte';
	import IconParagraph from '$lib/icons/IconParagraph.svelte';
	import IconH1 from '$lib/icons/IconH1.svelte';
	import IconH2 from '$lib/icons/IconH2.svelte';
	import IconH3 from '$lib/icons/IconH3.svelte';
	import IconH4 from '$lib/icons/IconH4.svelte';
	import IconH5 from '$lib/icons/IconH5.svelte';
	import IconH6 from '$lib/icons/IconH6.svelte';
	import IconBulletList from '$lib/icons/IconBulletList.svelte';
	import IconOrderedList from '$lib/icons/IconOrderedList.svelte';
	import IconCodeBlock from '$lib/icons/IconCodeBlock.svelte';
	import IconQuotes from '$lib/icons/IconQuotes.svelte';
	import IconSeparator from '$lib/icons/IconSeparator.svelte';
	import IconImage from '$lib/icons/IconImage.svelte';
	import IconUndo from '$lib/icons/IconUndo.svelte';
	import IconRedo from '$lib/icons/IconRedo.svelte';
	import IconTerminal from '$lib/icons/IconTerminal.svelte';

	let element: HTMLDivElement;
	let editor: Editor;

	onMount(() => {
		editor = new Editor({
			element: element,
			extensions: [StarterKit, Image],
			content: `
			  <h2>
				Hi there,
			  </h2>
			  <p>
				this is a <em>basic</em> example of <strong>tiptap</strong>. Sure, there are all kind of basic text styles you’d probably expect from a text editor. But wait until you see the lists:
			  </p>
			  <ul>
				<li>
				  That’s a bullet list with one …
				</li>
				<li>
				  … or two list items.
				</li>
			  </ul>
			  <p>
				Isn’t that great? And all of that is editable. But wait, there’s more. Let’s try a code block:
			  </p>
			  <pre><code class="language-css">body {
		  display: none;
		}</code></pre>
			  <p>
				I know, I know, this is impressive. It’s only the tip of the iceberg though. Give it a try and click a little bit around. Don’t forget to check the other examples too.
			  </p>
			  <blockquote>
				Wow, that’s amazing. Good work, boy! 👏
				<br />
				— Mom
			  </blockquote>
			`,
			onTransaction: () => {
				// force re-render so `editor.isActive` works as expected
				editor = editor;
			}
		});
	});
	const addImage = () => {
		const url = window.prompt('URL');

		if (url) {
			editor.chain().focus().setImage({ src: url }).run();
		}
	};
	const getOutput = () => {
		console.log('__OUTPUT: JSON ', editor.getJSON());
		console.log('__OUTPUT: HTML ', editor.getHTML());
		console.log('__OUTPUT: Text ', editor.getText());
	};
</script>

{#if editor}
	<div>
		<div class="">
			<button
				on:click={() => console.log && editor.chain().focus().toggleBold().run()}
				disabled={!editor.can().chain().focus().toggleBold().run()}
				class="btn p-1 rounded-md {editor.isActive('bold') ? 'is-active' : ''}"
			>
				<IconBold fillColor={editor.isActive('bold') ? 'white' : 'black'} />
			</button>
			<button
				on:click={() => editor.chain().focus().toggleItalic().run()}
				disabled={!editor.can().chain().focus().toggleItalic().run()}
				class="btn p-1 rounded-md {editor.isActive('italic') ? 'is-active' : ''}"
			>
				<IconItalic fillColor={editor.isActive('italic') ? 'white' : 'black'} />
			</button>
			<button
				on:click={() => editor.chain().focus().toggleStrike().run()}
				disabled={!editor.can().chain().focus().toggleStrike().run()}
				class="btn px-2 py-1 rounded-md {editor.isActive('strike') ? 'is-active' : ''}"
			>
				<IconStrike fillColor={editor.isActive('strike') ? 'white' : 'black'} />
			</button>
			<button
				on:click={() => editor.chain().focus().toggleCode().run()}
				disabled={!editor.can().chain().focus().toggleCode().run()}
				class="btn px-2 py-1 rounded-md {editor.isActive('code') ? 'is-active' : ''}"
			>
				<IconCode fillColor={editor.isActive('code') ? 'white' : 'black'} />
			</button>
			<!-- <button on:click={() => editor.chain().focus().unsetAllMarks().run()}> clear marks </button>
			<button on:click={() => editor.chain().focus().clearNodes().run()}> clear nodes </button> -->
			<button
				on:click={() => editor.chain().focus().setParagraph().run()}
				class="btn px-2 py-1 rounded-md {editor.isActive('paragraph') ? 'is-active' : ''}"
			>
				<IconParagraph fillColor={editor.isActive('paragraph') ? 'white' : 'black'} />
			</button>
			<button
				on:click={() => editor.chain().focus().toggleHeading({ level: 1 }).run()}
				class="btn px-2 py-1 rounded-md {editor.isActive('heading', { level: 1 })
					? 'is-active'
					: ''}"
			>
				<IconH1 fillColor={editor.isActive('heading', { level: 1 }) ? 'white' : 'black'} />
			</button>
			<button
				on:click={() => editor.chain().focus().toggleHeading({ level: 2 }).run()}
				class="btn px-2 py-1 rounded-md {editor.isActive('heading', { level: 2 })
					? 'is-active'
					: ''}"
			>
				<IconH2 fillColor={editor.isActive('heading', { level: 2 }) ? 'white' : 'black'} />
			</button>
			<button
				on:click={() => editor.chain().focus().toggleHeading({ level: 3 }).run()}
				class="btn px-2 py-1 rounded-md {editor.isActive('heading', { level: 3 })
					? 'is-active'
					: ''}"
			>
				<IconH3 fillColor={editor.isActive('heading', { level: 3 }) ? 'white' : 'black'} />
			</button>
			<button
				on:click={() => editor.chain().focus().toggleHeading({ level: 4 }).run()}
				class="btn px-2 py-1 rounded-md {editor.isActive('heading', { level: 4 })
					? 'is-active'
					: ''}"
			>
				<IconH4 fillColor={editor.isActive('heading', { level: 4 }) ? 'white' : 'black'} />
			</button>
			<button
				on:click={() => editor.chain().focus().toggleHeading({ level: 5 }).run()}
				class="btn px-2 py-1 rounded-md {editor.isActive('heading', { level: 5 })
					? 'is-active'
					: ''}"
			>
				<IconH5 fillColor={editor.isActive('heading', { level: 5 }) ? 'white' : 'black'} />
			</button>
			<button
				on:click={() => editor.chain().focus().toggleHeading({ level: 6 }).run()}
				class="btn px-2 py-1 rounded-md {editor.isActive('heading', { level: 6 })
					? 'is-active'
					: ''}"
			>
				<IconH6 fillColor={editor.isActive('heading', { level: 6 }) ? 'white' : 'black'} />
			</button>
			<button
				on:click={() => editor.chain().focus().toggleBulletList().run()}
				class="btn px-2 py-1 rounded-md {editor.isActive('bulletList') ? 'is-active' : ''}"
			>
				<IconBulletList fillColor={editor.isActive('bulletList') ? 'white' : 'black'} />
			</button>
			<button
				on:click={() => editor.chain().focus().toggleOrderedList().run()}
				class="btn px-2 py-1 rounded-md {editor.isActive('orderedList') ? 'is-active' : ''}"
			>
				<IconOrderedList fillColor={editor.isActive('orderedList') ? 'white' : 'black'} />
			</button>
			<button
				on:click={() => editor.chain().focus().toggleCodeBlock().run()}
				class="btn px-2 py-1 rounded-md {editor.isActive('codeBlock') ? 'is-active' : ''}"
			>
				<IconCodeBlock fillColor={editor.isActive('codeBlock') ? 'white' : 'black'} />
			</button>
			<button
				on:click={() => editor.chain().focus().toggleBlockquote().run()}
				class="btn px-2 py-1 rounded-md {editor.isActive('blockquote') ? 'is-active' : ''}"
			>
				<IconQuotes fillColor={editor.isActive('blockquote') ? 'white' : 'black'} />
			</button>
			<button
				on:click={() => editor.chain().focus().setHorizontalRule().run()}
				class="btn px-2 py-1 rounded-md"
			>
				<IconSeparator />
			</button>
			<!-- <button on:click={() => editor.chain().focus().setHardBreak().run()}> hard break </button> -->
			<button on:click={() => addImage()} class="btn px-2 py-1 rounded-md">
				<IconImage />
			</button>
			<button
				on:click={() => editor.chain().focus().undo().run()}
				disabled={!editor.can().chain().focus().undo().run()}
				class="btn px-2 py-1 rounded-md"
			>
				<IconUndo />
			</button>
			<button
				on:click={() => editor.chain().focus().redo().run()}
				disabled={!editor.can().chain().focus().redo().run()}
				class="btn px-2 py-1 rounded-md"
			>
				<IconRedo />
			</button>
			<button on:click={() => getOutput()} class="btn px-2 py-1 rounded-md">
				<IconTerminal />
			</button>
		</div>
	</div>
{/if}
<div class="ProseMirror mt-2" bind:this={element} />
