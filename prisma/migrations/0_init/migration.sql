-- CreateTable
CREATE TABLE "details" (
    "startDate" TIMESTAMP(6),
    "dueDate" TIMESTAMP(6),
    "repeat" CHAR(30),
    "priority" INTEGER,
    "status" INTEGER,
    "completedTime" TIMESTAMP(6),
    "taskId" INTEGER NOT NULL,

    CONSTRAINT "details_pkey" PRIMARY KEY ("taskId")
);

-- CreateTable
CREATE TABLE "tasks" (
    "taskId" INTEGER NOT NULL,
    "parentId" INTEGER,
    "listName" CHAR(20),
    "title" CHAR(150),
    "tags" CHAR(20),

    CONSTRAINT "t_pkey" PRIMARY KEY ("taskId")
);

-- AddForeignKey
ALTER TABLE "details" ADD CONSTRAINT "details_taskId_fkey" FOREIGN KEY ("taskId") REFERENCES "tasks"("taskId") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "tasks" ADD CONSTRAINT "tasks_parentId_fkey" FOREIGN KEY ("parentId") REFERENCES "tasks"("taskId") ON DELETE NO ACTION ON UPDATE NO ACTION;

