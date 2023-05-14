<script>
	import { blur } from 'svelte/transition';
  import { onMount } from 'svelte';
  import '../app.scss';

  let loaded = false;

  onMount(() => {
		loaded = true;
	});

</script>

<svelte:head>
	<title>Spring 2023 in "To-Do"s</title>
	<meta property="og:title" content='Spring 2023 in "To-Do"s' />
	<meta property="og:type" content="website" />
  <meta property="og:image" content="/todos-thumbnail.png">
	<meta
		property="og:description"
		content="A visualization of to-dos across Spring 2023. Explore my semester task by task!"
	/>
</svelte:head>

<div>
  {#if loaded}
    <div in:blur={{duration: 1500}}>
      <slot />
    </div>
  {/if}
</div>
