import { CommonConstant } from '../common/constants/CommonConstant';
import { CustomRefreshLoadLayoutClass } from '../model/CustomRefreshLoadLayoutClass'

/* 刷新或加载更多的提示。 */
@Component
export struct CustomRefreshLoadLayout {
  @ObjectLink customRefreshLoadClass: CustomRefreshLoadLayoutClass;

  build() {
    Row() {
      Image(this.customRefreshLoadClass.imageSrc)
        .width(CommonConstant.RefreshLayout_IMAGE_WIDTH)
        .height(CommonConstant.RefreshLayout_IMAGE_HEIGHT)
      Text(this.customRefreshLoadClass.textValue)
        .margin({
          left: CommonConstant.RefreshLayout_TEXT_MARGIN_LEFT,
          bottom: CommonConstant.RefreshLayout_TEXT_MARGIN_BOTTOM
        })
        .fontSize(CommonConstant.RefreshLayout_TEXT_FONT_SIZE)
        .textAlign(TextAlign.Center)
    }
    .width(CommonConstant.FULL_WIDTH)
    .height(this.customRefreshLoadClass.heightValue)
    .clip(true)
    .justifyContent(FlexAlign.Center)
  }
}