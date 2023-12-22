import { CommonConstants } from '../common/constants/CommonConstant';
import { CustomButton } from './CustomButton';

@Component
export struct ProgressEditPanel {
  onCancel?: () => void;
  onClickOK?: (progress: number) => void;

  @Link sliderMode: number;
  @Prop slidingProgress: number;

  build() {
    Column() {
      // 进度条及提示信息。
      Row() {
        Slider({
          style: SliderStyle.InSet,
          min: CommonConstants.SLIDER_MIN_VALUE,
          max: CommonConstants.SLIDER_MAX_VALUE,
          step: CommonConstants.SLIDER_STEP,
          value: this.slidingProgress
        })
          .width(CommonConstants.SLIDER_INNER_WIDTH)
          .onChange((curValue: number, mode: SliderChangeMode) => {
            this.slidingProgress = Math.floor(curValue);
            this.sliderMode = mode;
          })
        Text(this.slidingProgress + "%")
          .fontSize($r("app.float.target_progress_font"))
          .fontWeight(CommonConstants.FONT_WEIGHT)
          .fontColor($r("app.color.target_dialog_progress"))
          .textAlign(TextAlign.Center)
          .margin({
            left: $r("app.float.target_slider_margin_left")
          })
      }
      .width(CommonConstants.SLIDER_WIDTH)
      .height(CommonConstants.SLIDER_HEIGHT)
      // 确认及取消按钮。
      Row() {
        CustomButton({
          buttonText: $r("app.string.target_cancel_button")
        })
          .onClick(() => {
            if (this.onCancel) {
              this.onCancel();
            }
          })
        CustomButton({
          buttonText: $r("app.string.target_confirm_button")
        })
          .onClick(() => {
            if (this.onClickOK) {
              this.onClickOK(this.slidingProgress);
            }
          })
      }
      .margin({
        top: CommonConstants.SLIDER_BUTTON_MARGIN
      })
      .width(CommonConstants.DIALOG_OPERATION_WIDTH)
      .justifyContent(FlexAlign.SpaceBetween)
    }
    .width(CommonConstants.FULL_WIDTH)
    .height($r("app.float.target_edit_panel_height"))
    .justifyContent(FlexAlign.End)
  }
}