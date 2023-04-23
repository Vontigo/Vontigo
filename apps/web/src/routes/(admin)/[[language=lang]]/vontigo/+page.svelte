<script lang="ts">
	import { page } from '$app/stores';
</script>

<svelte:head>
	<title>Dashboard</title>
	<meta name="description" content="Svelte demo app" />
</svelte:head>

<section>
	<p>Dashboard page</p>
	{$page.data.session}
	<!-- <h1>Portal</h1>

	<h2>
		try editing <strong>src/routes/+page.svelte</strong>
	</h2> -->
</section>
