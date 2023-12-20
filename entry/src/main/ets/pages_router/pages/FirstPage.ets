import Prompt from '@ohos.promptAction';
import router from "@ohos.router";
import CommonConstants from '../common/constants/CommonConstants';

@Entry
@Component
struct FirstPage {
  @State message: string = CommonConstants.INDEX_MESSAGE;
  @State data: string = "";

  onPageShow() {
    let dataInfo: Object = router.getParams();
    if (dataInfo) {
      let data: Record<string, string> = dataInfo as Record<string, string>;
      this.data = data["data"];
    }
  }

  build() {
    Row() {
      Column() {
        Text(this.message)
          .fontSize(CommonConstants.FONT_SIZE)
          .fontWeight(FontWeight.Bold)
        Text(this.data)
          .fontSize(CommonConstants.PARAMS_FONT_SIZE)
          .opacity(CommonConstants.PARAMS_OPACITY)
        Blank()
        Button($r("app.string.next"))
          .fontSize(CommonConstants.BUTTON_FONT_SIZE)
          .width(CommonConstants.BUTTON_WIDTH)
          .height(CommonConstants.BUTTON_HEIGHT)
          .backgroundColor($r("app.color.pages_router_button_bg"))
          .onClick(() => {
            router.pushUrl({
              url: CommonConstants.SECOND_URL,
              params: {
                src: CommonConstants.SECOND_SRC_MSG
              }
            }).then(() => {
              Prompt.showToast({
                message: "页面跳转成功",
                duration: 1000
              })
            }).catch((error: Error) => {
              console.log("发生了异常：" + JSON.stringify(error));
            })
          })
      }
      .width(CommonConstants.FULL_WIDTH)
      .height(CommonConstants.LAYOUT_HEIGHT)
    }
    .height(CommonConstants.FULL_HEIGHT)
    .backgroundColor($r("app.color.page_background"))
  }
}