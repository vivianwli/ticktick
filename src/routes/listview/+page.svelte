<script lang="ts">
  import { enhance } from '$app/forms'

  import type { ActionData, PageData } from './types';
  
  export let data: PageData;

  export let form: ActionData;

  $: ({ tasks } = form || data);
  $: console.log(tasks + "rerender");
</script>

<div class="wrapper">
  <h1>Viv's TickTick Viz</h1>

  <form action="?/fetchTasks" method="POST" use:enhance>
    <section>
      <p>
        <label for="listName">List name:</label>
        <select id="listName" name="listName">
          <option value="📓school">📓school</option>
          <option value="🍣work ">🍣work</option>
          <option value="🥮club">🥮club</option>
          <option value="🖼️personal">🖼️personal</option>
        </select>
      </p>
    </section>
    <section>
      <p>
        <button type="submit">Apply filters!</button>
      </p>
    </section>
  </form>
  
  <div>
    <h3>Tasks:</h3>
      <div class="task">
        <b><p>Title</p></b>
        <b><p>List Name</p></b>
        <b><p>Tags</p></b>  
      </div>
    {#each tasks as task}
      <div class="task">
        <p>{task.title}</p>
        <p>{task.listName}</p>
        {#if task.tags}
          <p>{task.tags}</p>
        {/if}
      </div>
    {/each}
  </div>
</div>

<style lang="scss">
  .wrapper {
    font-family: Helvetica, sans-serif;
    padding: 10% 25%;
  }

  .task {
    display: grid;
    grid-template-columns: 3fr repeat(2, 2fr);
    grid-template-rows: 1fr;
    align-items: center;
    gap: 2rem;
  }
</style>