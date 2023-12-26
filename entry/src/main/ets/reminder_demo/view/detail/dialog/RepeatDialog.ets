import { CommonDialog } from './CommonDialog';
import { DetailViewModel } from "../../../viewmodel/DetailViewModel";
import { DetailConstant } from '../../../common/constants/DetailConstant';
import { AlarmItem } from '../../../model/AlarmItem';
import DataTypeUtils from '../../../common/utils/DataTypeUtils';
import { CommonConstants } from '../../../common/constants/CommonConstants';
import DimensionUtils from '../../../common/utils/DimensionUtils';

@CustomDialog
export default struct RepeatDialog {
  private viewModel: DetailViewModel = DetailViewModel.getInstance();
  private selects: number[] = [];
  controller: CustomDialogController = new CustomDialogController({
    builder: RepeatDialog(),
    autoCancel: true
  });

  @Consume(DetailConstant.DEFAULT_PROVIDER_KEY) alarmItem: AlarmItem;

  aboutToAppear() {
    this.selects = DataTypeUtils.deepCopy(this.alarmItem.repeatDays);
  }

  build() {
    Flex() {
      CommonDialog({
        title: $r('app.string.reminder_repeat_name'),
        controller: this.controller,
        onConfirm: () => {
          this.selects.sort();
          this.alarmItem.repeatDays = this.selects;
          this.alarmItem.isRepeat = this.selects.length > 0;
        }
      }) {
        ForEach(DetailConstant.WEEKDAY_DATA,
          (item: number) => {
            Row() {
              Text(this.viewModel.transAlarmRepeatDayContent(item))
                .layoutWeight(CommonConstants.DEFAULT_LAYOUT_WEIGHT)
                .fontColor($r('app.color.grey_divider'))
                .fontSize(DimensionUtils.getFp($r('app.float.reminder_repeat_dialog_check_font_size')))
              Checkbox({
                name: item.toString()
              })
                .width(DimensionUtils.getVp($r('app.float.reminder_repeat_dialog_check_box_size')))
                .height(DimensionUtils.getVp($r('app.float.reminder_repeat_dialog_check_box_size')))
                .select(this.alarmItem.repeatDays.indexOf(item) !== CommonConstants.DEFAULT_NUMBER_NEGATIVE)
                .onChange((value: boolean) => {
                  if (value) {
                    this.selects.push(item);
                  } else {
                    let index = this.selects.indexOf(item);
                    this.selects.splice(index, CommonConstants.DEFAULT_SINGLE);
                  }
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