import { ChapterData } from '../model/ChapterData'

export class Contents {
  private chapterIDs: number = 0;

  private allChapters: ChapterData[] = [
    new ChapterData(String(++this.chapterIDs), "水果评选列表", "rank_page/pages/RankPage"),
    new ChapterData(String(++this.chapterIDs), "代办事项列表", "todo_list/pages/TodoListPage"),
    new ChapterData(String(++this.chapterIDs), "页面跳转示例", "pages_router/pages/FirstPage"),
    new ChapterData(String(++this.chapterIDs), "购物商城", "shop_mall/pages/LoginPage"),
  ];

  get(): ChapterData[] {
    return this.allChapters;
  }
}

export default new Contents;