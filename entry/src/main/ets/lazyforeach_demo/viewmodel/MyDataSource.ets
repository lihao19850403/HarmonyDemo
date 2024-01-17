import { BasicDataSource } from './BasicDataSource';

export class MyDataSource extends BasicDataSource {
  private dataArray: string[] = [
    "第一条数据",
    "第二条数据",
    "第三条数据",
    "第四条数据",
    "第五条数据",
    "第六条数据",
    "第七条数据",
    "第八条数据",
    "第九条数据",
    "第十条数据",
    "第十一条数据",
    "第十二条数据",
  ];

  getData(index: number): string {
    return this.dataArray[index];
  }

  totalCount(): number {
    return this.dataArray.length;
  }

  addData(index: number, data: string): void {
    this.dataArray.splice(index, 0, data);
    this.notifyDataAdd(index);
  }

  pushData(data: string): void {
    this.dataArray.push(data);
    this.notifyDataAdd(this.dataArray.length - 1);
  }
}