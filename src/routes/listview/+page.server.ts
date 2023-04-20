import type { Actions, PageServerLoad } from "./$types";
import { prisma } from "$lib/server/prisma";
import { fail } from "@sveltejs/kit";

export const load: PageServerLoad = async () => {
  return {
    tasks: await prisma.task.findMany(),
  };
};

export const actions: Actions = {
  fetchTasks: async ({ request }) => {
    const { listName } = Object.fromEntries(
      await request.formData()
    ) as unknown as {
      listName: string;
    };
    try {
      return {
        tasks: await prisma.task.findMany({
          where: {
            listName: listName,
          },
        }),
      };
    } catch (err) {
      console.error(err);
      return fail(404, { message: "No tasks found." });
    }
  },
};
