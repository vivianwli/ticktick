<script>
  export let name;
  export let listName;
  export let isList = false;
</script>


<div 
  class="tag {isList ? "list": ""}"
  style="--color: var(--{listName});"
>
  {name}
</div>

<style>
  .tag {
    color: var(--color);
    border: 1px solid var(--color);
    font-size: 0.8rem;
    padding: 0.25rem 0.6rem 0.25em 0.6rem;
    border-radius: 1rem;
    width: min-content;
    white-space: nowrap;
  }

  .list {
    padding: 0.2rem 0.6rem 0.35rem 0.55rem;
    font-weight: bold;
    background-color: var(--color);
    color: var(--background);
  }
</style>