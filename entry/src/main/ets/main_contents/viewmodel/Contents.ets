import { ChapterData } from '../model/ChapterData'
import { SectionData } from '../model/SectionData';

export class Contents {
  private chapterIDs: number = 0;

  private allSections: SectionData[] = [
    new SectionData("基础认证", [
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
      new ChapterData(String(++this.chapterIDs), "设置字体并保存", "preference_demo/pages/HomePage"),
      new ChapterData(String(++this.chapterIDs), "发送通知示例", "notifications_demo/pages/MainPage"),
      new ChapterData(String(++this.chapterIDs), "闹钟提醒示例", "reminder_demo/pages/MainIndex"),
      new ChapterData(String(++this.chapterIDs), "第三方库引用示例", "emoji_demo/pages/MainPage"),
    ]),
    new SectionData("HCIA", [
      new ChapterData(String(++this.chapterIDs), "装饰器示例1\n@State->@Prop->@Prop", "decorators1_demo/pages/Index"),
      new ChapterData(String(++this.chapterIDs), "装饰器示例2\n@State->@Link->@Link", "decorators2_demo/pages/Index"),
      new ChapterData(String(++this.chapterIDs), "装饰器示例3\n@State->@Link->@Prop", "decorators3_demo/pages/Index"),
      new ChapterData(String(++this.chapterIDs), "装饰器示例4【不支持的传递路径】\n@State->@Prop->@Link", "decorators4_demo/pages/Index"),
      new ChapterData(String(++this.chapterIDs), "装饰器示例5\n@Observed->@ObjectLink", "decorators5_demo/pages/Index"),
      new ChapterData(String(++this.chapterIDs), "装饰器示例6\n@Provide->@Consume->@Consume", "decorators6_demo/pages/Index"),
      new ChapterData(String(++this.chapterIDs), "App/Local/Persistent\n@(Local)StorageLink/Prop", "storage_demo/pages/Index"),
      new ChapterData(String(++this.chapterIDs), "懒加载LazyForEach", "lazyforeach_demo/pages/Index"),
    ]),
  ];

  get(): SectionData[] {
    return this.allSections;
  }
}

export default new Contents;