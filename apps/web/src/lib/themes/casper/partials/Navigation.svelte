<script lang="ts">
	import { language, site, siteUrl, origin, custom, member } from '$lib/core/shared/stores/site';
	import { get } from 'svelte/store';

    export let type:string = "";
    let navigation:any = JSON.parse(type=='secondary'?get(site).secondary_navigation:get(site).navigation);
</script>
{#if navigation}
    <ul class="nav">
        {#each navigation as item}
            <li class="nav-{item.label}"><a href="{item.url}">{item.label}</a></li>
        {/each}
    </ul>
{/if}