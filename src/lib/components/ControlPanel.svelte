<script>
  import { enhance } from '$app/forms'
</script>

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