<script>
  export let filter ="show all";
  const filterOptions = ["📓school", "🍣work", "🥮club", "🖼️personal", "show all" ];

  export let sort = "random";
  const sortOptions = ["creation date", "completion date", "duration", "category", "random"];
</script>

<div class="panel-container">
    <div class="option-list">
      <div class="list-title">
        filter to
      </div>
      {#each filterOptions as filterOption}
        <div style="color: var(--{filterOption.slice(2).trim()})" class="option {filter === filterOption ? "selected" : ""}" on:click={() => {filter = filterOption}}>
          {filterOption}
        </div>
      {/each}
    </div>
  <!-- </div> -->
  <div class="option-list">
    <div class="list-title">
      sort by
    </div>
    {#each sortOptions as sortOption}
      <div class="option {sort === sortOption ? "selected" : ""}" on:click={() => {sort = sortOption}}>
        {sortOption}
      </div>
    {/each}
  </div>
</div>

<style lang="scss">
  .panel-container {
    display: none;
  }

  .option-list {
    display: flex;
    gap: 1rem;
    justify-content: center;
    font-size: 0.9rem;
    align-items: center;
  }

  @media screen and (min-width: 1100px) {
    .option-list {
      justify-content: end;
    }
  }
  
  @media screen and (min-width: 600px) {
    .panel-container {
      display: block;
    }
  }

  .list-title {
    font-family: "Fitzgerald", serif;
    font-size: 1.1rem;
    color: var(--body-dark);
  }
  .selected {
    font-weight: bold;
    color: var(--body-dark);
  }
  .option {
    cursor: pointer;
    &:hover {
      font-weight: bold;
    }
  }
</style>