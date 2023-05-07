-- CreateTable
CREATE TABLE "tasks" (
    "taskId" SERIAL NOT NULL,
    "parentId" INTEGER,
    "listName" CHAR(20),
    "title" CHAR(150),
    "createdTime" TIMESTAMPTZ(6),
    "completedTime" TIMESTAMPTZ(6),
    "status" INTEGER,
    "tags" CHAR(50),

    CONSTRAINT "t_pkey" PRIMARY KEY ("taskId")
);

-- AddForeignKey
ALTER TABLE "tasks" ADD CONSTRAINT "tasks_parentId_fkey" FOREIGN KEY ("parentId") REFERENCES "tasks"("taskId") ON DELETE NO ACTION ON UPDATE NO ACTION;
