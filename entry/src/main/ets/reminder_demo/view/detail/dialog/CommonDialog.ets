import { CommonConstants } from '../../../common/constants/CommonConstants';
import DimensionUtils from '../../../common/utils/DimensionUtils';

@Extend(Button)
function actionBtnStyle() {
  .height(DimensionUtils.getVp($r('app.float.reminder_common_dialog_button_height')))
  .fontSize(DimensionUtils.getFp($r('app.float.reminder_common_dialog_button_font_size')))
  .fontColor($r('app.color.green_light'))
  .layoutWeight(CommonConstants.DEFAULT_LAYOUT_WEIGHT)
  .backgroundColor($r('app.color.trans_parent'))
}

@Component
export struct CommonDialog {
  private title?: string | Resource;
  private controller?: CustomDialogController;
  private onConfirm = () => {};

  @BuilderParam closer: () => void = () => {};

  build() {
    Column() {
      Text(this.title)
        .width(CommonConstants.FULL_LENGTH)
        .fontSize(DimensionUtils.getFp($r('app.float.reminder_common_dialog_title_font_size')))
        .fontColor($r('app.color.grey_divider'))
        .margin({
          bottom: DimensionUtils.getVp($r('app.float.reminder_common_dialog_title_margin_vertical'))
        })
      this.closer()
      Row() {
        Button($r('app.string.reminder_cancel'))
          .actionBtnStyle()
          .onClick(() => {
            if (!this.controller) {
              return;
            }
            this.controller.close();
          })
        if (this.onConfirm) {
          Button($r('app.string.reminder_confirm'))
            .actionBtnStyle()
            .onClick(() => {
              this.onConfirm();
              if (!this.controller) {
                return;
              }
              this.controller.close();
            })
        }
      }
      .margin({
        top: DimensionUtils.getVp($r('app.float.reminder_common_dialog_margin_vertical'))
      })
    }
    .width(CommonConstants.FULL_LENGTH)
    .padding(DimensionUtils.getVp($r('app.float.reminder_common_dialog_padding')))
    .justifyContent(FlexAlign.Center)
  }
}