<script lang="ts">
  import { scaleTime } from 'd3-scale';

  export let width: number;
  const height = 46;

	// in the case that x and y position aren't set, the cursor should fall back on a position that is out of view -- in this case, (-500, -500)
	// let m = { x: -500, y: -500 };

  $: x = scaleTime()
    .range([new Date("2023-01-01"), new Date("2023-05-04")])
    .domain([ 0, width-5 ]);
  
  export let m;
</script>

<div class="timeline-background">
  <svg width={width} height={height}></svg>
</div>
<div class="timeline-container">
  <svg width={width} height={height}>
    <g>
      <text x="15" y="30" fill="var(--body)">{new Date("2023-01-03").toDateString()}</text>
      <text text-anchor="end" fill="var(--body)" x={width-5} y="30">{new Date("2023-05-04").toDateString()}</text>
      <!-- main timeline -->
      <line
        x1="15" 
        x2={width-5} 
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
        cx={width-5}
        cy="10"
        r="4"
        fill="var(--body)"
        stroke="var(--body)"
        stroke-width=2
      />
      <!-- scrubber circle -->
      <circle
        cx={Math.min(Math.max(m.x, 15), width-5)}
        cy="10"
        r="4"
        fill="var(--body-dark)"
        stroke="var(--body-dark)"
        stroke-width=2
      />
    </g>
  </svg>
</div>
<div class="timeline-overlay">
  <svg width={width} height={height + 64}>
    <g>
      <text text-anchor="middle" fill="var(--body-dark)" x={Math.min(Math.max(m.x, 110), width - 72)} y="32">{x(Math.min(Math.max(m.x, 15), width-5)).toDateString()}</text>
    </g>
  </svg>
</div>

<style>
  .timeline-container {
    position: fixed;
    bottom: 0;
    left: 0;
    padding: 0 2rem 1.5rem 2rem;
    background-color: var(--background);
  }

  .timeline-overlay {
    position: fixed;
    bottom: 0;
    left: 0;
    padding-left: 2rem;
  }
  
  .timeline-background {
    position: fixed;
    bottom: 0;
    left: 0;
    padding: 3rem 2rem 1.5rem 2rem;
    background-color: var(--background);
    filter: blur(1rem);
  }
</style>