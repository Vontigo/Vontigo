<script lang="ts">
	import { siteUrl } from "$lib/core/shared/stores/site";

    let frame;
function onLoad() {
    const head = frame.contentDocument.querySelector('head');
    console.log(head);
}
</script>
<iframe bind:this={frame} src={$siteUrl} title="preview" class="w-full h-full" />