<header
	id="gh-head"
	class="gh-head outer{`#match @custom.header_style "Hidden"`} is-header-hidden{`/match`}"
>
	<div class="gh-head-inner inner">
		<div class="gh-head-brand">
			<a class="gh-head-logo{`#unless @site.logo`} no-image{`/unless`}" href={`@site.url`}>
				{`#if @site.logo`}
				<img src={`@site.logo`} alt={`@site.title`} />
				{`else`}
				{`@site.title`}
				{`/if`}
			</a>
			<button class="gh-search gh-icon-btn" aria-label="Search this site" data-ghost-search
				>{`> "icons/search"`}</button
			>
			<button class="gh-burger" />
		</div>

		<nav class="gh-head-menu">
			{`navigation`}
			{`#unless @site.members_enabled`}
			{`#match @custom.navigation_layout "Stacked"`}
			<button class="gh-search gh-icon-btn" aria-label="Search this site" data-ghost-search
				>{`> "icons/search"`}</button
			>
			{`/match`}
			{`/unless`}
		</nav>

		<div class="gh-head-actions">
			{`#unless @site.members_enabled`}
			{`^match @custom.navigation_layout "Stacked"`}
			<button class="gh-search gh-icon-btn" data-ghost-search>{`> "icons/search"`}</button>
			{`/match`}
			{`else`}
			<button class="gh-search gh-icon-btn" data-ghost-search>{`> "icons/search"`}</button>
			<div class="gh-head-members">
				{`#unless @member`}
				{`#unless @site.members_invite_only`}
				<a class="gh-head-link" href="#/portal/signin" data-portal="signin">Sign in</a>
				<a class="gh-head-button" href="#/portal/signup" data-portal="signup">Subscribe</a>
				{`else`}
				<a class="gh-head-button" href="#/portal/signin" data-portal="signin">Sign in</a>
				{`/unless`}
				{`else`}
				<a class="gh-head-button" href="#/portal/account" data-portal="account">Account</a>
				{`/unless`}
			</div>
			{`/unless`}
		</div>
	</div>
</header>
