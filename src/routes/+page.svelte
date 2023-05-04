<script lang="ts">
  import type { PageData } from './$types';

  // d3 imports
  import { scaleTime } from 'd3-scale';

  
	import { fade, blur, fly} from 'svelte/transition';

  import TaskTooltip from '$lib/components/TaskTooltip.svelte';
  import Timeline from '$lib/components/Timeline.svelte';

  // data returned from +page.server.js
  export let data: PageData;

  for (const task of data.tasks) {
    task.createdTime = new Date(task.createdTime);
    if (task.completedTime == undefined) {
      task.completedTime = new Date("2023-05-04");
    } else {
      task.completedTime = new Date(task.completedTime);
    }
  }

  const buildTree = (parentId) => (task) => {
    const children = data.tasks.filter((child) => child.parentId === task.taskId);
    return {
      ...task,
      ...(children.length > 0 && { children: children.map(buildTree(task.taskId)) }),
    };
  };

  const nestedData = {
    tasks: data.tasks.filter((item) => !item.parentId).map(buildTree(undefined)),
  };

  const shuffledData = {
    tasks: nestedData.tasks.sort((a, b) => 0.5 - Math.random())
  };

  let Y = {};
  let currentY = 0;

  const getY = (task) => {
    if(!Y[task.taskId]) {
      while (Object.values(Y).includes(currentY)) {
        currentY = currentY + 15;
      }
      Y[task.taskId] = currentY;
    }
    return Y[task.taskId];
  }

  $: innerHeight = 0;
  $: innerWidth = 0;
  $: width = Math.max(0, innerWidth - 100);
  $: height = currentY + 150;
  
  $: x = scaleTime()
    .domain([new Date("2023-01-01"), new Date("2023-05-04")])
    .range([ 0, width ]);

  let activeTask: number;

  const activateTask = (task) => {
    activeTask = task.taskId;
  }

  const deactivateTask = () => {
    activeTask = -1;
  }

  let showChildren = [];

  const toggleChildren = (task) => {
    if (task.children) {
      let parentY = getY(task);
      Y = {};
      currentY = 0;
      Y[task.taskId] = parentY;
      if (!showChildren.includes(task.taskId)) {
        showChildren.push(task.taskId);
        showChildren = showChildren;
      } else {
        showChildren.splice(showChildren.indexOf(task.taskId), 1);
        showChildren = showChildren;
      }
    }
  }

	// in the case that x and y position aren't set, the cursor should fall back on a position that is out of view -- in this case, (-500, -500)
	let m = { x: -500, y: -500 };
</script>

<svelte:window bind:innerHeight bind:innerWidth/>

<div>
  <h1>To-dos of Spring 2023</h1>
  <div class="viz-container" on:mousemove={(e) => (m = { x: e.clientX, y: e.clientY })}>
    
    <Timeline {width} scale={x} {m}/>
    
    {#if activeTask > -1}
      <div
        transition:fade={{duration: 200}}
        style="position: fixed; {m.x < width / 1.25 ? "left: " + (m.x + 5) : "right: " + (width - m.x + 85)}px; top: {m.y + 5}px;" >
        <TaskTooltip task={data.tasks.find(t => t.taskId === activeTask)} />
      </div>
    {/if}
    {#key showChildren}
      <svg width={width + 50} height={height}>
        <g>
          <!-- looping through to render each circle -->
          {#each shuffledData.tasks as task (task.taskId)}
            <g class="task {activeTask === task.taskId ? "active" : (activeTask > -1 ? "inactive" : "")}" in:blur={{duration: 500, delay: 300}} out:blur={{duration: 500}} on:click={() => toggleChildren(task)} on:mouseover={() => activateTask(task)} on:mouseout={deactivateTask}>
              <rect x={x(task.createdTime)} y={Math.max(5, getY(task) - 10)} width={x(task.completedTime)-x(task.createdTime)} height=20 opacity=0/> 
              <line
                x1={x(task.createdTime)} 
                x2={x(task.completedTime) - 4} 
                y1={getY(task)}
                y2={getY(task)}
                stroke="var(--{task.listName.slice(2).trim()})"
                stroke-width=2
              />
              <circle
                cx={x(task.createdTime)}
                cy={getY(task)}
                r={4}
                fill="var(--{task.listName.slice(2).trim()})"
                stroke="var(--{task.listName.slice(2).trim()})"
                stroke-width=2
              />
              <circle
                cx={x(task.completedTime)}
                cy={getY(task)}
                r={4}
                fill={task.status > 1 ? "var(--" + task.listName.slice(2).trim() + ")" : "none"}
                stroke="var(--{task.listName.slice(2).trim()})"
                stroke-width=2
              />
              {#if task.children}
                <text 
                  class="parent-label" 
                  x={x(task.createdTime) - 10} 
                  y={Math.max(19, getY(task) + 4)}
                  fill="var(--{task.listName.slice(2).trim()})"
                >
                  +{task.children.length} more
                </text>
              {/if}
            </g>
            {#if showChildren.includes(task.taskId)}
                {#each task.children as childTask (childTask.taskId)}
                  <g class="task {activeTask === childTask.taskId ? "active" : (activeTask > -1 ? "inactive" : "")} child" in:fly={{y: -10, duration: 300, delay: 450}} out:fly={{y: 10, duration: 300}} on:mouseover={() => activateTask(childTask)} on:mouseout={deactivateTask}>
                    <rect 
                      x={x(childTask.createdTime)} 
                      y={getY(childTask) - 10} 
                      width={x(childTask.completedTime)-x(childTask.createdTime)} 
                      height=20 
                      opacity=0
                    /> 
                    <line
                      x1={x(childTask.createdTime)} 
                      x2={x(childTask.completedTime) - 4} 
                      y1={getY(childTask)}
                      y2={getY(childTask)}
                      stroke="var(--{task.listName.slice(2).trim()}-light)"
                      stroke-width="1.5"
                      stroke-dasharray="4"
                      stroke-linecap="round"
                    />
                    <circle
                      cx={x(childTask.createdTime)}
                      cy={getY(childTask)}
                      r={4}
                      fill="var(--{task.listName.slice(2).trim()})"
                      stroke="var(--{task.listName.slice(2).trim()})"
                      stroke-width=2
                    />
                    <circle
                      cx={x(childTask.completedTime)}
                      cy={getY(childTask)}
                      r={4}
                      class={childTask.status < 1 ? "incomplete" : "complete"}
                      fill="var(--{task.listName.slice(2).trim()})"
                      stroke="var(--{task.listName.slice(2).trim()})"
                      stroke-width=2
                    />
                    
                    <rect 
                      x={x(childTask.createdTime) - 10} 
                      y={getY(task)} 
                      width=20 
                      height={getY(childTask)-getY(task)} 
                      opacity=0
                    /> 
                    <line
                      x1={x(childTask.createdTime)} 
                      x2={x(childTask.createdTime)} 
                      y1={getY(task)}
                      y2={getY(childTask)}
                      stroke="var(--{task.listName.slice(2).trim()}-light)"
                      stroke-width="1.5"
                      stroke-dasharray="4"
                      stroke-linecap="round"
                    />
                  </g>
                {/each}
              {/if}
          {/each}
        </g>
      </svg>
    {/key}
  </div>
</div>

<style lang="scss">
  h1 {
    text-align: center;
    margin: 3rem auto 0 auto; 
  }

  .task {
      filter: drop-shadow(0 0 1px var(--shadow));
      * {
        transition: all 0.3s;
      }
      &.active {
        filter: drop-shadow(0 0 3px var(--active-shadow));
      }
      &.inactive {
        line {
          stroke: var(--body-light);
        }
        circle {
          stroke: var(--body-light);
          fill: var(--body-light);
        }
        text {
          fill: var(--body-light);
        }
      }
  }

  circle {
    .incomplete {
      fill: none !important;
    }
  }

  .parent-label {
    font-family: "Fitzgerald", serif;
    text-anchor: end;
    font-size: small;
  }
</style>