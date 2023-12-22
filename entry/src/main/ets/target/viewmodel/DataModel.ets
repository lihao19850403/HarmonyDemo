/* 任务情况。 */
export class TaskItemBean {

  /* 任务名称。 */
  taskName: string;

  /* 任务更新日期。 */
  updateDate: string;

  /* 任务完成进度。 */
  progressValue: number;

  constructor(taskName: string, updateDate: string, progressValue: number) {
    this.taskName = taskName;
    this.updateDate = updateDate;
    this.progressValue = progressValue;
  }
}

/* 任务集合。 */
export class DataModel {

  /* 已有任务列表。 */
  private targetData: Array<TaskItemBean> = [];

  /* 获取任务列表。 */
  getData(): Array<TaskItemBean> {
    return this.targetData;
  }

  /*
   删除一些任务。
   @param selectedTasks 待删除任务标记。比如取值[true, false, true]，则第1、3个任务将被删除，且删除后任务列表仅剩第二个任务，任务列表长度会变为1。
   */
  deleteData(selectedTasks: Array<boolean>) {
    if (!selectedTasks) {
      return;
    }
    // 倒序删除，边删除任务边缩短任务列表的长度。
    for (var i = this.targetData.length - 1; i >= 0; i--) {
      if (selectedTasks[i]) {
        this.targetData.splice(i, 1);
      }
    }
  }

  /* 增加一个任务。 */
  addData(data: TaskItemBean) {
    if (data) {
      this.targetData.push(data);
    }
  }

  /* 获取最新任务的执行进度。 */
  getLatestProgressValue(): number {
    if (this.targetData.length === 0) {
      return 0;
    }
    return this.targetData[this.targetData.length - 1].progressValue;
  }

  /* 更新任务的执行进度。 */
  updateProgress(index: number, updateProgress: number, updateDate: string): boolean {
    if (!this.targetData[index]) {
      return false;
    }
    this.targetData[index].progressValue = updateProgress;
    this.targetData[index].updateDate = updateDate;
    return true;
  }
}

export default new DataModel();