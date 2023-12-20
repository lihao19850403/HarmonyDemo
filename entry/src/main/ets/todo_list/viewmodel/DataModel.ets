import CommonConstants from '../common/constants/CommonConstant'

export class DataModel {

  private tasks: string[] = CommonConstants.TODO_DATA;

  getData(): string[] {
    return this.tasks;
  }
}

export default new DataModel();