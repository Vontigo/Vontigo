<script lang="ts">
	import type { PageData } from './$types';
	import { img_url } from '$lib/core/core/frontend/helpers/img_url';
	import { language, siteUrl, origin } from '$lib/core/shared/stores/site';
	import { ENUM_IMAGE_SIZE } from '$lib/core/shared/conts';
	import IconFire from './partials/icons/IconFire.svelte';

    export let post:any;
</script>
