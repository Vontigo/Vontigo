<script>
	import { AppBar, AppShell } from '@skeletonlabs/skeleton';
	import { page } from '$app/stores';
</script>

<AppBar class="sticky top-0 z-10 p-6 bg-white max-w-screen-xl mx-auto px-12">
	<ol class="breadcrumb">
		<li class="crumb"><h2 class="text-xl font-bold mb-1">Dashboard</h2></li>
		<!-- <li class="crumb-separator" aria-hidden>&rsaquo;</li>
		<li class="crumb font-bold capitalize">{$page.params.group || ''}</li> -->
	</ol>
</AppBar>
<div class="max-w-screen-xl mx-auto px-12 flex gap-8">
	<div class="w-[50%] flex flex-col gap-4">
		<div class="card">
			<header class="card-header">Start creating content</header>
			<section class="p-4">
				(content)(content)(content)(content)(content)(content)(content)(content)(content)(content)(content)(content)(content)(content)
			</section>
			<footer class="card-footer">(footer)</footer>
		</div>
		<div class="card">
			<header class="card-header">(header)</header>
			<section class="p-4">(content)</section>
			<footer class="card-footer">(footer)</footer>
		</div>
		<div class="card">
			<header class="card-header">(header)</header>
			<section class="p-4">(content)</section>
			<footer class="card-footer">(footer)</footer>
		</div>
		<div class="card">
			<header class="card-header">(header)</header>
			<section class="p-4">(content)</section>
			<footer class="card-footer">(footer)</footer>
		</div>
		<div class="card">
			<header class="card-header">(header)</header>
			<section class="p-4">(content)</section>
			<footer class="card-footer">(footer)</footer>
		</div>
	</div>
	<div class="w-[50%] flex flex-col gap-4">
		<div class="card">
			<header class="card-header">ACTIVITY</header>
			<section class="p-4">(content)</section>
			<footer class="card-footer">(footer)</footer>
		</div>
		<div class="card">
			<header class="card-header">(header)</header>
			<section class="p-4">(content)</section>
			<footer class="card-footer">(footer)</footer>
		</div>
		<div class="card">
			<header class="card-header">(header)</header>
			<section class="p-4">(content)</section>
			<footer class="card-footer">(footer)</footer>
		</div>
	</div>
</div>
