<script>
  import { fly } from "svelte/transition";

  let showInfo = false;
  const toggleShowInfo = () => {
    showInfo = !showInfo;
  }
</script>

<div class="info">
  <img class="info-toggle" src="info.svg" on:click={toggleShowInfo}/>
  {#if showInfo}
    <div class="info-description" transition:fly={{y: -10, duration: 600}}>
      <b>Welcome to my to-do's visualization!</b> This semester, I used an app called TickTick to meticulously track and tag my tasks. A to-do list on steroids, if you will.
      Each line represents a task with tags, duration, completion status, and more. Feel free to play around! 🤍, Vivian
    </div>
  {/if}
</div>

<style lang="scss">
  .info {
    position: fixed;
    top: 1rem;
    right: 1rem;
    display: grid;
    justify-items: end;
    gap: 2px;
  }

  .info-description {
    padding: 1rem;
    background-color: var(--background);
    color: var(--body-dark);
    opacity: 0.9;
    border: 1.75px solid var(--body-light);
    border-radius: 0.4rem;
    font-size: 0.85rem;
    width: 285px;
    line-height: 1.1rem;
  }

  img {
    cursor: pointer;
  }
</style>