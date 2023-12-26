import { CommonConstants } from '../../../common/constants/CommonConstants';
import { DetailConstant } from '../../../common/constants/DetailConstant';
import DimensionUtils from '../../../common/utils/DimensionUtils';
import { AlarmItem } from '../../../model/AlarmItem';
import { CommonDialog } from './CommonDialog';

@CustomDialog
export struct RenameDialog {
  private name: string = '';
  controller: CustomDialogController = new CustomDialogController({
    builder: RenameDialog(),
    autoCancel: true
  });

  @Consume(DetailConstant.DEFAULT_PROVIDER_KEY) alarmItem: AlarmItem;

  build() {
    Flex() {
      CommonDialog({
        title: $r('app.string.reminder_alarm_name'),
        controller: this.controller,
        onConfirm: () => this.alarmItem.name = this.name
      }) {
        TextArea({
          text: this.alarmItem.name
        })
          .width(CommonConstants.FULL_LENGTH)
          .margin({
            bottom: DimensionUtils.getVp($r('app.float.reminder_rename_dialog_text_margin_bottom'))
          })
          .onChange((value: string) => this.name = value)
        Divider()
          .opacity($r('app.float.reminder_divider_opacity'))
          .color($r('app.color.grey_divider'))
          .lineCap(LineCapStyle.Round)
      }
    }
  }
}