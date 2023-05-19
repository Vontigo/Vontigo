<script>
	import { STORE_ADMIN_SITE_URL } from '$lib/core/shared/stores/site';
	import IconPlusSmall from '$lib/icons/IconPlusSmall.svelte';
	import { AppBar } from '@skeletonlabs/skeleton';
</script>

<AppBar class="sticky top-0 z-10 p-6 bg-white max-w-screen-xl mx-auto px-12">
	<!-- <svelte:fragment slot="lead">
		<Icon3BottomLeft />
	</svelte:fragment> -->
	<h2 class="text-xl font-bold">Settings</h2>
	<!-- <span class="uppercase text-sm font-semibold"
		><a href={$STORE_ADMIN_SITE_URL + `/settings`}>All</a> > {$page.params.group || ''}</span
	> -->
	<svelte:fragment slot="trail">
		<!-- <div class="w-full "> -->
		<div class="hidden md:flex md:flex-row-reverse w-full items-center gap-6">
			<!-- <button
				type="button"
				class="btn btn-sm variant-filled rounded"
				on:click={() => {
					selectedPost = null;
					drawerStore.open(settings);
				}}
			>
				<span><IconPlusSmall /></span>
				<span>New post</span>
			</button>
			<div class="filter-bar flex gap-4">
				<span><CompMenuPosts /></span>
				<span><CompMenuMembersAccess /></span>
				<span><CompMenuAuthors /></span>
				<span><CompMenuTags /></span>
				<span><CompMenuSortBy /></span>
			</div> -->
		</div>
		<!-- <button type="button" class="md:hidden btn btn-sm variant-filled rounded">
			<span><IconPlusSmall /></span>
			<span>New post</span>
		</button> -->
		<!-- </div> -->
	</svelte:fragment>

	<!-- <svelte:fragment slot="trail">(actions)</svelte:fragment> -->
</AppBar>
<div class="max-w-screen-xl mx-auto px-12">
	<div class="">
		<h6 class="py-4 font-semibold">Website</h6>
		<hr />
		<div class="flex flex-wrap gap-10 mb-6">
			<dl class="list-dl p-4">
				<div>
					<span class=""
						><svg
							xmlns="http://www.w3.org/2000/svg"
							fill="none"
							viewBox="0 0 24 24"
							stroke-width="1"
							stroke="currentColor"
							class="w-10 h-10"
						>
							<path
								stroke-linecap="round"
								stroke-linejoin="round"
								d="M10.343 3.94c.09-.542.56-.94 1.11-.94h1.093c.55 0 1.02.398 1.11.94l.149.894c.07.424.384.764.78.93.398.164.855.142 1.205-.108l.737-.527a1.125 1.125 0 011.45.12l.773.774c.39.389.44 1.002.12 1.45l-.527.737c-.25.35-.272.806-.107 1.204.165.397.505.71.93.78l.893.15c.543.09.94.56.94 1.109v1.094c0 .55-.397 1.02-.94 1.11l-.893.149c-.425.07-.765.383-.93.78-.165.398-.143.854.107 1.204l.527.738c.32.447.269 1.06-.12 1.45l-.774.773a1.125 1.125 0 01-1.449.12l-.738-.527c-.35-.25-.806-.272-1.203-.107-.397.165-.71.505-.781.929l-.149.894c-.09.542-.56.94-1.11.94h-1.094c-.55 0-1.019-.398-1.11-.94l-.148-.894c-.071-.424-.384-.764-.781-.93-.398-.164-.854-.142-1.204.108l-.738.527c-.447.32-1.06.269-1.45-.12l-.773-.774a1.125 1.125 0 01-.12-1.45l.527-.737c.25-.35.273-.806.108-1.204-.165-.397-.505-.71-.93-.78l-.894-.15c-.542-.09-.94-.56-.94-1.109v-1.094c0-.55.398-1.02.94-1.11l.894-.149c.424-.07.765-.383.93-.78.165-.398.143-.854-.107-1.204l-.527-.738a1.125 1.125 0 01.12-1.45l.773-.773a1.125 1.125 0 011.45-.12l.737.527c.35.25.807.272 1.204.107.397-.165.71-.505.78-.929l.15-.894z"
							/>
							<path
								stroke-linecap="round"
								stroke-linejoin="round"
								d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"
							/>
						</svg>
					</span>
					<span class="flex-auto">
						<dt class="font-semibold">
							<a href={$STORE_ADMIN_SITE_URL + `/settings/site`} class="unstyled">General</a>
						</dt>
						<dd class="text-sm">Basic publication details and site metadata</dd>
					</span>
				</div>
				<!-- ... -->
			</dl>
			<dl class="list-dl p-4">
				<div>
					<span>
						<svg
							xmlns="http://www.w3.org/2000/svg"
							fill="none"
							viewBox="0 0 24 24"
							stroke-width="1"
							stroke="currentColor"
							class="w-10 h-10"
						>
							<path
								stroke-linecap="round"
								stroke-linejoin="round"
								d="M15 19.128a9.38 9.38 0 002.625.372 9.337 9.337 0 004.121-.952 4.125 4.125 0 00-7.533-2.493M15 19.128v-.003c0-1.113-.285-2.16-.786-3.07M15 19.128v.106A12.318 12.318 0 018.624 21c-2.331 0-4.512-.645-6.374-1.766l-.001-.109a6.375 6.375 0 0111.964-3.07M12 6.375a3.375 3.375 0 11-6.75 0 3.375 3.375 0 016.75 0zm8.25 2.25a2.625 2.625 0 11-5.25 0 2.625 2.625 0 015.25 0z"
							/>
						</svg>
					</span>
					<span class="flex-auto">
						<dt class="font-semibold">
							<a href={$STORE_ADMIN_SITE_URL + `/settings/staff`} class="unstyled">Staff</a>
						</dt>
						<dd class="text-sm">Manage authors, editor and collaborators</dd>
					</span>
				</div>
				<!-- ... -->
			</dl>
		</div>

		<h6 class="py-4 font-semibold">3rd Services</h6>
		<hr />
		<div class="flex flex-wrap gap-10 mb-6">
			<dl class="list-dl p-4">
				<div>
					<span class="w-10 h-10">
						<img src="/brainiacminds-logo.png" />
					</span>
					<span class="flex-auto">
						<dt class="font-semibold">
							<a href={$STORE_ADMIN_SITE_URL + `/settings/brainiacminds`} class="unstyled"
								>BrainiacMinds</a
							>
						</dt>
						<dd class="text-sm">ChatGPT service for content auto generation</dd>
					</span>
				</div>
				<!-- ... -->
			</dl>
			<dl class="list-dl p-4">
				<div>
					<span class="w-10 h-10">
						<img src="/img/logo/google.png" />
					</span>
					<span class="flex-auto">
						<dt class="font-semibold">
							<a href={$STORE_ADMIN_SITE_URL + `/settings/google`} class="unstyled">Google</a>
						</dt>
						<dd class="text-sm">Google services for analytics and keys management</dd>
					</span>
				</div>
				<!-- ... -->
			</dl>
		</div>
	</div>
</div>
