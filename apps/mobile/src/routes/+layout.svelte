<script>
	// Finally, your application's global stylesheet (sometimes labeled 'app.css')
	import '../app.postcss';
</script>

<div class="h-screen w-full flex flex-col">
	<!-- AppBar replacement with DaisyUI navbar -->
	<div class="navbar bg-base-200 shadow-sm">
		<div class="navbar-start">
			<div class="font-bold">Vontigo Mobile App</div>
		</div>
	</div>
	
	<!-- Main content area with sidebar -->
	<div class="flex flex-1 overflow-hidden">
		<!-- Sidebar Left -->
		<div id="sidebar-left" class="hidden lg:block w-[350px] p-4 bg-base-100 border-r">
			Sidebar
		</div>
		
		<!-- Main content -->
		<div class="flex-1 flex flex-col">
			<!-- Page content -->
			<main class="flex-1 p-4 overflow-auto">
				<slot />
			</main>
			
			<!-- Footer -->
			<footer class="p-4 bg-base-200 text-center">
				Powered by Vontigo
			</footer>
		</div>
	</div>
</div>
