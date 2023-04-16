<script lang="ts">
	import type { PageData } from './$types';
	import { img_url } from '$lib/core/core/frontend/helpers/img_url';
	import { language, siteUrl, tenant } from '$lib/core/shared/stores/site';
	import { ENUM_IMAGE_SIZE } from '$lib/core/shared/conts';
	import Fire from './partials/icons/fire.svelte';

    export let post:any;
	let postUrl = $siteUrl + '/' + post.slug;
	let origin = '/content/' + $tenant.replace(':', '_') + '/' + $language;
</script>
