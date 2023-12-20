import { ChapterData } from '../model/ChapterData'

export class Contents {
  private chapterIDs: number = 0;

  private allChapters: ChapterData[] = [
    new ChapterData(String(++this.chapterIDs), "运行Hello World", "rank_page/pages/RankPage"),
    new ChapterData(String(++this.chapterIDs), "ArkTS开发语言介绍", "todo_list/pages/TodoListPage"),
    new ChapterData(String(++this.chapterIDs), "应用程序框架", "pages_router/pages/FirstPage"),
  ];

  get(): ChapterData[] {
    return this.allChapters;
  }
}

export default new Contents;