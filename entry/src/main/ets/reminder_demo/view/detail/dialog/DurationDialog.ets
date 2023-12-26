import { CommonConstants } from '../../../common/constants/CommonConstants';
import { DetailConstant } from '../../../common/constants/DetailConstant';
import DimensionUtils from '../../../common/utils/DimensionUtils';
import { AlarmItem } from '../../../model/AlarmItem';
import { CommonDialog } from './CommonDialog';

@CustomDialog
export struct DurationDialog {
  private durations: Array<number> = DetailConstant.RING_DURATION; // 响铃时长，分钟。
  controller?: CustomDialogController;

  @Consume(DetailConstant.DEFAULT_PROVIDER_KEY) alarmItem: AlarmItem;

  build() {
    Flex() {
      CommonDialog({
        title: $r('app.string.reminder_ring_duration'),
        controller: this.controller
      }) {
        ForEach(this.durations,
          (item: number) => {
            Row() {
              Text(item + CommonConstants.DEFAULT_STRING_SPACE + DetailConstant.DEFAULT_STRING_MINUTE)
                .layoutWeight(CommonConstants.DEFAULT_LAYOUT_WEIGHT)
                .fontColor($r('app.color.grey_divider'))
                .fontSize(DimensionUtils.getFp($r('app.float.reminder_duration_dialog_content_font_size')))
              Radio({
                value: item.toString(),
                group: DetailConstant.DEFAULT_STRING_GROUP_NAME
              })
                .width(DimensionUtils.getVp($r('app.float.reminder_duration_dialog_radio_size')))
                .height(DimensionUtils.getVp($r('app.float.reminder_duration_dialog_radio_size')))
                .checked(item === this.alarmItem.duration)
                .onChange(() => {
                  if (!this.controller) {
                    return;
                  }
                  this.controller.close();
                  this.alarmItem.duration = item;
                })
            }
            .width(CommonConstants.FULL_LENGTH)
            Divider()
              .opacity($r('app.float.reminder_divider_opacity'))
              .color($r('app.color.grey_divider'))
              .lineCap(LineCapStyle.Round)
          },
          (item: number, index?: number) => {
            return JSON.stringify(item) + index;
          })
      }
    }
  }
}