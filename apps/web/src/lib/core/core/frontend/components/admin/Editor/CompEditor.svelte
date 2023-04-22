<script lang="ts">
	// SKELETON
	import { popup, storePopup } from '@skeletonlabs/skeleton';
	import type { PopupSettings } from '@skeletonlabs/skeleton';
	import { computePosition } from '@floating-ui/dom';
	import { Modal, modalStore } from '@skeletonlabs/skeleton';
	import type { ModalSettings, ModalComponent } from '@skeletonlabs/skeleton';
	// SVELTE
	import { onMount } from 'svelte';
	// TIPTAP
	import { Editor } from '@tiptap/core';
	import StarterKit from '@tiptap/starter-kit';
	import Image from '@tiptap/extension-image';
	import CharacterCount from '@tiptap/extension-character-count';
	import FloatingMenu from '@tiptap/extension-floating-menu';
	import Placeholder from '@tiptap/extension-placeholder';
	import TextAlign from '@tiptap/extension-text-align';
	import { generateHTML } from '@tiptap/html';
	import './CompEditor.css';
	// ICONS
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
	import Author from '$lib/themes/casper/Author.svelte';
	import CompAlignRight from '$lib/icons/IconAlignRight.svelte';
	import CompAlignLeft from '$lib/icons/IconAlignLeft.svelte';
	import CompAlignCenter from '$lib/icons/IconAlignCenter.svelte';
	import CompAlignJustify from '$lib/icons/IconAlignJustify.svelte';
	import IconFloatingMenuAdd from '$lib/icons/IconFloatingMenuAdd.svelte';
	import IconSave from '$lib/icons/IconSave.svelte';
	// VARIABLE DEFINE
	export let postData: any;
	let element: HTMLDivElement;
	let floatingMenuHTML: HTMLDivElement;
	let editor: Editor;
	let title: string;
	let imagePopupSettings: PopupSettings = {
		// Set the event as: click | hover | hover-click | focus | focus-click
		event: 'click',
		// Provide a matching 'data-popup' value.
		target: 'imagePopup'
	};
	let mounted = false;
	const prompt: ModalSettings = {
		type: 'prompt',
		// Data
		title: 'Enter Image Url',
		body: 'Provide your image url here.',
		// Populates the input value and attributes
		value: '',
		valueAttr: { type: 'text', required: true },
		// Returns the updated response value
		response: (r: string) => {
			console.log('response:', r);
			if (r) {
				editor.chain().focus().setImage({ src: r }).run();
			}
		}
	};

	let floatingMenuShow = false;
	let enteringTitle = false;
	onMount(() => {
		// console.log(postData.mobiledoc);

		const content = postData
			? generateHTML(JSON.parse(postData.mobiledoc), [StarterKit, Image])
			: '<h1 name="title" id="postTitle"></h1>';
		title = postData ? postData.title : '';
		// console.log(content);

		editor = new Editor({
			element: element,
			extensions: [
				FloatingMenu.configure({
					element: floatingMenuHTML,
					tippyOptions: { duration: 100 },
					shouldShow: ({ editor, view, state, oldState }) => {
						// show the floating within any paragraph
						return editor.isActive('paragraph');
					}
				}),
				StarterKit,
				Image,
				CharacterCount,
				Placeholder.configure({
					placeholder: ({ node }) => {
						// console.log(node.type);

						if (node.type.name === 'heading') {
							return 'What’s the title?';
						}
					}
				}),
				TextAlign.configure({
					types: ['heading', 'paragraph']
				})
			],
			content: content,
			onTransaction: () => {
				// force re-render so `editor.isActive` works as expected
				// console.log('Transaction');

				editor = editor;

				if (editor.isEmpty) {
					// editor.commands.insertContent('<h1 name="title" id="postTitle"></h1>');
					editor.commands.insertContent('<h1 name="title" id="postTitle"></h1>');
				}
				const focusNode = editor.view.domObserver.currentSelection.focusNode;

				if (focusNode && focusNode.classList && focusNode.classList.contains('is-empty')) {
					// console.log(
					// 	editor.view.domObserver.currentSelection.focusNode.classList.contains('is-empty')
					// );
					// const el = editor.view.dom.children[editor.view.dom.children.length - 1];
					// console.log(editor.view.domObserver.currentSelection);
					if (editor.isActive('heading') && focusNode.localName == 'h1') {
						enteringTitle = true;
						console.log('Entering Title');
					} else {
						enteringTitle = false;
					}
					if (editor.isActive('paragraph')) {
						// console.log(el.innerHTML.indexOf(`<br class="ProseMirror-trailingBreak">`));

						// let position = {
						// 	left: 0,
						// 	top: 0
						// };
						if (editor.isActive({ textAlign: 'left' })) {
							computePosition(focusNode, floatingMenuHTML, {
								placement: 'left' // 'bottom' by default
							}).then(({ x, y }) => {
								Object.assign(floatingMenuHTML.style, {
									left: `${x + floatingMenuHTML.clientWidth}px`,
									right: 'unset',
									top: `${y}px`
								});
							});
						} else if (editor.isActive({ textAlign: 'center' })) {
							computePosition(focusNode, floatingMenuHTML, {
								placement: 'bottom' // 'bottom' by default
							}).then(({ x, y }) => {
								Object.assign(floatingMenuHTML.style, {
									left: `${x}px`,
									right: 'unset',
									top: `${y}px`
								});
							});
						} else if (editor.isActive({ textAlign: 'right' })) {
							computePosition(focusNode, floatingMenuHTML, {
								placement: 'left' // 'bottom' by default
							}).then(({ x, y }) => {
								Object.assign(floatingMenuHTML.style, {
									left: 'unset',
									right: `${30}px`,
									top: `${y}px`
								});
							});
						}
						// console.log(el.innerHTML);

						// console.log(el.innerHTML.replaceAll(`<br class="ProseMirror-trailingBreak">`, ''));

						// computePosition(focusNode, floatingMenuHTML, {
						// 	placement: 'left' // 'bottom' by default
						// }).then(({ x, y }) => {
						// 	Object.assign(floatingMenuHTML.style, {
						// 		left: `${20}px`,
						// 		top: `${y}px`
						// 	});
						// });
						floatingMenuShow = true;
					} else {
						floatingMenuShow = false;
					}
				} else {
					floatingMenuShow = false;
				}
			},
			autofocus: true,

			onUpdate({ editor }) {
				// const focusNode = editor.view.domObserver.currentSelection.focusNode;
				// console.log(focusNode);
				// The editor is focused.
				// const el = editor.view.dom.children[editor.view.dom.children.length - 1];
				// if (editor.isActive('paragraph') && el.classList.contains('is-empty')) {
				// 	// console.log(el.innerHTML.indexOf(`<br class="ProseMirror-trailingBreak">`));
				// 	// console.log(el.innerHTML);
				// 	// console.log(el.innerHTML.replaceAll(`<br class="ProseMirror-trailingBreak">`, ''));
				// 	computePosition(el, floatingMenuHTML, {
				// 		placement: 'left' // 'bottom' by default
				// 	}).then(({ x, y }) => {
				// 		Object.assign(floatingMenuHTML.style, {
				// 			left: `${20}px`,
				// 			top: `${y}px`
				// 		});
				// 	});
				// 	floatingMenuShow = true;
				// } else {
				// 	floatingMenuShow = false;
				// }
			}
			// onUpdate({ editor }) {
			// 	// The editor is focused.
			// 	const el = editor.view.dom.children[editor.view.dom.children.length - 1];
			// 	if (editor.isActive('paragraph')) {
			// 		if (el.innerHTML.replaceAll(`<br class="ProseMirror-trailingBreak">`, '') === '') {
			// 			floatingMenuShow = true;
			// 			computePosition(el, floatingMenuHTML, {
			// 				placement: 'left' // 'bottom' by default
			// 			}).then(({ x, y }) => {
			// 				Object.assign(floatingMenuHTML.style, {
			// 					left: `${x - 12}px`,
			// 					top: `${y}px`
			// 				});
			// 			});
			// 		} else {
			// 			floatingMenuShow = false;
			// 		}
			// 	}
			// }
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
		// console.log('__OUTPUT: HTML ', editor.getHTML());
		// console.log('__OUTPUT: Text ', editor.getText());
	};
	let editorHeight;
	let stickyEditorHeight;
</script>

{#if editor}
	<div class="sticky top-0 overflow-hidden z-10" bind:clientHeight={stickyEditorHeight}>
		<div class="flex flex-row flex-wrap p-2 bg-black opacity-100 w-full">
			<!-- <div class="flex flex-row"> -->
			<button
				on:click={() => editor.chain().focus().toggleBold().run()}
				disabled={!editor.can().chain().focus().toggleBold().run() || enteringTitle}
				class="btn px-2 py-1 rounded-md {editor.isActive('bold') ? 'is-active' : ''}"
			>
				<IconBold fillColor={editor.isActive('bold') ? 'white' : 'white'} />
			</button>
			<button
				on:click={() => editor.chain().focus().toggleItalic().run()}
				disabled={!editor.can().chain().focus().toggleItalic().run() || enteringTitle}
				class="btn px-2 py-1 rounded-md {editor.isActive('italic') ? 'is-active' : ''}"
			>
				<IconItalic fillColor={editor.isActive('italic') ? 'white' : 'white'} />
			</button>
			<button
				on:click={() => editor.chain().focus().toggleStrike().run()}
				disabled={!editor.can().chain().focus().toggleStrike().run() || enteringTitle}
				class="btn px-2 py-1 rounded-md {editor.isActive('strike') ? 'is-active' : ''}"
			>
				<IconStrike fillColor={editor.isActive('strike') ? 'white' : 'white'} />
			</button>
			<button
				on:click={() => editor.chain().focus().toggleCode().run()}
				disabled={!editor.can().chain().focus().toggleCode().run() || enteringTitle}
				class="btn px-2 py-1 rounded-md {editor.isActive('code') ? 'is-active' : ''}"
			>
				<IconCode fillColor={editor.isActive('code') ? 'white' : 'white'} />
			</button>
			<!-- </div> -->

			<span class="divider-vertical mx-2 hidden md:block" />
			<!-- <button on:click={() => editor.chain().focus().unsetAllMarks().run()}> clear marks </button>
			<button on:click={() => editor.chain().focus().clearNodes().run()}> clear nodes </button> -->
			<!-- <div class="flex flex-row"> -->
			<button
				on:click={() => editor.chain().focus().setParagraph().run()}
				disabled={enteringTitle}
				class="btn px-2 py-1 rounded-md {editor.isActive('paragraph') ? 'is-active' : ''}"
			>
				<IconParagraph fillColor={editor.isActive('paragraph') ? 'white' : 'white'} />
			</button>
			<button
				on:click={() => editor.chain().focus().toggleHeading({ level: 1 }).run()}
				disabled={enteringTitle}
				class="btn px-2 py-1 rounded-md {editor.isActive('heading', { level: 1 })
					? 'is-active'
					: ''}"
			>
				<IconH1 fillColor={editor.isActive('heading', { level: 1 }) ? 'white' : 'white'} />
			</button>
			<button
				on:click={() => editor.chain().focus().toggleHeading({ level: 2 }).run()}
				disabled={enteringTitle}
				class="btn px-2 py-1 rounded-md {editor.isActive('heading', { level: 2 })
					? 'is-active'
					: ''}"
			>
				<IconH2 fillColor={editor.isActive('heading', { level: 2 }) ? 'white' : 'white'} />
			</button>
			<button
				on:click={() => editor.chain().focus().toggleHeading({ level: 3 }).run()}
				disabled={enteringTitle}
				class="btn px-2 py-1 rounded-md {editor.isActive('heading', { level: 3 })
					? 'is-active'
					: ''}"
			>
				<IconH3 fillColor={editor.isActive('heading', { level: 3 }) ? 'white' : 'white'} />
			</button>
			<button
				on:click={() => editor.chain().focus().toggleHeading({ level: 4 }).run()}
				disabled={enteringTitle}
				class="btn px-2 py-1 rounded-md {editor.isActive('heading', { level: 4 })
					? 'is-active'
					: ''}"
			>
				<IconH4 fillColor={editor.isActive('heading', { level: 4 }) ? 'white' : 'white'} />
			</button>
			<button
				on:click={() => editor.chain().focus().toggleHeading({ level: 5 }).run()}
				disabled={enteringTitle}
				class="btn px-2 py-1 rounded-md {editor.isActive('heading', { level: 5 })
					? 'is-active'
					: ''}"
			>
				<IconH5 fillColor={editor.isActive('heading', { level: 5 }) ? 'white' : 'white'} />
			</button>
			<button
				on:click={() => editor.chain().focus().toggleHeading({ level: 6 }).run()}
				disabled={enteringTitle}
				class="btn px-2 py-1 rounded-md {editor.isActive('heading', { level: 6 })
					? 'is-active'
					: ''}"
			>
				<IconH6 fillColor={editor.isActive('heading', { level: 6 }) ? 'white' : 'white'} />
			</button>
			<!-- </div> -->
			<span class="divider-vertical mx-2 hidden md:block" />
			<!-- <div class="flex flex-row"> -->
			<button
				on:click={() => editor.chain().focus().setTextAlign('left').run()}
				disabled={enteringTitle}
				class="btn px-2 py-1 rounded-md text-white {editor.isActive({ textAlign: 'left' })
					? 'is-active'
					: ''}"
			>
				<CompAlignLeft fillColor={editor.isActive({ textAlign: 'left' }) ? 'white' : 'white'} />
			</button>
			<button
				on:click={() => editor.chain().focus().setTextAlign('center').run()}
				disabled={enteringTitle}
				class="btn px-2 py-1 rounded-md text-white {editor.isActive({ textAlign: 'center' })
					? 'is-active'
					: ''}"
			>
				<CompAlignCenter fillColor={editor.isActive({ textAlign: 'center' }) ? 'white' : 'white'} />
			</button>
			<button
				on:click={() => editor.chain().focus().setTextAlign('right').run()}
				disabled={enteringTitle}
				class="btn px-2 py-1 rounded-md text-white {editor.isActive({ textAlign: 'right' })
					? 'is-active'
					: ''}"
			>
				<CompAlignRight fillColor={editor.isActive({ textAlign: 'right' }) ? 'white' : 'white'} />
			</button>
			<button
				on:click={() => editor.chain().focus().setTextAlign('justify').run()}
				disabled={enteringTitle}
				class="btn px-2 py-1 rounded-md text-white {editor.isActive({ textAlign: 'justify' })
					? 'is-active'
					: ''}"
			>
				<CompAlignJustify
					fillColor={editor.isActive({ textAlign: 'justify' }) ? 'white' : 'white'}
				/>
			</button>
			<!-- <button
					on:click={() => editor.chain().focus().toggleBulletList().run()}
					class="btn px-2 py-1 rounded-md {editor.isActive('bulletList') ? 'is-active' : ''}"
				>
					<IconBulletList fillColor={editor.isActive('bulletList') ? 'white' : 'white'} />
				</button>
				<button
					on:click={() => editor.chain().focus().toggleOrderedList().run()}
					class="btn px-2 py-1 rounded-md {editor.isActive('orderedList') ? 'is-active' : ''}"
				>
					<IconOrderedList fillColor={editor.isActive('orderedList') ? 'white' : 'white'} />
				</button>
				<button
					on:click={() => editor.chain().focus().toggleCodeBlock().run()}
					class="btn px-2 py-1 rounded-md {editor.isActive('codeBlock') ? 'is-active' : ''}"
				>
					<IconCodeBlock fillColor={editor.isActive('codeBlock') ? 'white' : 'white'} />
				</button>
				<button
					on:click={() => editor.chain().focus().toggleBlockquote().run()}
					class="btn px-2 py-1 rounded-md {editor.isActive('blockquote') ? 'is-active' : ''}"
				>
					<IconQuotes fillColor={editor.isActive('blockquote') ? 'white' : 'white'} />
				</button>
				<button
					on:click={() => editor.chain().focus().setHorizontalRule().run()}
					class="btn px-2 py-1 rounded-md"
				>
					<IconSeparator fillColor="white" />
				</button>
				<button use:popup={imagePopupSettings} class="btn px-2 py-1 rounded-md">
					<IconImage fillColor="white" />
				</button> -->
			<button
				on:click={() => editor.chain().focus().undo().run()}
				disabled={!editor.can().chain().focus().undo().run() || enteringTitle}
				class="btn px-2 py-1 rounded-md"
			>
				<IconUndo fillColor="white" />
			</button>
			<button
				on:click={() => editor.chain().focus().redo().run()}
				disabled={!editor.can().chain().focus().redo().run() || enteringTitle}
				class="btn px-2 py-1 rounded-md"
			>
				<IconRedo fillColor="white" />
			</button>
			<button on:click={() => getOutput()} class="btn px-2 py-1 rounded-md">
				<IconTerminal fillColor="white" />
			</button>
			<button
				on:click={() => console.log('Save')}
				class="btn px-2 py-1 bg-primary-500 rounded-md text-white"
			>
				<span><IconSave fillColor="white" /></span>
				<span>Save</span>
			</button>
			<!-- </div> -->
		</div>
	</div>
{/if}
<!-- <input
	type="text"
	placeholder="What's the title?"
	name=""
	id=""
	class="input border-none bg-none bg-transparent p-3 text-lg focus-visible:outline-none"
	bind:value={title}
/> -->
<div
	class="p-3 pr-0 overflow-x-hidden overflow-y-auto"
	style="height: calc(100vh - {stickyEditorHeight}px - 2rem);"
	bind:this={element}
/>

{#if editor}
	<div
		id="tooltip"
		style="position: absolute;"
		class="p-2 z-10 h-4"
		class:hidden={!floatingMenuShow}
		bind:this={floatingMenuHTML}
	>
		<div class="flex flex-row justify-start">
			<button
				on:click={() => {
					// console.log(editor);

					editor.chain().focus().toggleBulletList().run();
				}}
				class="flex-auto w-auto btn hover:bg-surface-500 px-2 py-1 rounded-md justify-start {editor.isActive(
					'bulletList'
				)
					? 'is-active'
					: ''}"
			>
				<span>
					<IconBulletList fillColor={editor.isActive('bulletList') ? 'white' : 'black'} />
				</span>
				<!-- <span>Bullet List</span> -->
			</button>
			<button
				on:click={() => editor.chain().focus().toggleOrderedList().run()}
				class="flex-auto w-auto btn hover:bg-surface-500 px-2 py-1 rounded-md justify-start {editor.isActive(
					'orderedList'
				)
					? 'is-active'
					: ''}"
			>
				<span
					><IconOrderedList fillColor={editor.isActive('orderedList') ? 'white' : 'black'} /></span
				>
				<!-- <span>Ordered List</span> -->
			</button>
			<button
				on:click={() => editor.chain().focus().toggleCodeBlock().run()}
				class="flex-auto w-auto btn hover:bg-surface-500 px-2 py-1 rounded-md justify-start {editor.isActive(
					'codeBlock'
				)
					? 'is-active'
					: ''}"
			>
				<span><IconCodeBlock fillColor={editor.isActive('codeBlock') ? 'white' : 'black'} /></span>
				<!-- <span>Code Block</span> -->
			</button>
			<button
				on:click={() => editor.chain().focus().toggleBlockquote().run()}
				class="flex-auto w-auto btn hover:bg-surface-500 px-2 py-1 rounded-md justify-start"
			>
				<span><IconQuotes fillColor="black" /></span>
				<!-- <span class="">Quotes</span> -->
			</button>
			<!-- <button
					class="flex-auto w-auto btn hover:bg-surface-500 px-2 py-1 rounded-md justify-start"
					on:click={() => editor.chain().focus().setHorizontalRule().run()}
				>
					<span><IconSeparator fillColor="black" /></span>
					<span>Seperator</span>
				</button> -->

			<button
				on:click={() => {
					modalStore.trigger(prompt);
				}}
				class="flex-auto w-auto btn hover:bg-surface-500 px-2 py-1 rounded-md justify-start"
			>
				<span><IconImage fillColor="black" /></span>
				<!-- <span class="">Image</span> -->
				<div class="card variant-filled-secondary p-4" data-popup="imagePopup">
					Some text goes here.
					<div class="arrow variant-filled-secondary" />
				</div>
			</button>
		</div>
	</div>
	<!-- <div class="character-count p-3 absolute bottom-0">
			{editor.storage.characterCount.characters()} characters -
			{editor.storage.characterCount.words()} words
		</div> -->

	<!-- <FloatingMenu {editor} tippyOptions={{ duration: 100 }}>
		<button
			on:click={() => editor.chain().focus().toggleHeading({ level: 1 }).run()}
			class={editor.isActive('heading', { level: 1 }) ? 'is-active' : ''}
		>
			h1
		</button>
		<button
			on:click={() => editor.chain().focus().toggleHeading({ level: 2 }).run()}
			class={editor.isActive('heading', { level: 2 }) ? 'is-active' : ''}
		>
			h2
		</button>
		<button
			on:click={() => editor.chain().focus().toggleBulletList().run()}
			class={editor.isActive('bulletList') ? 'is-active' : ''}
		>
			bullet list
		</button>
	</FloatingMenu> -->
{/if}

<Modal />

<style lang="postcss" global>
	button.is-active {
		@apply bg-slate-600;
	}
	p.is-empty.is-editor-empty {
		content: attr(data-placeholder);
	}
</style>
