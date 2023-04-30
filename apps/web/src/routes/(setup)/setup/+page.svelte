<script>
	import { goto } from '$app/navigation';
	async function setup(){
		await fetch(`/api/setup`);
		goto('/setup/done');
	}
</script>

<div class="max-w-screen-sm m-auto flex h-screen">
	<div class="m-auto flex flex-col gap-6 px-20">
		<h3>Hi! Vontigoers!</h3>
		<em>Welcome to Vontigo! We're thrilled to have you join us and can't wait to see how you'll use our CMS to bring your website to life.</em>
		<div class="flex flex-col gap-4 pr-40">
			<div class="flex flex-col gap-2">
				<label>Site title</label>
				<input class="input p-2" type="text" placeholder="My Voyage"/>
			</div>
			<div class="flex flex-col gap-2">
				<label>Full name</label>
				<input class="input p-2" type="text" placeholder="Huy Nguyen"/>
			</div>
			<div class="flex flex-col gap-2">
				<label>Email address</label>
				<input class="input p-2" type="email" placeholder="huy@example.com"/>
			</div>
			<div class="flex flex-col gap-2">
				<label>Password</label>
				<input class="input p-2" type="password" placeholder="At least 10 characters"/>
			</div>
		</div>
		<div class="pt-4">
			<button class="btn variant-filled" on:click={() => setup()}>Continue -></button>
		</div>
	</div>
</div>
