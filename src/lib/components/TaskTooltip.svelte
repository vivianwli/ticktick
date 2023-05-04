<script>
  import Tag from "./Tag.svelte";
  export let task;

  const listName = task.listName.slice(2).trim();
  const tags = task.tags?.split(', ') || [];
</script>

<div class="tooltip-container" style="--color: var(--{listName})">
  <p>{task.title}</p>
  <div class="tags">
    <Tag name={task.listName} isList={true} listName={listName}/>
    {#each tags as tag} 
      <Tag name={tag} isList={false} listName={listName}/>
    {/each}
  </div>
</div>

<style>
  .tooltip-container {
    padding: 0.2rem 0.7rem 0.7rem 0.7rem;
    background-color: var(--background);
    color: var(--color);
    opacity: 0.8;
    border: 1.75px solid var(--color);
    border-radius: 0.4rem;
  }

  p {
    font-family: "Fitzgerald", serif;
    font-size: 0.9rem;
    margin: 0.5rem 0;
  }

  .tags {
    display: flex;
    gap: 0.3rem;
  }
</style>