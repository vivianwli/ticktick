import type { PageServerLoad } from "./$types";

export const load: PageServerLoad = async ({ fetch }) => {
  const response = await fetch("/api/tasks");

  return { tasks: await response.json() };
};
