import CommonConstants from '../common/constants/CommonConstants';
import { Home } from '../view/Home';
import { Setting } from '../view/Setting';

@Entry
@Component
struct MainPage {
  private tabsController: TabsController = new TabsController();

  @State currentIndex: number = CommonConstants.HOME_TAB_INDEX;

  build() {
    // 整屏都是标签页。
    Tabs({
      barPosition: BarPosition.End,
      controller: this.tabsController
    }) {
      /* 首页。 */
      TabContent() {
        Home()
      }
      .padding({
        left: $r('app.float.shop_mall_mainPage_padding'),
        right: $r('app.float.shop_mall_mainPage_padding')
      })
      .backgroundColor($r('app.color.shop_mall_mainPage_backgroundColor'))
      // 此处填写首页对应的tab页签信息。
      .tabBar(this.TabBuilder(
        CommonConstants.HOME_TAB_INDEX,
        CommonConstants.HOME_TITLE,
        $r('app.media.shop_mall_home_selected'),
        $r('app.media.shop_mall_home_normal')
      ))
      /* 设置页。 */
      TabContent() {
        Setting()
      }
      .padding({
        left: $r('app.float.shop_mall_mainPage_padding'),
        right: $r('app.float.shop_mall_mainPage_padding')
      })
      .backgroundColor($r('app.color.shop_mall_mainPage_backgroundColor'))
      // 此处填写设置页对应的tab页签信息。
      .tabBar(this.TabBuilder(
        CommonConstants.MINE_TAB_INDEX,
        CommonConstants.MINE_TITLE,
        $r('app.media.shop_mall_mine_selected'),
        $r('app.media.shop_mall_mine_normal')
      ))
    }
    .width(CommonConstants.FULL_PARENT)
    .backgroundColor(Color.White)
    .barHeight($r('app.float.shop_mall_mainPage_barHeight'))
    .barMode(BarMode.Fixed) // 底部标签栏不必滚动。
    .onChange((index: number) => {
      // 当滑动页面切换tab的时候，触发底部标签页样式的重绘。
      this.currentIndex = index;
    })
  }

  /* 生成Tab内容。 */
  @Builder TabBuilder(index: number, title: Resource, selectedImg: Resource, normalImg: Resource) {
    Column() {
      Image(this.currentIndex === index ? selectedImg : normalImg)
        .width($r('app.float.shop_mall_mainPage_baseTab_size'))
        .height($r('app.float.shop_mall_mainPage_baseTab_size'))
      Text(title)
        .margin({
          top: $r('app.float.shop_mall_mainPage_baseTab_top')
        })
        .fontSize($r('app.float.shop_mall_main_tab_fontSize'))
        .fontColor(this.currentIndex === index ? $r('app.color.shop_mall_mainPage_selected') : $r('app.color.shop_mall_mainPage_normal'))
    }
    .justifyContent(FlexAlign.Center)
    .width(CommonConstants.FULL_PARENT)
    .height($r('app.float.shop_mall_mainPage_barHeight'))
    .onClick(() => {
      // 触发Tab样式重绘。
      this.currentIndex = index;
      // 触发屏幕上页面的切换动作。
      this.tabsController.changeIndex(this.currentIndex);
    })
  }
}