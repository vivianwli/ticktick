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
    padding: 0.3rem 1rem 1rem 1rem;
    background-color: var(--background);
    color: var(--color);
    opacity: 0.8;
    border: 2px solid var(--color);
    border-radius: 0.5rem;
  }
  .tags {
    display: flex;
    gap: 0.3rem;
  }
</style>