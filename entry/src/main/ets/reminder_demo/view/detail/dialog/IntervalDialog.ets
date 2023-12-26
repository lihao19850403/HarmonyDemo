import { CommonConstants } from '../../../common/constants/CommonConstants';
import { DetailConstant } from '../../../common/constants/DetailConstant';
import DimensionUtils from '../../../common/utils/DimensionUtils';
import { AlarmItem } from '../../../model/AlarmItem';
import { CommonDialog } from './CommonDialog';

@CustomDialog
export struct IntervalDialog {
  controller?: CustomDialogController;

  @Consume(DetailConstant.DEFAULT_PROVIDER_KEY) alarmItem: AlarmItem;
  @State intervalMinuteSelect: number = 0;
  @State intervalTimesSelect: number = 0;

  aboutToAppear(): void{
    this.intervalMinuteSelect = this.alarmItem.intervalMinute;
    this.intervalTimesSelect = this.alarmItem.intervalTimes;
  }

  build() {
    Flex() {
      if ((this.intervalTimesSelect | this.intervalMinuteSelect) > 0) {
        CommonDialog({
          title: $r('app.string.reminder_ring_interval'),
          controller: this.controller,
          onConfirm: () => {
            this.alarmItem.intervalMinute = Number(this.intervalMinuteSelect.toFixed(0))
            this.alarmItem.intervalTimes = Number(this.intervalTimesSelect.toFixed(0))
          }
        }) {
          this.IntervalItem($r('app.string.reminder_ring_interval_content'), 0)
          Divider()
            .opacity($r('app.float.reminder_divider_opacity'))
            .color($r('app.color.grey_divider'))
            .lineCap(LineCapStyle.Round)
          this.IntervalItem($r('app.string.reminder_ring_times_content'), CommonConstants.DEFAULT_SINGLE)
        }
      }
    }
  }

  @Builder IntervalItem(title: string | Resource, intervalType: number) {
    Text(title)
      .fontSize(DimensionUtils.getFp($r('app.float.reminder_interval_dialog_title_font_size')))
      .width(CommonConstants.FULL_LENGTH)
      .textAlign(TextAlign.Start)
      .margin({
        top: DimensionUtils.getVp($r('app.float.reminder_interval_dialog_title_margin_top'))
      })
    Row() {
      Slider({
        value: (intervalType === 0 ? this.intervalMinuteSelect : this.intervalTimesSelect),
        min: (intervalType === 0 ? CommonConstants.DEFAULT_INTERVAL_STEP : 0),
        max: (intervalType === 0
          ? CommonConstants.DEFAULT_INTERVAL_MINUTE_MAX
          : CommonConstants.DEFAULT_INTERVAL_TIME_MAX),
        step: (intervalType === 0 ? CommonConstants.DEFAULT_INTERVAL_STEP : CommonConstants.DEFAULT_DOUBLE),
        style: SliderStyle.OutSet
      })
        .blockColor(Color.Blue)
        .trackColor(Color.Gray)
        .selectedColor(Color.Blue)
        .showSteps(true)
        .showTips(false)
        .onChange((value: number) => {
          if (intervalType === 0) {
            this.intervalMinuteSelect = value;
          } else {
            this.intervalTimesSelect = value;
          }
        })
      Text((intervalType === 0 ? this.intervalMinuteSelect : this.intervalTimesSelect).toFixed(0))
        .fontSize(DimensionUtils.getFp($r('app.float.reminder_interval_dialog_result_font_size')))
    }
    .width(CommonConstants.FULL_LENGTH)
  }
}