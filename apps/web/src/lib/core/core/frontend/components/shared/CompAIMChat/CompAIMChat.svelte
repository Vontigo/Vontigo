<script lang="ts">
	// your script goes here

	import CompTailwindcss from '../CompTailwindcss/CompTailwindcss.svelte';

	let isExpanded = true;

	let _currentAIM: any, currentAIM: any;
	let listAIMs = [
		{
			nickname: 'tieucuong',
			avatar: 'https://res.cloudinary.com/dc6deairt/image/upload/v1638102932/user-32-01_pfck4u.jpg',
			fullname: 'Tiểu Cường',
			shortbio: 'Specialist in AI.'
		},
		{
			nickname: 'smilefounder',
			avatar: 'https://res.cloudinary.com/dc6deairt/image/upload/v1638102932/user-32-03_uzwykl.jpg',
			fullname: 'Smilefounder',
			shortbio: 'Specialist in finding peaceful.'
		}
	];
</script>

<CompTailwindcss />
<div class="h-auto w-auto fixed bottom-0 right-0 justify-center p-4">
	<section class="flex flex-col justify-end mb-24 antialiased text-gray-600 p-4">
		{#if isExpanded}
			<div class="h-auto">
				<!-- Card -->
				<div class="relative w-full max-w-[500px] mx-auto bg-white shadow-lg rounded-lg">
					<button
						class="absolute right-3 top-0 p-3"
						on:click={() => {
							currentAIM = null;
						}}>x</button
					>
					{#if currentAIM}
						<!-- Card header -->
						<header class="pt-6 pb-4 px-5 border-b border-gray-200">
							<div class="flex justify-between items-center mb-3">
								<!-- Image + name -->
								<div class="flex items-center">
									<a class="inline-flex items-start mr-3" href="#0">
										<img
											class="rounded-full"
											src={currentAIM.avatar}
											width="48"
											height="48"
											alt={currentAIM.fullname}
										/>
									</a>
									<div class="pr-1">
										<a class="inline-flex text-gray-800 hover:text-gray-900" href="#0">
											<h2 class="text-xl leading-snug font-bold">{currentAIM.fullname}</h2>
										</a>
										<a class="block text-sm font-medium hover:text-indigo-500" href="#0"
											>@{currentAIM.nickname}</a
										>
									</div>
								</div>
								<!-- Settings button -->
								<!-- <div class="relative inline-flex flex-shrink-0">
									<button
										class="text-gray-400 hover:text-gray-500 rounded-full focus:ring-0 outline-none focus:outline-none"
									>
										<span class="sr-only">Settings</span>
										<svg class="w-4 h-4 fill-current" viewBox="0 0 16 16">
											<path
												d="m15.621 7.015-1.8-.451A5.992 5.992 0 0 0 13.13 4.9l.956-1.593a.5.5 0 0 0-.075-.611l-.711-.707a.5.5 0 0 0-.611-.075L11.1 2.87a5.99 5.99 0 0 0-1.664-.69L8.985.379A.5.5 0 0 0 8.5 0h-1a.5.5 0 0 0-.485.379l-.451 1.8A5.992 5.992 0 0 0 4.9 2.87l-1.593-.956a.5.5 0 0 0-.611.075l-.707.711a.5.5 0 0 0-.075.611L2.87 4.9a5.99 5.99 0 0 0-.69 1.664l-1.8.451A.5.5 0 0 0 0 7.5v1a.5.5 0 0 0 .379.485l1.8.451c.145.586.378 1.147.691 1.664l-.956 1.593a.5.5 0 0 0 .075.611l.707.707a.5.5 0 0 0 .611.075L4.9 13.13a5.99 5.99 0 0 0 1.664.69l.451 1.8A.5.5 0 0 0 7.5 16h1a.5.5 0 0 0 .485-.379l.451-1.8a5.99 5.99 0 0 0 1.664-.69l1.593.956a.5.5 0 0 0 .611-.075l.707-.707a.5.5 0 0 0 .075-.611L13.13 11.1a5.99 5.99 0 0 0 .69-1.664l1.8-.451A.5.5 0 0 0 16 8.5v-1a.5.5 0 0 0-.379-.485ZM8 11a3 3 0 1 1 0-6 3 3 0 0 1 0 6Z"
											/>
										</svg>
									</button>
								</div> -->
							</div>
							<!-- Meta -->
							<div class="flex flex-wrap justify-center sm:justify-start space-x-4">
								<div class="flex items-center">
									<svg class="w-4 h-4 fill-current flex-shrink-0 text-gray-400" viewBox="0 0 16 16">
										<path
											d="M8 8.992a2 2 0 1 1-.002-3.998A2 2 0 0 1 8 8.992Zm-.7 6.694c-.1-.1-4.2-3.696-4.2-3.796C1.7 10.69 1 8.892 1 6.994 1 3.097 4.1 0 8 0s7 3.097 7 6.994c0 1.898-.7 3.697-2.1 4.996-.1.1-4.1 3.696-4.2 3.796-.4.3-1 .3-1.4-.1Zm-2.7-4.995L8 13.688l3.4-2.997c1-1 1.6-2.198 1.6-3.597 0-2.798-2.2-4.996-5-4.996S3 4.196 3 6.994c0 1.399.6 2.698 1.6 3.697 0-.1 0-.1 0 0Z"
										/>
									</svg>
									<span class="text-sm whitespace-nowrap ml-2">Milan, IT</span>
								</div>
								<div class="flex items-center">
									<svg class="w-4 h-4 fill-current flex-shrink-0 text-gray-400" viewBox="0 0 16 16">
										<path
											d="M11 0c1.3 0 2.6.5 3.5 1.5 1 .9 1.5 2.2 1.5 3.5 0 1.3-.5 2.6-1.4 3.5l-1.2 1.2c-.2.2-.5.3-.7.3-.2 0-.5-.1-.7-.3-.4-.4-.4-1 0-1.4l1.1-1.2c.6-.5.9-1.3.9-2.1s-.3-1.6-.9-2.2C12 1.7 10 1.7 8.9 2.8L7.7 4c-.4.4-1 .4-1.4 0-.4-.4-.4-1 0-1.4l1.2-1.1C8.4.5 9.7 0 11 0ZM8.3 12c.4-.4 1-.5 1.4-.1.4.4.4 1 0 1.4l-1.2 1.2C7.6 15.5 6.3 16 5 16c-1.3 0-2.6-.5-3.5-1.5C.5 13.6 0 12.3 0 11c0-1.3.5-2.6 1.5-3.5l1.1-1.2c.4-.4 1-.4 1.4 0 .4.4.4 1 0 1.4L2.9 8.9c-.6.5-.9 1.3-.9 2.1s.3 1.6.9 2.2c1.1 1.1 3.1 1.1 4.2 0L8.3 12Zm1.1-6.8c.4-.4 1-.4 1.4 0 .4.4.4 1 0 1.4l-4.2 4.2c-.2.2-.5.3-.7.3-.2 0-.5-.1-.7-.3-.4-.4-.4-1 0-1.4l4.2-4.2Z"
										/>
									</svg>
									<a
										class="text-sm font-medium whitespace-nowrap text-indigo-500 hover:text-indigo-600 ml-2"
										href="#0">carolinmcneail.com</a
									>
								</div>
							</div>
						</header>
						<div class="flex flex-col items-center justify-center w-full h-auto text-gray-800">
							<!-- Component Start -->
							<div
								class="flex flex-col flex-grow w-full max-w-xl bg-white shadow-xl rounded-lg overflow-hidden"
							>
								<div
									class="flex flex-col flex-grow max-h-[500px] overflow-y-auto p-4 overflow-auto"
								>
									<div class="flex w-full mt-2 space-x-3">
										<div class="flex-shrink-0 h-10 w-10 rounded-full bg-gray-300" />
										<div>
											<div class="bg-gray-300 p-3 rounded-r-lg rounded-bl-lg">
												<p class="">Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
											</div>
											<span class="text-xs text-gray-500 leading-none">2 min ago</span>
										</div>
									</div>
									<div class="flex w-full mt-2 space-x-3 ml-auto justify-end">
										<div>
											<div class="bg-blue-600 text-white p-3 rounded-l-lg rounded-br-lg">
												<p class="">
													Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod.
												</p>
											</div>
											<span class="text-xs text-gray-500 leading-none">2 min ago</span>
										</div>
										<div class="flex-shrink-0 h-10 w-10 rounded-full bg-gray-300" />
									</div>
									<div class="flex w-full mt-2 space-x-3 ml-auto justify-end">
										<div>
											<div class="bg-blue-600 text-white p-3 rounded-l-lg rounded-br-lg">
												<p class="">Lorem ipsum dolor sit amet.</p>
											</div>
											<span class="text-xs text-gray-500 leading-none">2 min ago</span>
										</div>
										<div class="flex-shrink-0 h-10 w-10 rounded-full bg-gray-300" />
									</div>
									<div class="flex w-full mt-2 space-x-3">
										<div class="flex-shrink-0 h-10 w-10 rounded-full bg-gray-300" />
										<div>
											<div class="bg-gray-300 p-3 rounded-r-lg rounded-bl-lg">
												<p class="">
													Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod
													tempor incididunt ut labore et dolore magna aliqua.
												</p>
											</div>
											<span class="text-xs text-gray-500 leading-none">2 min ago</span>
										</div>
									</div>
									<div class="flex w-full mt-2 space-x-3 ml-auto justify-end">
										<div>
											<div class="bg-blue-600 text-white p-3 rounded-l-lg rounded-br-lg">
												<p class="">
													Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod
													tempor incididunt ut labore et dolore magna aliqua.
												</p>
											</div>
											<span class="text-xs text-gray-500 leading-none">2 min ago</span>
										</div>
										<div class="flex-shrink-0 h-10 w-10 rounded-full bg-gray-300" />
									</div>
									<div class="flex w-full mt-2 space-x-3 ml-auto justify-end">
										<div>
											<div class="bg-blue-600 text-white p-3 rounded-l-lg rounded-br-lg">
												<p class="">
													Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod
													tempor incididunt.
												</p>
											</div>
											<span class="text-xs text-gray-500 leading-none">2 min ago</span>
										</div>
										<div class="flex-shrink-0 h-10 w-10 rounded-full bg-gray-300" />
									</div>
									<div class="flex w-full mt-2 space-x-3 ml-auto justify-end">
										<div>
											<div class="bg-blue-600 text-white p-3 rounded-l-lg rounded-br-lg">
												<p class="">Lorem ipsum dolor sit amet.</p>
											</div>
											<span class="text-xs text-gray-500 leading-none">2 min ago</span>
										</div>
										<div class="flex-shrink-0 h-10 w-10 rounded-full bg-gray-300" />
									</div>
									<div class="flex w-full mt-2 space-x-3">
										<div class="flex-shrink-0 h-10 w-10 rounded-full bg-gray-300" />
										<div>
											<div class="bg-gray-300 p-3 rounded-r-lg rounded-bl-lg">
												<p class="">
													Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod
													tempor incididunt ut labore et dolore magna aliqua.
												</p>
											</div>
											<span class="text-xs text-gray-500 leading-none">2 min ago</span>
										</div>
									</div>
									<div class="flex w-full mt-2 space-x-3 ml-auto justify-end">
										<div>
											<div class="bg-blue-600 text-white p-3 rounded-l-lg rounded-br-lg">
												<p class="">Lorem ipsum dolor sit.</p>
											</div>
											<span class="text-xs text-gray-500 leading-none">2 min ago</span>
										</div>
										<div class="flex-shrink-0 h-10 w-10 rounded-full bg-gray-300" />
									</div>
								</div>

								<div class="bg-gray-300 p-4">
									<input
										class="flex items-center h-10 w-full rounded px-3 text-sm"
										type="text"
										placeholder="Type your message…"
									/>
								</div>
							</div>
							<!-- Component End  -->
						</div>
					{:else}
						<!-- Card body -->
						<div class="py-3 px-5">
							<h3 class="text-xs font-semibold uppercase text-gray-400 mb-1">Chats</h3>
							<!-- Chat list -->
							<div class="divide-y divide-gray-200">
								{#each listAIMs as aim}
									<!-- AIM -->
									<button
										on:click={() => {
											currentAIM = aim;
										}}
										class="w-full text-left py-2 focus:outline-none focus-visible:bg-indigo-50"
									>
										<div class="flex items-center">
											<img
												class="rounded-full items-start flex-shrink-0 mr-3"
												src={aim.avatar}
												width="32"
												height="32"
												alt={aim.fullname}
											/>
											<div>
												<h4 class="text-sm font-semibold text-gray-900">@{aim.nickname}</h4>
												<div class="text-[13px]">{aim.shortbio}</div>
											</div>
										</div>
									</button>
								{/each}
							</div>
						</div>
					{/if}
				</div>
			</div>
		{/if}
		<div class="flex flex-col justify-end items-end">
			<button
				on:click={() => {
					isExpanded = !isExpanded;
				}}
				class="absolute bottom-5 right-5 inline-flex items-center text-sm font-medium text-white bg-white hover:bg-gray-100 rounded-full text-center px-3 py-2 shadow-lg focus:outline-none focus-visible:ring-2"
			>
				<span class="w-20 h-20">
					<img src="/brainiacminds-logo.png" alt="BrainiacMinds" class="w-20 h-20" />
				</span>
			</button>
			<!-- <button class="flex-auto rounded-full bg-white p-2 shadow-md w-fit" /> -->
		</div>
	</section>
</div>
