import { CommonConstant } from '../common/Constant'
import { NavigatorModel } from '../model/NavigatorModel'

@Extend(Button)
function fancy(top: string) {
  .width(CommonConstant.MainConstant_BUTTON_WIDTH)
  .height(CommonConstant.MainConstant_BUTTON_HEIGHT)
  .fontSize(CommonConstant.MainConstant_BUTTON_FONT_SIZE)
  .fontColor($r('app.color.start_window_background'))
  .margin({
    top: top
  })
  .backgroundColor($r('app.color.blue'))
  .borderRadius(CommonConstant.MainConstant_BUTTON_BORDER_RADIUS)
}

@Entry
@Component
struct MainPage {
  build() {
    Column() {
      Image($r('app.media.webview_background'))
        .width(CommonConstant.MainConstant_FULL_HEIGHT)
        .height(CommonConstant.MainConstant_IMAGE_HEIGHT)
      Navigator({
        type: NavigationType.Push,
        target: CommonConstant.WEB_PAGE_URI
      }) {
        Button($r("app.string.webview_loadLocalH5"))
          .fancy(CommonConstant.MainConstant_BUTTON_MARGIN_TOP)
      }
      .params({
        path: CommonConstant.LOCAL_PATH,
        tips: $r("app.string.webview_local")
      } as NavigatorModel)
      Navigator({
        type: NavigationType.Push,
        target: CommonConstant.WEB_PAGE_URI
      }) {
        Button($r("app.string.webview_loadCloudH5"))
          .fancy(CommonConstant.MainConstant_BUTTON_MARGIN_TOP_BUTTON)
      }
      .params({
        path: CommonConstant.CLOUD_PATH,
        tips: $r("app.string.webview_online")
      } as NavigatorModel)
    }
    .height(CommonConstant.MainConstant_FULL_HEIGHT)
    .backgroundColor($r("app.color.navy_blue"))
  }
}