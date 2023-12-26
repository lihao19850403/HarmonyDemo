import router from '@ohos.router';
import { CommonConstants } from '../common/constants/CommonConstants';
import DimensionUtils from '../common/utils/DimensionUtils';

@Component
export default struct BackContainer {
  private header: string | Resource = $r('app.string.reminder_new_alarm');
  private backImgRes: string | Resource = $r('app.media.reminder_ic_cancel');
  private backFunc?: () => void;

  @BuilderParam closer?: () => void;

  build() {
    Row() {
      Button() {
        Image(this.backImgRes == null ? $r('app.media.reminder_ic_public_back') : this.backImgRes)
          .objectFit(ImageFit.Fill)
      }
      .backgroundColor($r('app.color.trans_parent'))
      .width(DimensionUtils.getVp($r('app.float.reminder_title_button_size')))
      .height(DimensionUtils.getVp($r('app.float.reminder_title_button_size')))
      .onClick(() => {
          this.backFunc ? this.backFunc() : router.back();
      })
      Text(this.header)
        .fontSize(DimensionUtils.getFp($r('app.float.reminder_detail_title_font_size')))
        .lineHeight(DimensionUtils.getVp($r('app.float.reminder_title_line_height')))
        .margin({
          left: DimensionUtils.getVp($r('app.float.reminder_title_margin'))
        })
        .fontColor($r('app.color.grey_divider'))
        .fontWeight(FontWeight.Bold)
      Blank()
      if (this.closer) {
        this.closer();
      }
    }
    .padding({
      left: DimensionUtils.getVp($r('app.float.reminder_title_horizon_margin')),
      right: DimensionUtils.getVp($r('app.float.reminder_title_horizon_margin'))
    })
    .height(DimensionUtils.getVp($r('app.float.reminder_page_title_height')))
    .width(CommonConstants.FULL_LENGTH)
  }
}