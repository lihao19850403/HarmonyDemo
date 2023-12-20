import router from '@ohos.router';
import CommonConstants from '../common/constants/CommonConstants'

@Entry
@Component
struct SecondPage {
  @State message: string = CommonConstants.SECOND_MESSAGE;
  @State src: string = "";

  aboutToAppear() {
    let params: Record<string, string> = router.getParams() as Record<string, string>;
    this.src = params[CommonConstants.SECOND_SRC_PARAM];
  }

  build() {
    Row() {
      Column() {
        Text(this.message)
          .fontSize(CommonConstants.FONT_SIZE)
          .fontWeight(FontWeight.Bold)
        Text(this.src)
          .fontSize(CommonConstants.PARAMS_FONT_SIZE)
          .opacity(CommonConstants.PARAMS_OPACITY)
        Blank()
        Button($r("app.string.back"))
          .fontSize(CommonConstants.BUTTON_FONT_SIZE)
          .width(CommonConstants.BUTTON_WIDTH)
          .height(CommonConstants.BUTTON_HEIGHT)
          .backgroundColor($r("app.color.pages_router_button_bg"))
          .onClick(() => {
            router.showAlertBeforeBackPage({
              message: "要返回上一个页面吗？\n\n（这个弹框自带取消和确定按钮，且点击取消按钮后不会返回上一页，推测是用了await，令之后的语句变为了一种回调。）"
            });
            router.back({
              url: "",
              params: {
                data: "从第二个页面返回的数据"
              }
            });
          })
      }
      .width(CommonConstants.FULL_WIDTH)
      .height(CommonConstants.LAYOUT_HEIGHT)
    }
    .height(CommonConstants.FULL_HEIGHT)
    .backgroundColor($r("app.color.page_background"))
  }
}