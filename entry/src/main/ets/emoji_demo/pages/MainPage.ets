import { CommonConstants } from '../common/constants/CommonConstants';
import { Inner } from '../view/InnerComponent';
import { Outer } from '../view/OuterComponent';

@Entry
@Component
struct MainPage {
  private controller: TabsController = new TabsController();

  @State currentIndex: number = 0;

  build() {
    Column() {
      Navigation() {
        Tabs({
          barPosition: BarPosition.Start,
          controller: this.controller
        }) {
          TabContent() {
            Inner()
          }
          .tabBar(this.TabBuilder(CommonConstants.FIRST_TAB))
          TabContent() {
            Outer()
          }
          .tabBar(this.TabBuilder(CommonConstants.SECOND_TAB))
        }
        .barWidth(CommonConstants.BAR_WIDTH)
        .barHeight($r("app.float.emoji_default_56"))
        .onChange((index: number) => {
          this.currentIndex = index;
        })
      }
      .titleMode(NavigationTitleMode.Mini)
      .title(this.NavigationTitle())
      .hideBackButton(true)
    }
    .backgroundColor($r("app.color.emoji_app_bg"))
  }

  @Builder NavigationTitle() {
    Column() {
      Text($r('app.string.emoji_main_title'))
        .fontColor(Color.Black)
        .lineHeight($r('app.float.emoji_default_33'))
        .fontSize($r('app.float.emoji_fontSize_24'))
        .fontWeight(FontWeight.Bold)
    }
    .height($r('app.float.emoji_default_56'))
    .justifyContent(FlexAlign.Center)
  }

  @Builder TabBuilder(index: number) {
    Column() {
      Column() {
        Text(index === CommonConstants.FIRST_TAB ? $r('app.string.emoji_tab_title_inner') : $r('app.string.emoji_tab_title_outer'))
          .fontColor(this.currentIndex === index ? $r('app.color.emoji_tab_selectedColor') : $r('app.color.emoji_tab_fontColor'))
          .fontSize($r('app.float.emoji_fontSize_16'))
      }
      .height(CommonConstants.CONTAINER_HEIGHT)
      .justifyContent(FlexAlign.Center)
      .border(this.currentIndex === index ?
        {
          width: {
            bottom: $r('app.float.emoji_default_1')
          },
          color: $r('app.color.emoji_tab_selectedColor')
        } : {}
      )
    }
    .height($r('app.float.emoji_default_56'))
    .padding({ top: $r('app.float.emoji_default_10'), bottom: $r('app.float.emoji_default_10') })
    .justifyContent(FlexAlign.Center)
  }
}