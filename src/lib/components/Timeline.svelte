<script lang="ts">

  export let width: number;
  const height = 46;
  
  export let scale: Function;

	// in the case that x and y position aren't set, the cursor should fall back on a position that is out of view -- in this case, (-500, -500)
	let m = { x: -500, y: -500 };
</script>

<div class="timeline-background">
  <svg width={width + 50} height={height}></svg>
</div>
<div class="timeline-container">
  <svg width={width + 50} height={height}>
    <g>
      <text x="15" y="30" fill="var(--body)">{new Date("2023-01-01").toDateString()}</text>
      <text text-anchor="end" fill="var(--body)" x={width} y="30">{new Date("2023-05-04").toDateString()}</text>
      <line
        x1="15" 
        x2={width} 
        y1="10"
        y2="10"
        stroke="var(--body)"
        stroke-width=2
      />
      <circle
        cx="15"
        cy="10"
        r="4"
        fill="var(--body)"
        stroke="var(--body)"
        stroke-width=2
      />
      <circle
        cx={width}
        cy="10"
        r="4"
        fill="var(--body)"
        stroke="var(--body)"
        stroke-width=2
      />
    </g>
  </svg>
</div>

<style>
  .timeline-container {
    position: fixed;
    bottom: 0;
    left: 0;
    padding: 0 2rem 2rem 2rem;
    background-color: var(--background);
  }
  
  .timeline-background {
    position: fixed;
    bottom: 0;
    left: 0;
    padding: 3rem 2rem 2rem 2rem;
    background-color: var(--background);
    filter: blur(1rem);
  }
</style>