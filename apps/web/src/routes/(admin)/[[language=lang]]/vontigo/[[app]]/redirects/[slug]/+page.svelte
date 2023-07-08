<script lang="ts">

    import type {PageData} from "./$types";
    import {recordRedirectsDataModal, STORE_ADMIN_SITE_URL} from "$lib/core/shared/stores/site";
    import {page} from "$app/stores";
    import {ENUM_DATABASE_TABLE} from "$lib/core/shared/enum";
    import {AppBar, drawerStore} from "@skeletonlabs/skeleton";
    import RecordCreate from "$lib/core/core/frontend/components/admin/Database/RecordCreate.svelte";
    import {onMount} from "svelte";

    export let data: PageData;

    $recordRedirectsDataModal = {};


</script>


<AppBar class="sticky top-0 z-10 p-6 bg-white max-w-screen-xl mx-auto px-12">
    <ol class="breadcrumb">
        <li class="crumb" href="/dashboard/redirects" ><h2 class="text-xl font-bold mb-1">Redirects</h2></li>
        <li class="crumb-separator" aria-hidden>&rsaquo;</li>
        <li class="crumb"><h2 class="text-xl font-bold mb-1">{$page.params["slug"]}</h2></li>

    </ol>

    <!-- <svelte:fragment slot="trail">(actions)</svelte:fragment> -->
</AppBar>
<div class="max-w-screen-xl mx-auto px-12">
    <!--{#if data.record}-->
    <!--    <RecordCreate {data} table={ENUM_DATABASE_TABLE.redirects} bind:dataModal={$recordRedirectsDataModal} />-->
    <!--{/if}-->

</div>