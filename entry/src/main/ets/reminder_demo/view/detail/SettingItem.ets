import { AlarmSettingType } from '../../common/constants/AlarmSettingType';
import { CommonConstants } from '../../common/constants/CommonConstants';
import DimensionUtils from '../../common/utils/DimensionUtils';
import { AlarmSettingItem } from '../../model/AlarmSettingItem';
import { DurationDialog } from './dialog/DurationDialog';
import { IntervalDialog } from './dialog/IntervalDialog';
import { RenameDialog } from './dialog/RenameDialog';
import RepeatDialog from './dialog/RepeatDialog';

@Component
export struct SettingItem {
  repeatDialogController: CustomDialogController = new CustomDialogController({
    builder: RepeatDialog(),
    autoCancel: true
  });
  reNameDialogController: CustomDialogController = new CustomDialogController({
    builder: RenameDialog(),
    autoCancel: true
  });
  durationDialogController: CustomDialogController = new CustomDialogController({
    builder: DurationDialog(),
    autoCancel: true
  });
  intervalDialogController: CustomDialogController = new CustomDialogController({
    builder: IntervalDialog(),
    autoCancel: true
  });

  @Link settingInfo: Array<AlarmSettingItem>;

  private showSettingDialog(sType: AlarmSettingType) {
    switch (sType) {
      case AlarmSettingType.REPEAT:
        this.repeatDialogController.open();
        break;
      case AlarmSettingType.ALARM_NAME:
        this.reNameDialogController.open();
        break;
      case AlarmSettingType.RING_DURATION:
        this.durationDialogController.open();
        break;
      case AlarmSettingType.INTERVAL:
        this.intervalDialogController.open();
        break;
      default:
        break
    }
  }

  build() {
    Column() {
      ForEach(this.settingInfo, (item: AlarmSettingItem, index: number | undefined) => {
        Divider()
          .visibility(index === 0 ? Visibility.Hidden : Visibility.Visible)
          .opacity($r('app.float.reminder_divider_opacity'))
          .color($r('app.color.grey_divider'))
          .lineCap(LineCapStyle.Round)
          .margin({
            left: DimensionUtils.getVp($r('app.float.reminder_setting_item_divider_margin_horizon')),
            right: DimensionUtils.getVp($r('app.float.reminder_setting_item_divider_margin_horizon'))
          })
        Row() {
          Text(item.title)
            .fontSize(DimensionUtils.getFp($r('app.float.reminder_setting_item_name_font_size')))
            .fontWeight(FontWeight.Regular)
            .fontColor($r('app.color.grey_divider'))
            .layoutWeight(CommonConstants.DEFAULT_LAYOUT_WEIGHT)
          Text(item.content)
            .fontSize(DimensionUtils.getFp($r('app.float.reminder_setting_item_content_font_size')))
            .fontWeight(FontWeight.Normal)
            .fontColor($r('app.color.grey_divider'))
            .opacity($r('app.float.reminder_setting_item_content_font_opacity'))
          Image($r('app.media.reminder_ic_right'))
            .width(DimensionUtils.getVp($r('app.float.reminder_setting_item_image_width')))
            .height(DimensionUtils.getVp($r('app.float.reminder_setting_item_image_height')))
            .objectFit(ImageFit.Fill)
            .margin({
              left: DimensionUtils.getVp($r('app.float.reminder_setting_item_image_margin_horizon'))
            })
        }
        .height(DimensionUtils.getVp($r('app.float.reminder_setting_item_height')))
        .alignItems(VerticalAlign.Center)
        .padding({
          left: DimensionUtils.getVp($r('app.float.reminder_setting_item_interval')),
          right: DimensionUtils.getVp($r('app.float.reminder_setting_item_interval'))
        })
        .onClick(() => {
          this.showSettingDialog(item.sType);
        })
      }, (item: AlarmSettingItem, index: number | undefined) => JSON.stringify(item) + index)
    }
    .margin({
      bottom: DimensionUtils.getVp($r('app.float.reminder_setting_item_interval')),
      left: DimensionUtils.getVp($r('app.float.reminder_setting_item_interval')),
      right: DimensionUtils.getVp($r('app.float.reminder_setting_item_interval'))
    })
    .borderRadius(DimensionUtils.getVp($r('app.float.reminder_setting_item_border_radius')))
    .backgroundColor(Color.White)
  }
}