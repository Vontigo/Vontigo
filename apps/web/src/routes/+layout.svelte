<script lang="ts">
	import { PUBLIC_DEFAULT_LANG } from '$env/static/public';
	import { page } from '$app/stores';
	import { language, origin, siteUrl } from '$lib/core/shared/stores/site';
	origin.set($page.url.host);
	
	if ($page.params) {
		language.set($page.params.language ? $page.params.language : PUBLIC_DEFAULT_LANG);
		siteUrl.set($page.params.language ? '/' + $page.params.language : '');
	}
</script>
<slot />
