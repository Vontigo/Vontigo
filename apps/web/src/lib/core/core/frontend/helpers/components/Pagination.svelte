<script lang="ts">
	export let page: number;
	export let pages: number;
	export let prev: boolean;
	export let prev_title: string;
	export let page_url_prev: string;
	export let next: boolean;
	export let next_title: string;
	export let page_url_next: string;
</script>

{#if page}
	<nav class="pagination">
		{#if prev}
			<a class="newer-posts" href={page_url_prev}>
				<span aria-hidden="true">&larr;</span>
				{prev_title ? prev_title : 'Newer Posts'}
			</a>
		{/if}
		<span class="page-number">Page {page} of {pages}</span>
		{#if next}
			<a class="older-posts" href={page_url_next}>
				{next_title ? next_title : 'Older Posts'}
				<span aria-hidden="true">&rarr;</span>
			</a>
		{/if}
	</nav>
{/if}
