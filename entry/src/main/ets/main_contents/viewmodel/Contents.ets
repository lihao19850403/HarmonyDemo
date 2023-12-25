import { ChapterData } from '../model/ChapterData'

export class Contents {
  private chapterIDs: number = 0;

  private allChapters: ChapterData[] = [
    new ChapterData(String(++this.chapterIDs), "水果评选列表", "rank_page/pages/RankPage"),
    new ChapterData(String(++this.chapterIDs), "代办事项列表", "todo_list/pages/TodoListPage"),
    new ChapterData(String(++this.chapterIDs), "页面跳转示例", "pages_router/pages/FirstPage"),
    new ChapterData(String(++this.chapterIDs), "购物商城", "shop_mall/pages/LoginPage"),
    new ChapterData(String(++this.chapterIDs), "任务管理页面", "target/pages/MainPage"),
    new ChapterData(String(++this.chapterIDs), "简易视频播放器", "simple_video/pages/SimpleVideoIndex"),
    new ChapterData(String(++this.chapterIDs), "自定义弹窗", "multi_dialogs/pages/HomePage"),
    new ChapterData(String(++this.chapterIDs), "属性动画示例", "property_anim/pages/TabIndex"),
    new ChapterData(String(++this.chapterIDs), "WebView示例\n本地服务：HttpServerOfWeb", "webview_demo/pages/MainPage"),
    new ChapterData(String(++this.chapterIDs), "新闻客户端\n本地服务：HttpServerOfNews", "news_demo/pages/Index"),
  ];

  get(): ChapterData[] {
    return this.allChapters;
  }
}

export default new Contents;