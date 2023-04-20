<script lang="ts">
  import ControlPanel from '$lib/components/ControlPanel.svelte';

  import type { ActionData, PageData } from './types';
  import { forceSimulation, forceManyBody, forceLink, forceX, forceY } from 'd3-force';
  import { map } from 'd3';
  import { drag } from 'd3-drag';
  
  export let data: PageData;

  export let form: ActionData;

  $: ({ tasks } = form || data);

  // setting up the position for the circle pack
	const move = (x: number, y: number) => `transform: translate(${x}px, ${y}px`;

  const intern = (value: any) => {
    return value !== null && typeof value === "object" ? value.valueOf() : value;
  }

  const d3drag = (simulation: any) => {    
    const dragstarted = (event: any) => {
      if (!event.active) simulation.alphaTarget(0.3).restart();
      event.subject.fx = event.subject.x;
      event.subject.fy = event.subject.y;
    }
    
    const dragged = (event: any) => {
      event.subject.fx = event.x;
      event.subject.fy = event.y;
    }
    
    const dragended = (event: any) => {
      if (!event.active) simulation.alphaTarget(0);
      event.subject.fx = null;
      event.subject.fy = null;
    }
    
    return drag()
      .on("start", dragstarted)
      .on("drag", dragged)
      .on("end", dragended);
  }

  let innerHeight: number;
  $: height = innerHeight / 2;
  $: width = height;
  
  // Replace the input nodes and links with mutable objects for the simulation.
  $: nodesOg = map(tasks, (d: any) => ({ id: d.taskId }));
  $: linksOg = map(tasks, (d: any) => ({ source: d.parentId || d.taskId, target: d.taskId }));

  $: links = linksOg.map((d: any) => Object.create(d));
  $: nodes = nodesOg.map((d: any) => Object.create(d));
  
  $: N = map(nodes, (d: any) => d.id).map(intern);

  // Construct the forces.
  $: forceNodes = forceManyBody();
  $: forceLinks = forceLink(links).id(({index: i}) => N[i]);
  
  $: simulation = forceSimulation(tasks)  
    .nodes(nodes)
    .force("link", forceLinks)
    .force("charge", forceNodes)
    .force("x", forceX())
    .force("y", forceY())
    
  d3drag(simulation);
</script>

<svelte:window bind:innerHeight />

<div class="wrapper">
  <h1>What did I to-do this semester?</h1>
  <h4 class="bold">Spring 2023</h4>
  
  <ControlPanel/>

	<svg {width} {height}>
		<g style={move(height / 2, width / 2)}>
      <!-- looping through to render each circle -->
      {#each links as l}
        <line
          x1={l.source.x} 
          y1={l.source.y}
          x2={l.target.x} 
          y2={l.target.y}
          stroke="#d4bba5"
        />
      {/each}
			{#each nodes as n}
        <circle
          cx={n.x}
          cy={n.y}
          r={5}
          fill={"var(--" + tasks.find(task => task.taskId == n.id).listName.slice(2).trim() + ")"}
        />
      {/each}
    </g>
  </svg>
</div>

<style lang="scss">
  .wrapper {
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