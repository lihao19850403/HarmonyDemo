import AppContext from "@ohos.app.ability.common";
import { FontSize, TitleBarStyle, WEIGHT } from '../common/constants/Constants';

@Component
export struct TitleComponent {
  @Link isRefreshData: boolean;
  @State title: Resource = $r("app.string.rank_page_title_default");

  build() {
    // 标题栏。
    Row() {
      // 返回按钮，并显示标题。
      this.TitleBackComponent()
      // 刷新按钮。
      this.RefreshComponent()
    }
    .width(WEIGHT)
    .padding({
      left: TitleBarStyle.BAR_MARGIN_HORIZONTAL,
      right: TitleBarStyle.BAR_MARGIN_HORIZONTAL
    })
    .margin({
      top: TitleBarStyle.BAR_MARGIN_TOP
    })
    .height(TitleBarStyle.BAR_HEIGHT)
    .justifyContent(FlexAlign.SpaceAround)
  }

  /* 返回按钮，并显示标题。 */
  @Builder TitleBackComponent() {
    Row() {
      Image($r("app.media.rank_page_back"))
        .height(TitleBarStyle.IMAGE_BACK_SIZE)
        .width(TitleBarStyle.IMAGE_BACK_SIZE)
        .margin({
          right: TitleBarStyle.IMAGE_BACK_MARGIN_RIGHT
        })
        .onClick(() => {
          // 此处关闭应用程序。
          let handler = getContext(this) as AppContext.UIAbilityContext;
          handler.terminateSelf();
        })
      Text(this.title)
        .fontSize(FontSize.LARGE)
    }
    .width(TitleBarStyle.WEIGHT)
    .height(WEIGHT)
    .justifyContent(FlexAlign.Start)
  }

  /* 刷新按钮。 */
  @Builder RefreshComponent() {
    Row() {
      Image($r("app.media.rank_page_loading"))
        .height(TitleBarStyle.IMAGE_LOADING_SIZE)
        .width(TitleBarStyle.IMAGE_LOADING_SIZE)
        .onClick(() => {
          // 此处仅触发isRefreshData变化。
          this.isRefreshData = !this.isRefreshData;
        })
    }
    .width(TitleBarStyle.WEIGHT)
    .height(WEIGHT)
    .justifyContent(FlexAlign.End)
  }
}