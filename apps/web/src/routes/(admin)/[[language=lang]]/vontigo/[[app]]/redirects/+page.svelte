<script lang="ts">
    import {
        AppBar,
        Drawer,
        drawerStore,
        RadioGroup,
        RadioItem, Table,
        tableMapperValues
    } from "@skeletonlabs/skeleton";
    import type { DrawerSettings, TableSource } from '@skeletonlabs/skeleton';
    import {goto} from "$app/navigation";
    import {STORE_ADMIN_SITE_URL} from "$lib/core/shared/stores/site.js";
    import {page} from "$app/stores";
    import IconPlusSmall from "$lib/icons/IconPlusSmall.svelte";
    import type { PageData } from './$types';

    export let data: PageData;

    const settings: DrawerSettings = {
        id: 'redirectEditorDrawer',
        position: 'right',
        width: 'w-full lg:w-[300px]',
        // height: 'h-full',
        padding: 'p-4',
        shadow: 'shadow-md',
        regionDrawer: 'overflow-y-hidden'
    };

    let newRedirectBody = {
        // slug: '',
        id: '',
        from: '',
        to: '',
        // status: 301
    };

    const redirectTable: TableSource = {
        head: ['Slug', 'From', 'To', 'Status'],
        body: tableMapperValues(data.records, ['id', 'from', 'to', 'status']),
        meta: tableMapperValues(data.records, ['id'])
    }
</script>

<AppBar class="sticky top-0 z-10 p-6 bg-white max-w-screen-xl mx-auto px-12">
    <ol class="breadcrumb">
        <li class="crumb"><h2 class="text-xl font-bold mb-1">Redirects</h2></li>
    </ol>
    <svelte:fragment slot="trail">
        <!-- <div class="w-full "> -->
        <div class="hidden md:flex md:flex-row-reverse w-full items-center gap-6">
            <button
                    type="button"
                    class="btn btn-sm variant-filled rounded"
                    on:click={() => {
					drawerStore.open(settings);
				}}
                    >
                <span><IconPlusSmall /></span>
                <span>New tag</span>
            </button>
            <div class="filter-bar flex gap-4" />
        </div>
        <button
                type="button"
                class="md:hidden btn btn-sm variant-filled rounded"
                on:click={() => {
				drawerStore.open(settings);
			}}
            >

            <span><IconPlusSmall /></span>
            <span>New tag</span>
        </button>
        <!-- </div> -->
    </svelte:fragment>

    <!-- <svelte:fragment slot="trail">(actions)</svelte:fragment> -->
</AppBar>

<div class="max-w-screen-xl mx-auto px-12">
    <Drawer>
        {#if $drawerStore.id === 'redirectEditorDrawer'}
            <div class="p-4">
                <div class="flex">
                    <h6 class="w-full font-bold">New Tag</h6>
                    <div class="text-right">
                        <button
                                type="button"
                                class="btn btn-sm variant-filled rounded"
                                on:click={async () => {
                                    newRedirectBody.created_at = new Date().toISOString();
                                    //newRedirectBody.id = newRedirectBody.slug;
								const requestOptions = {
									method: 'POST',
									headers: { 'Content-Type': 'application/json' },
									body: JSON.stringify(newRedirectBody)
								};
								const response = await fetch(`/api/database/redirects/create`, requestOptions);
                                console.log(response);
								const resJson = await response.json();
								if (resJson.row) {
									drawerStore.close();
									goto(
										$STORE_ADMIN_SITE_URL + `/redirects/${resJson.row.id}`
									);
								}
							}}
                        >
                            Save
                        </button>
                    </div>
                </div>
                <div class="py-4 flex flex-col gap-4">
                    <div class="flex flex-col gap-2">
                        <div>Slug</div>
                        <div>
                            <input
                                    type="text"
                                    class="input p-2"
                                    bind:value={newRedirectBody.id}
                            />
                        </div>
                    </div>
                    <div class="flex flex-col gap-2">
                        <div>From</div>
                        <div><input type="text" class="input p-2" bind:value={newRedirectBody.from} /></div>
                    </div>
                    <div class="flex flex-col gap-2">
                        <div>To</div>
                        <div><input type="text" class="input p-2" bind:value={newRedirectBody.to} /></div>
                    </div>
                    <div class="flex flex-col gap-2">
                        <div>Status</div>
                        <div>
                            <RadioGroup active="variant-filled-primary" hover="hover:variant-soft-primary">
<!--                                bind:group={newRedirectBody.status}-->
                                <RadioItem  name="status" value={301}>Permanent</RadioItem>
                                <RadioItem  name="status" value={302}>Temporary</RadioItem>
                            </RadioGroup>
                        </div>
                    </div>
                </div>
            </div>
        {/if}
    </Drawer>
    {#if data.records.length > 0}
        <section class="table-container  ">
            <Table interactive on:selected={({detail}) => goto( $STORE_ADMIN_SITE_URL + "/redirects/" + detail[0])}  source={redirectTable} />
        </section>
    {:else}
        <div class="w-full flex my-60">
            <div class="flex flex-col w-2/4 m-auto">
                <div class="w-full h-full m-auto text-center">No redirects</div>
            </div>
        </div>
    {/if}
</div>