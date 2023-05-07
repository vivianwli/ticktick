<script>
	import { blur } from 'svelte/transition';
  import { onMount } from 'svelte';
  import '../app.scss';

  let loaded = false;

  onMount(() => {
		loaded = true;
	});

</script>

<div>
  {#if loaded}
    <div in:blur={{duration: 1500}}>
      <slot />
    </div>
  {/if}
</div>
