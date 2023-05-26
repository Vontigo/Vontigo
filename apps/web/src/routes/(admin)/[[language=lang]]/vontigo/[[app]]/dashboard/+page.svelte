<script lang="ts">
	import { AppBar, AppShell, Avatar, ProgressBar, filter } from '@skeletonlabs/skeleton';
	import { page } from '$app/stores';
	import { onMount } from 'svelte';
	import { STORE_ADMIN_SITE_URL } from '$lib/core/shared/stores/site';
	import { format } from 'timeago.js';
	import Chart from './components/Chart.svelte';
	import { abbrNum } from '$lib/core/shared/utils/format/numberUtils';

	let repo: any;
	let releases: any[];
	let contributors: any[];
	let issues: any[];
	let draftPosts: any[];
	let discussions: any[];
	// let gaReportData:[{
	//     date:string,
	//     visits:number
	// }];
	let gaReport: any;

	onMount(async () => {
		const [
			draftPostsRes,
			repoRes,
			releasesRes,
			contributorsRes,
			issuesRes,
			discussionRes,
			gaReportRes
		] = await Promise.all([
			fetch('/api/admin/posts/post/draft/page/1'),
			fetch('/api/admin/3rd/github/vontigo/vontigo'),
			fetch('/api/admin/3rd/github/vontigo/vontigo/releases?per_page=3'),
			fetch('/api/admin/3rd/github/vontigo/vontigo/contributors'),
			fetch('/api/admin/3rd/github/vontigo/vontigo/issues'),
			fetch('/api/admin/3rd/github/vontigo/vontigo/discussions'),
			fetch('/api/admin/3rd/google/analytics/90')
		]);

		draftPosts = draftPostsRes.json() || [];
		repo = await repoRes.json();
		releases = (await releasesRes.json()) || [];
		contributors = (await contributorsRes.json()) || [];
		issues = (await issuesRes.json()) || [];
		discussions = (await discussionRes.json()) || [];
		gaReport = (await gaReportRes.json()) || [];

		// gaReportData = gaReport.data.data.rows.map(row => {
		// 	const [dateStr, pageviewsStr] = row;
		// 	const year = dateStr.slice(0, 4);
		// 	const month = dateStr.slice(4, 6);
		// 	const day = dateStr.slice(6);
		// 	const date = `${year}-${month}-${day}`;
		// 	const visits = parseInt(pageviewsStr);
		// 	return { date, visits };
		// });
	});

	// TODO: https://developers.google.com/analytics/devguides/reporting/core/v4/quickstart/web-js
</script>

<AppBar class="sticky top-0 z-10 p-6 bg-white max-w-screen-xl mx-auto px-12">
	<ol class="breadcrumb">
		<li class="crumb"><h2 class="text-xl font-bold mb-1">Dashboard</h2></li>
		<!-- <li class="crumb-separator" aria-hidden>&rsaquo;</li>
		<li class="crumb font-bold capitalize">{$page.params.group || ''}</li> -->
	</ol>
</AppBar>
<div class="max-w-screen-xl mx-auto px-12 flex gap-8">
	<div class="w-[60%] flex flex-col gap-4">
		{#if gaReport?.data?.data?.rows.length > 0}
			<div class="card">
				<header class="card-header font-medium flex gap-2 uppercase">
					<svg
						xmlns="http://www.w3.org/2000/svg"
						fill="none"
						viewBox="0 0 24 24"
						stroke-width="1.5"
						stroke="currentColor"
						class="w-6 h-6"
					>
						<path
							stroke-linecap="round"
							stroke-linejoin="round"
							d="M3.75 3v11.25A2.25 2.25 0 006 16.5h2.25M3.75 3h-1.5m1.5 0h16.5m0 0h1.5m-1.5 0v11.25A2.25 2.25 0 0118 16.5h-2.25m-7.5 0h7.5m-7.5 0l-1 3m8.5-3l1 3m0 0l.5 1.5m-.5-1.5h-9.5m0 0l-.5 1.5m.75-9l3-3 2.148 2.148A12.061 12.061 0 0116.5 7.605"
						/>
					</svg>

					Visits
				</header>
				<section class="p-4">
					<Chart data={gaReport.data.data.rows} />
				</section>
			</div>
		{/if}
		<div class="card">
			<header class="card-header font-medium flex gap-2 uppercase">
				<svg
					xmlns="http://www.w3.org/2000/svg"
					fill="none"
					viewBox="0 0 24 24"
					stroke-width="1.5"
					stroke="currentColor"
					class="w-6 h-6"
				>
					<path
						stroke-linecap="round"
						stroke-linejoin="round"
						d="M5.25 5.653c0-.856.917-1.398 1.667-.986l11.54 6.348a1.125 1.125 0 010 1.971l-11.54 6.347a1.125 1.125 0 01-1.667-.985V5.653z"
					/>
				</svg>

				Getting Started
			</header>
			<section class="p-4">
				<ul class="list">
					<li>
						<span>
							<svg
								xmlns="http://www.w3.org/2000/svg"
								fill="none"
								viewBox="0 0 24 24"
								stroke-width="1"
								stroke="currentColor"
								class="w-5 h-5"
							>
								<path
									stroke-linecap="round"
									stroke-linejoin="round"
									d="M11.42 15.17L17.25 21A2.652 2.652 0 0021 17.25l-5.877-5.877M11.42 15.17l2.496-3.03c.317-.384.74-.626 1.208-.766M11.42 15.17l-4.655 5.653a2.548 2.548 0 11-3.586-3.586l6.837-5.63m5.108-.233c.55-.164 1.163-.188 1.743-.14a4.5 4.5 0 004.486-6.336l-3.276 3.277a3.004 3.004 0 01-2.25-2.25l3.276-3.276a4.5 4.5 0 00-6.336 4.486c.091 1.076-.071 2.264-.904 2.95l-.102.085m-1.745 1.437L5.909 7.5H4.5L2.25 3.75l1.5-1.5L7.5 4.5v1.409l4.26 4.26m-1.745 1.437l1.745-1.437m6.615 8.206L15.75 15.75M4.867 19.125h.008v.008h-.008v-.008z"
								/>
							</svg>
						</span>
						<a
							href={$STORE_ADMIN_SITE_URL + `/settings/site`}
							class="flex-auto unstyled hover:underline"
						>
							Config your site
						</a>
					</li>
					<li>
						<span>
							<svg
								class="w-5 h-5"
								viewBox="0 0 256 260"
								version="1"
								xmlns="http://www.w3.org/2000/svg"
								xmlns:xlink="http://www.w3.org/1999/xlink"
								preserveAspectRatio="xMidYMid"
								fill="currentColor"
							>
								<title>OpenAI</title>
								<g>
									<path
										d="M239.183914,106.202783 C245.054304,88.5242096 243.02228,69.1733805 233.607599,53.0998864 C219.451678,28.4588021 190.999703,15.7836129 163.213007,21.739505 C147.554077,4.32145883 123.794909,-3.42398554 100.87901,1.41873898 C77.9631105,6.26146349 59.3690093,22.9572536 52.0959621,45.2214219 C33.8436494,48.9644867 18.0901721,60.392749 8.86672513,76.5818033 C-5.443491,101.182962 -2.19544431,132.215255 16.8986662,153.320094 C11.0060865,170.990656 13.0197283,190.343991 22.4238231,206.422991 C36.5975553,231.072344 65.0680342,243.746566 92.8695738,237.783372 C105.235639,251.708249 123.001113,259.630942 141.623968,259.52692 C170.105359,259.552169 195.337611,241.165718 204.037777,214.045661 C222.28734,210.296356 238.038489,198.869783 247.267014,182.68528 C261.404453,158.127515 258.142494,127.262775 239.183914,106.202783 L239.183914,106.202783 Z M141.623968,242.541207 C130.255682,242.559177 119.243876,238.574642 110.519381,231.286197 L112.054146,230.416496 L163.724595,200.590881 C166.340648,199.056444 167.954321,196.256818 167.970781,193.224005 L167.970781,120.373788 L189.815614,133.010026 C190.034132,133.121423 190.186235,133.330564 190.224885,133.572774 L190.224885,193.940229 C190.168603,220.758427 168.442166,242.484864 141.623968,242.541207 Z M37.1575749,197.93062 C31.456498,188.086359 29.4094818,176.546984 31.3766237,165.342426 L32.9113895,166.263285 L84.6329973,196.088901 C87.2389349,197.618207 90.4682717,197.618207 93.0742093,196.088901 L156.255402,159.663793 L156.255402,184.885111 C156.243557,185.149771 156.111725,185.394602 155.89729,185.550176 L103.561776,215.733903 C80.3054953,229.131632 50.5924954,221.165435 37.1575749,197.93062 Z M23.5493181,85.3811273 C29.2899861,75.4733097 38.3511911,67.9162648 49.1287482,64.0478825 L49.1287482,125.438515 C49.0891492,128.459425 50.6965386,131.262556 53.3237748,132.754232 L116.198014,169.025864 L94.3531808,181.662102 C94.1132325,181.789434 93.8257461,181.789434 93.5857979,181.662102 L41.3526015,151.529534 C18.1419426,138.076098 10.1817681,108.385562 23.5493181,85.125333 L23.5493181,85.3811273 Z M203.0146,127.075598 L139.935725,90.4458545 L161.7294,77.8607748 C161.969348,77.7334434 162.256834,77.7334434 162.496783,77.8607748 L214.729979,108.044502 C231.032329,117.451747 240.437294,135.426109 238.871504,154.182739 C237.305714,172.939368 225.050719,189.105572 207.414262,195.67963 L207.414262,134.288998 C207.322521,131.276867 205.650697,128.535853 203.0146,127.075598 Z M224.757116,94.3850867 L223.22235,93.4642272 L171.60306,63.3828173 C168.981293,61.8443751 165.732456,61.8443751 163.110689,63.3828173 L99.9806554,99.8079259 L99.9806554,74.5866077 C99.9533004,74.3254088 100.071095,74.0701869 100.287609,73.9215426 L152.520805,43.7889738 C168.863098,34.3743518 189.174256,35.2529043 204.642579,46.0434841 C220.110903,56.8340638 227.949269,75.5923959 224.757116,94.1804513 L224.757116,94.3850867 Z M88.0606409,139.097931 L66.2158076,126.512851 C65.9950399,126.379091 65.8450965,126.154176 65.8065367,125.898945 L65.8065367,65.684966 C65.8314495,46.8285367 76.7500605,29.6846032 93.8270852,21.6883055 C110.90411,13.6920079 131.063833,16.2835462 145.5632,28.338998 L144.028434,29.2086986 L92.3579852,59.0343142 C89.7419327,60.5687513 88.1282597,63.3683767 88.1117998,66.4011901 L88.0606409,139.097931 Z M99.9294965,113.5185 L128.06687,97.3011417 L156.255402,113.5185 L156.255402,145.953218 L128.169187,162.170577 L99.9806554,145.953218 L99.9294965,113.5185 Z"
										fill="currentColor"
									/>
								</g>
							</svg>
						</span>
						<a
							href={$STORE_ADMIN_SITE_URL + `/settings/brainiacminds`}
							class="flex-auto unstyled hover:underline"
						>
							Add your OpenAI key
						</a>
					</li>
					<li>
						<span>
							<svg
								xmlns="http://www.w3.org/2000/svg"
								fill="none"
								viewBox="0 0 24 24"
								stroke-width="1"
								stroke="currentColor"
								class="w-5 h-5"
							>
								<path
									stroke-linecap="round"
									stroke-linejoin="round"
									d="M16.862 4.487l1.687-1.688a1.875 1.875 0 112.652 2.652L6.832 19.82a4.5 4.5 0 01-1.897 1.13l-2.685.8.8-2.685a4.5 4.5 0 011.13-1.897L16.863 4.487zm0 0L19.5 7.125"
								/>
							</svg>
						</span>
						<a
							href={$STORE_ADMIN_SITE_URL + '/posts/post/page/1'}
							class="flex-auto unstyled hover:underline">Write your first post</a
						>
					</li>

					<!-- ... -->
				</ul>
			</section>
		</div>

		{#await draftPosts}
			<ProgressBar height={'h-1'} />
		{:then draftPosts}
			{#if draftPosts?.items.length}
				<div class="card">
					<header class="card-header font-medium flex gap-2 uppercase">
						<svg
							xmlns="http://www.w3.org/2000/svg"
							fill="none"
							viewBox="0 0 24 24"
							stroke-width="1.5"
							stroke="currentColor"
							class="w-6 h-6"
						>
							<path
								stroke-linecap="round"
								stroke-linejoin="round"
								d="M16.862 4.487l1.687-1.688a1.875 1.875 0 112.652 2.652L6.832 19.82a4.5 4.5 0 01-1.897 1.13l-2.685.8.8-2.685a4.5 4.5 0 011.13-1.897L16.863 4.487zm0 0L19.5 7.125"
							/>
						</svg>

						Continue your drafts
					</header>
					<section class="p-4">
						<ul class="list">
							{#each draftPosts.items as item}
								<li>
									<span>
										<svg
											xmlns="http://www.w3.org/2000/svg"
											fill="none"
											viewBox="0 0 24 24"
											stroke-width="1"
											stroke="currentColor"
											class="w-5 h-5"
										>
											<path
												stroke-linecap="round"
												stroke-linejoin="round"
												d="M19.5 14.25v-2.625a3.375 3.375 0 00-3.375-3.375h-1.5A1.125 1.125 0 0113.5 7.125v-1.5a3.375 3.375 0 00-3.375-3.375H8.25m0 12.75h7.5m-7.5 3H12M10.5 2.25H5.625c-.621 0-1.125.504-1.125 1.125v17.25c0 .621.504 1.125 1.125 1.125h12.75c.621 0 1.125-.504 1.125-1.125V11.25a9 9 0 00-9-9z"
											/>
										</svg>
									</span>
									<a
										href={$STORE_ADMIN_SITE_URL + `/posts/post/drafts/page/1`}
										class="flex-auto unstyled hover:underline"
									>
										{item.title}
									</a>
								</li>
							{/each}
							<!-- ... -->
						</ul>
					</section>
				</div>
			{/if}
		{/await}

		<div class="card">
			<header class="card-header font-medium flex gap-2 uppercase">
				<svg
					xmlns="http://www.w3.org/2000/svg"
					fill="none"
					viewBox="0 0 24 24"
					stroke-width="1.5"
					stroke="currentColor"
					class="w-6 h-6"
				>
					<path
						stroke-linecap="round"
						stroke-linejoin="round"
						d="M20.25 8.511c.884.284 1.5 1.128 1.5 2.097v4.286c0 1.136-.847 2.1-1.98 2.193-.34.027-.68.052-1.02.072v3.091l-3-3c-1.354 0-2.694-.055-4.02-.163a2.115 2.115 0 01-.825-.242m9.345-8.334a2.126 2.126 0 00-.476-.095 48.64 48.64 0 00-8.048 0c-1.131.094-1.976 1.057-1.976 2.192v4.286c0 .837.46 1.58 1.155 1.951m9.345-8.334V6.637c0-1.621-1.152-3.026-2.76-3.235A48.455 48.455 0 0011.25 3c-2.115 0-4.198.137-6.24.402-1.608.209-2.76 1.614-2.76 3.235v6.226c0 1.621 1.152 3.026 2.76 3.235.577.075 1.157.14 1.74.194V21l4.155-4.155"
					/>
				</svg>

				Let's have fun with us!
			</header>
			<section class="p-4">
				<ul class="list">
					{#if discussions?.data.repository.discussions.nodes.length > 0}
						{#each discussions?.data.repository.discussions.nodes as item}
							<li class="py-1 flex">
								<div>
									<svg
										xmlns="http://www.w3.org/2000/svg"
										fill="none"
										viewBox="0 0 24 24"
										stroke-width="1"
										stroke="currentColor"
										class="w-5 h-5"
									>
										<path
											stroke-linecap="round"
											stroke-linejoin="round"
											d="M12 20.25c4.97 0 9-3.694 9-8.25s-4.03-8.25-9-8.25S3 7.444 3 12c0 2.104.859 4.023 2.273 5.48.432.447.74 1.04.586 1.641a4.483 4.483 0 01-.923 1.785A5.969 5.969 0 006 21c1.282 0 2.47-.402 3.445-1.087.81.22 1.668.337 2.555.337z"
										/>
									</svg>
								</div>
								<a
									href={item.url}
									target="_blank"
									class="flex gap-2 flex-auto unstyled hover:underline"
								>
									<div class="flex-auto text-inherit">{item.title}</div>
									<div>
										<Avatar
											src={item.author.avatarUrl}
											action={filter}
											actionParams="#Apollo"
											width="w-6"
										/>
									</div>
								</a>
							</li>
						{/each}
					{:else}
						<ProgressBar height={'h-1'} />
					{/if}

					<!-- ... -->
				</ul>
			</section>
		</div>
	</div>
	<div class="w-[40%] flex flex-col gap-4">
		<div class="card">
			<header class="card-header uppercase flex gap-2 font-medium">
				<svg
					xmlns="http://www.w3.org/2000/svg"
					fill="none"
					viewBox="0 0 24 24"
					stroke-width="1.5"
					stroke="currentColor"
					class="w-6 h-6"
				>
					<path stroke-linecap="round" stroke-linejoin="round" d="M4.5 12.75l6 6 9-13.5" />
				</svg>
				Vontigo
				<div class="flex gap-4 ml-auto">
					{#if repo?.data.watchers_count}
						<a
							class="flex gap-2 ml-auto unstyled"
							href="https://github.com/Vontigo/Vontigo/watchers"
							target="_blank"
						>
							<svg
								aria-hidden="true"
								viewBox="0 0 16 16"
								version="1.1"
								data-view-component="true"
								class="w-5 h-5 mt-1"
								fill="currentColor"
							>
								<path
									d="M8 2c1.981 0 3.671.992 4.933 2.078 1.27 1.091 2.187 2.345 2.637 3.023a1.62 1.62 0 0 1 0 1.798c-.45.678-1.367 1.932-2.637 3.023C11.67 13.008 9.981 14 8 14c-1.981 0-3.671-.992-4.933-2.078C1.797 10.83.88 9.576.43 8.898a1.62 1.62 0 0 1 0-1.798c.45-.677 1.367-1.931 2.637-3.022C4.33 2.992 6.019 2 8 2ZM1.679 7.932a.12.12 0 0 0 0 .136c.411.622 1.241 1.75 2.366 2.717C5.176 11.758 6.527 12.5 8 12.5c1.473 0 2.825-.742 3.955-1.715 1.124-.967 1.954-2.096 2.366-2.717a.12.12 0 0 0 0-.136c-.412-.621-1.242-1.75-2.366-2.717C10.824 4.242 9.473 3.5 8 3.5c-1.473 0-2.825.742-3.955 1.715-1.124.967-1.954 2.096-2.366 2.717ZM8 10a2 2 0 1 1-.001-3.999A2 2 0 0 1 8 10Z"
								/>
							</svg>
							{repo?.data.watchers_count}
						</a>
					{/if}
					{#if repo?.data.forks_count}
						<a
							class="flex gap-2 ml-auto unstyled"
							href="https://github.com/Vontigo/Vontigo/forks"
							target="_blank"
						>
							<svg
								aria-hidden="true"
								viewBox="0 0 16 16"
								version="1.1"
								data-view-component="true"
								class="w-5 h-5 mt-1"
								fill="currentColor"
							>
								<path
									d="M5 5.372v.878c0 .414.336.75.75.75h4.5a.75.75 0 0 0 .75-.75v-.878a2.25 2.25 0 1 1 1.5 0v.878a2.25 2.25 0 0 1-2.25 2.25h-1.5v2.128a2.251 2.251 0 1 1-1.5 0V8.5h-1.5A2.25 2.25 0 0 1 3.5 6.25v-.878a2.25 2.25 0 1 1 1.5 0ZM5 3.25a.75.75 0 1 0-1.5 0 .75.75 0 0 0 1.5 0Zm6.75.75a.75.75 0 1 0 0-1.5.75.75 0 0 0 0 1.5Zm-3 8.75a.75.75 0 1 0-1.5 0 .75.75 0 0 0 1.5 0Z"
								/>
							</svg>
							{repo?.data.forks_count}
						</a>
					{/if}
					{#if repo?.data.stargazers_count}
						<a
							class="flex gap-2 ml-auto unstyled"
							href="https://github.com/Vontigo/Vontigo/stargazers"
							target="_blank"
						>
							<svg
								aria-hidden="true"
								viewBox="0 0 16 16"
								version="1.1"
								data-view-component="true"
								class="w-5 h-5 mt-1"
								fill="#e3b341"
							>
								<path
									d="M8 .25a.75.75 0 0 1 .673.418l1.882 3.815 4.21.612a.75.75 0 0 1 .416 1.279l-3.046 2.97.719 4.192a.751.751 0 0 1-1.088.791L8 12.347l-3.766 1.98a.75.75 0 0 1-1.088-.79l.72-4.194L.818 6.374a.75.75 0 0 1 .416-1.28l4.21-.611L7.327.668A.75.75 0 0 1 8 .25Z"
								/>
							</svg>
							{repo?.data.stargazers_count}
						</a>
					{/if}
				</div>
			</header>
			<section class="p-4">
				{#if repo?.data.description}
					<div>
						{repo.data.description}
					</div>
				{:else}
					<ProgressBar height={'h-1'} />
				{/if}
			</section>
		</div>
		<div class="card">
			<header class="card-header uppercase flex gap-2 font-medium">
				<svg
					xmlns="http://www.w3.org/2000/svg"
					fill="none"
					viewBox="0 0 24 24"
					stroke-width="1.5"
					stroke="currentColor"
					class="w-6 h-6"
				>
					<path
						stroke-linecap="round"
						stroke-linejoin="round"
						d="M20.25 7.5l-.625 10.632a2.25 2.25 0 01-2.247 2.118H6.622a2.25 2.25 0 01-2.247-2.118L3.75 7.5M10 11.25h4M3.375 7.5h17.25c.621 0 1.125-.504 1.125-1.125v-1.5c0-.621-.504-1.125-1.125-1.125H3.375c-.621 0-1.125.504-1.125 1.125v1.5c0 .621.504 1.125 1.125 1.125z"
					/>
				</svg>
				Releases
			</header>
			<section class="p-4 flex flex-col gap-2">
				{#if releases?.data.length}
					{#each releases.data as item}
						<div class="flex gap-2">
							<a
								href={item.html_url}
								target="_blank"
								class="unstyled hover:underline flex flex-auto gap-2 font-semibold"
							>
								<svg
									xmlns="http://www.w3.org/2000/svg"
									fill="none"
									viewBox="0 0 24 24"
									stroke-width="1"
									stroke="currentColor"
									class="w-5 h-5 mx-1"
								>
									<path
										stroke-linecap="round"
										stroke-linejoin="round"
										d="M21 7.5l-9-5.25L3 7.5m18 0l-9 5.25m9-5.25v9l-9 5.25M3 7.5l9 5.25M3 7.5v9l9 5.25m0-9v9"
									/>
								</svg>

								{item.tag_name}
							</a>
							<span class="text-xs">{format(item.published_at)}</span>
						</div>
					{/each}
				{:else}
					<ProgressBar height={'h-1'} />
				{/if}
			</section>
		</div>
		<div class="card">
			<header class="card-header uppercase flex gap-2 font-medium">
				<svg
					xmlns="http://www.w3.org/2000/svg"
					fill="none"
					viewBox="0 0 24 24"
					stroke-width="1.5"
					stroke="currentColor"
					class="w-6 h-6"
				>
					<path
						stroke-linecap="round"
						stroke-linejoin="round"
						d="M15 19.128a9.38 9.38 0 002.625.372 9.337 9.337 0 004.121-.952 4.125 4.125 0 00-7.533-2.493M15 19.128v-.003c0-1.113-.285-2.16-.786-3.07M15 19.128v.106A12.318 12.318 0 018.624 21c-2.331 0-4.512-.645-6.374-1.766l-.001-.109a6.375 6.375 0 0111.964-3.07M12 6.375a3.375 3.375 0 11-6.75 0 3.375 3.375 0 016.75 0zm8.25 2.25a2.625 2.625 0 11-5.25 0 2.625 2.625 0 015.25 0z"
					/>
				</svg>
				Contributors

				<div class="flex gap-4 ml-auto">
					<svg
						xmlns="http://www.w3.org/2000/svg"
						fill="none"
						viewBox="0 0 24 24"
						stroke-width="1"
						stroke="currentColor"
						class="w-5 h-5"
					>
						<path
							stroke-linecap="round"
							stroke-linejoin="round"
							d="M18 18.72a9.094 9.094 0 003.741-.479 3 3 0 00-4.682-2.72m.94 3.198l.001.031c0 .225-.012.447-.037.666A11.944 11.944 0 0112 21c-2.17 0-4.207-.576-5.963-1.584A6.062 6.062 0 016 18.719m12 0a5.971 5.971 0 00-.941-3.197m0 0A5.995 5.995 0 0012 12.75a5.995 5.995 0 00-5.058 2.772m0 0a3 3 0 00-4.681 2.72 8.986 8.986 0 003.74.477m.94-3.197a5.971 5.971 0 00-.94 3.197M15 6.75a3 3 0 11-6 0 3 3 0 016 0zm6 3a2.25 2.25 0 11-4.5 0 2.25 2.25 0 014.5 0zm-13.5 0a2.25 2.25 0 11-4.5 0 2.25 2.25 0 014.5 0z"
						/>
					</svg>

					{contributors?.data.length || ''}
				</div>
			</header>
			<section class="p-4 flex">
				<!-- <a href="https://github.com/vontigo/vontigo/graphs/contributors" target="_blank">
					<img src="https://opencollective.com/vontigo/contributors.svg?width=890" />
				</a> -->
				{#if contributors?.data.length}
					{#each contributors.data as item}
						<a
							href="https://github.com/vontigo/vontigo/graphs/contributors"
							target="_blank"
							title={`${item.login} - Contribution: ${item.contributions}`}
							class="relative inline-block p-1"
							style="opacity:{item.contributions / 100 >= 0.1 ? item.contributions / 100 : 0.1}"
						>
							<span
								class="badge-icon variant-filled-warning absolute -top-0 -right-0 z-10 text-[8px]"
							>
								{abbrNum(item.contributions || 0)}
							</span>
							<Avatar src={item.avatar_url} action={filter} actionParams="#Apollo" width="w-12" />
						</a>
					{/each}
				{:else}
					<ProgressBar height={'h-1'} />
				{/if}
			</section>
		</div>
		<div class="card">
			<header class="card-header uppercase flex gap-2 font-medium">
				<span class="">
					<svg
						xmlns="http://www.w3.org/2000/svg"
						fill="none"
						viewBox="0 0 24 24"
						stroke-width="1.5"
						stroke="red"
						class="w-6 h-6"
					>
						<path
							stroke-linecap="round"
							stroke-linejoin="round"
							d="M21 8.25c0-2.485-2.099-4.5-4.688-4.5-1.935 0-3.597 1.126-4.312 2.733-.715-1.607-2.377-2.733-4.313-2.733C5.1 3.75 3 5.765 3 8.25c0 7.22 9 12 9 12s9-4.78 9-12z"
						/>
					</svg>
				</span>

				Sponsor
			</header>
			<section class="p-4">
				<ul class="list">
					<li>
						<span>
							<Avatar src="/img/logo/opencollective.png" width="w-8" rounded="rounded-full" />
						</span>
						<a
							href="https://opencollective.com/vontigo"
							target="_blank"
							class="flex-auto unstyled hover:underline"
						>
							Open Collective
						</a>
					</li>
					<!-- <li>
						<span>
							<Avatar src="/img/logo/thelinuxfoundation.jpg" width="w-8" rounded="rounded-full" />
						</span>
						<a
							href="https://crowdfunding.lfx.linuxfoundation.org/projects/vontigo"
							target="_blank"
							class="flex-auto unstyled hover:underline"
						>
							The Linux Foundation
						</a>
					</li> -->
					<li>
						<span>
							<Avatar src="/img/logo/patreon.png" width="w-8" rounded="rounded-full" />
						</span>
						<a
							href="https://patreon.com/vontigo"
							target="_blank"
							class="flex-auto unstyled hover:underline">Patreon</a
						>
					</li>
					<li>
						<span>
							<Avatar src="/img/logo/paypal.jpg" width="w-8" rounded="rounded-full" />
						</span>
						<a
							href="https://www.paypal.me/vontigo"
							target="_blank"
							class="flex-auto unstyled hover:underline">Paypal</a
						>
					</li>
					<li>
						<span>
							<Avatar src="/img/logo/buymeacoffee.png" width="w-8" rounded="rounded-full" /></span
						>
						<a
							href="https://www.buymeacoffee.com/vontigo"
							target="_blank"
							class="flex-auto unstyled hover:underline"
						>
							Buy me a ☕
						</a>
					</li>
					<li>
						<span> <Avatar src="/img/logo/ko_fi.svg" width="w-8" rounded="rounded-full" /></span>
						<a
							href="https://ko-fi.com/vontigo"
							target="_blank"
							class="flex-auto unstyled hover:underline"
						>
							Ko-fi ☕
						</a>
					</li>
					<li>
						<span>
							<Avatar src="/img/logo/liberapay.svg" width="w-8" rounded="rounded-full" /></span
						>
						<a
							href="https://liberapay.com/Vontigo"
							target="_blank"
							class="flex-auto unstyled hover:underline"
						>
							Liberapay
						</a>
					</li>
					<!-- ... -->
				</ul>
			</section>
		</div>
	</div>
</div>
