import { CommonConstant } from '../common/constants/CommonConstant'

/* "没有更多了"提示组件。 */
@Component
export struct NoMoreLayout {
  build() {
    Row() {
      Text($r("app.string.news_prompt_message"))
        .margin({
          left: CommonConstant.NoMoreLayoutConstant_NORMAL_PADDING
        })
        .fontSize(CommonConstant.NoMoreLayoutConstant_TITLE_FONT)
        .textAlign(TextAlign.Center)
    }
    .width(CommonConstant.FULL_WIDTH)
    .height(CommonConstant.CUSTOM_LAYOUT_HEIGHT)
    .justifyContent(FlexAlign.Center)
  }
}