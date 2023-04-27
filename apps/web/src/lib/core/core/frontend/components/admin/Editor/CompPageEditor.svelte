<script lang="ts">
	// SKELETON
	import { popup, storePopup, toastStore, type ToastSettings, Toast } from '@skeletonlabs/skeleton';
	import type { PopupSettings } from '@skeletonlabs/skeleton';
	import { computePosition } from '@floating-ui/dom';
	import { Modal, modalStore } from '@skeletonlabs/skeleton';
	import type { ModalSettings, ModalComponent } from '@skeletonlabs/skeleton';
	import { FileDropzone } from '@skeletonlabs/skeleton';
	// SVELTE
	import { onMount } from 'svelte';
	import ObjectID from 'bson-objectid';
	import { v4 as uuidv4 } from 'uuid';
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
	import IconPlusSmall from '$lib/icons/IconPlusSmall.svelte';
	import { slugify } from 'transliteration';
	import { ENUM_POSTS_STATUS } from '$lib/core/shared/enum';

	// VARIABLE DEFINE
	export let data: any;
	let element: HTMLDivElement;
	let floatingMenuHTML: HTMLDivElement;
	let editor: Editor;
	let title: string;
	let newPost: any;
	let featureImage: any;
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
	onMount(async () => {
		// console.log(postData.mobiledoc);
		if (data && data.id) {
			const resData = await fetch(`/api/database/posts/read/${data.id}`);
			const resDataJson = await resData.json();
			if (resDataJson.row) {
				data = resDataJson.row;
			}
		}
		const content = data
			? generateHTML(JSON.parse(data.mobiledoc), [StarterKit, Image])
			: '<p></p>';
		title = data ? data.title : '';
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

				// if (editor.isEmpty) {
				// 	// editor.commands.insertContent('<h1 name="title" id="postTitle"></h1>');
				// 	editor.commands.insertContent('<h1 name="title" id="postTitle"></h1>');
				// }
				const focusNode = editor.view.domObserver.currentSelection.focusNode;

				if (focusNode && focusNode.classList && focusNode.classList.contains('is-empty')) {
					// console.log(
					// 	editor.view.domObserver.currentSelection.focusNode.classList.contains('is-empty')
					// );
					// const el = editor.view.dom.children[editor.view.dom.children.length - 1];
					// console.log(editor.view.domObserver.currentSelection);
					// if (editor.isActive('heading') && focusNode.localName == 'h1') {
					// 	enteringTitle = true;
					// 	console.log('Entering Title');
					// } else {
					// 	enteringTitle = false;
					// }
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
									left: `${x + 10 + floatingMenuHTML.clientWidth}px`,
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
	// async function updateField(id: string, field: string, value: any) {
	// 	// console.log(encodeURIComponent(value));
	// 	// console.log(value);

	// 	const resData = await fetch(`/api/database/posts/put/${id}/${field}/${value}`, {
	// 		method: 'PUT',
	// 		body: JSON.stringify(value)
	// 	});
	// 	const resDataJson = await resData.json();
	// 	if (resDataJson.row) {
	// 		const t: ToastSettings = {
	// 			message: `Post saved!`,
	// 			timeout: 2000
	// 		};
	// 		toastStore.trigger(t);
	// 	}
	// }
	async function submitPost(id: string, body: any) {
		if (data && data.id) {
			const title = editor.getJSON().content[0];
			// let title;
			// if(editorJson) title = editorJson.content[0];

			console.log(title);

			if (title.type == 'heading' && title.attrs.level && title.attrs.level == 1) {
				// console.log('OK');
				body.title = title.content[0].text;
				const requestOptions = {
					method: 'PUT',
					headers: { 'Content-Type': 'application/json' },
					body: JSON.stringify(body)
				};

				const resData = await fetch(`/api/database/posts/update/${id}`, requestOptions);
				const resDataJson = await resData.json();
				if (resDataJson.row) {
					const t: ToastSettings = {
						message: `Post saved!`,
						timeout: 2000
					};
					toastStore.trigger(t);
				}
			} else {
				const t: ToastSettings = {
					message: `First heading must be H1.`,
					timeout: 2000
				};
				toastStore.trigger(t);
			}
		} else {
			const slug = slugify(title);

			newPost = {
				id: new ObjectID(),
				uuid: uuidv4(),
				title: title,
				slug: slug,
				mobiledoc: JSON.stringify(editor.getJSON()),
				html: editor.getHTML(),
				plaintext: editor.getText(),
				feature_image: featureImage,
				featured: '0',
				type: 'post',
				status: ENUM_POSTS_STATUS.draft,
				locale: '',
				visibility: 'public',
				email_recipient_filter: 'all',
				created_at: new Date(),
				created_by: '1'
			};
			const requestOptions = {
				method: 'POST',
				headers: { 'Content-Type': 'application/json' },
				body: JSON.stringify(newPost)
			};
			const resData = await fetch(`/api/database/posts/create`, requestOptions);
			const resDataJson = await resData.json();
			if (resDataJson.row) {
				const t: ToastSettings = {
					message: `Post saved!`,
					timeout: 2000
				};
				toastStore.trigger(t);
			}
		}
	}

	async function updateAllFields(id: string, body: any) {
		const title = editor.getJSON().content[0];
		// let title;
		// if(editorJson) title = editorJson.content[0];

		console.log(title);

		if (title.type == 'heading' && title.attrs.level && title.attrs.level == 1) {
			// console.log('OK');
			body.title = title.content[0].text;
			const requestOptions = {
				method: 'PUT',
				headers: { 'Content-Type': 'application/json' },
				body: JSON.stringify(body)
			};

			const resData = await fetch(`/api/database/posts/update/${id}`, requestOptions);
			const resDataJson = await resData.json();
			if (resDataJson.row) {
				const t: ToastSettings = {
					message: `Post saved!`,
					timeout: 2000
				};
				toastStore.trigger(t);
			}
		} else {
			const t: ToastSettings = {
				message: `First heading must be H1.`,
				timeout: 2000
			};
			toastStore.trigger(t);
		}
	}
	const addImage = () => {
		const url = window.prompt('URL');

		if (url) {
			editor.chain().focus().setImage({ src: url }).run();
		}
	};
	const getOutput = () => {
		console.log('__OUTPUT: JSON ', editor.getJSON());
		// console.log(encodeURIComponent(editor.getJSON().toString()));
		// console.log('__OUTPUT: HTML ', editor.getHTML());
		// console.log('__OUTPUT: Text ', editor.getText());
	};

	async function onChangeHandler(e: Event) {
		const file = e.target.files[0];
		const reader = new FileReader();
		reader.onloadend = () => {
			console.log(reader.result);
			featureImage = reader.result;
			// Logs data:<type>;base64,wL2dvYWwgbW9yZ...
		};
		reader.readAsDataURL(file);
		// featureImage = await toBase64ImageFile(e);
		// console.log('file data:', await featureImage);
	}
	let editorHeight;
	let stickyEditorHeight;
</script>

<div id="editorElement">
	<div
		id="postContent"
		class="p-3 pt-0 pr-0 overflow-x-hidden overflow-y-auto"
		style="height: calc(100vh - {stickyEditorHeight}px - 2rem);"
		bind:this={element}
	/>

	{#if editor}
		<div id="tooltip" class="" class:hidden={!floatingMenuShow} bind:this={floatingMenuHTML}>
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
						><IconOrderedList
							fillColor={editor.isActive('orderedList') ? 'white' : 'black'}
						/></span
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
					<span><IconCodeBlock fillColor={editor.isActive('codeBlock') ? 'white' : 'black'} /></span
					>
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
</div>
<Modal />
<Toast />

<style lang="postcss" global>
	button.is-active {
		@apply bg-slate-600;
	}
	p.is-empty.is-editor-empty {
		content: attr(data-placeholder);
	}
	#editorElement #postContent {
		@apply text-black;
	}
</style>
