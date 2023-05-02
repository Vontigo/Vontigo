<script>
	import {} from '@auth/core';
</script>

<button
	type="button"
	on:click={async () => {
		const credentials = {
			username: 'huy@vontigo.org',
			password: 'P@ssw0rd'
		};
		const authResponse = await fetch('/auth/signin', {
			method: 'POST',
			headers: {
				'Content-Type': 'application/json'
			},
			body: JSON.stringify(credentials)
		});

		if (!authResponse.ok) {
			return null;
		}

		const user = await authResponse.json();
		console.log(user);
		alert(user);
	}}>Login</button
>
