import common from '@ohos.app.ability.common';
import { CommonConstants } from '../../common/constants/CommonConstants';
import DimensionUtils from '../../common/utils/DimensionUtils';
import { AlarmItem } from '../../model/AlarmItem';
import { MainViewModel } from '../../viewmodel/MainViewModel';

@Extend(Text)
function CommonTextAttr(fontSize: number, fontWeight: number, margin?: Margin, opacity?: Resource) {
  .fontColor($r('app.color.grey_divider'))
  .fontSize(fontSize)
  .fontWeight(fontWeight)
  .margin(margin != undefined ? margin : 0)
  .opacity(opacity != undefined ? opacity : 1)
}

@Component
export default struct AlarmListItem {
  private context = getContext(this) as common.UIAbilityContext;
  private mainModel: MainViewModel = MainViewModel.getInstance();
  private alarmItem: AlarmItem = new AlarmItem();
  private bundleName: string;
  private abilityName: string;

  aboutToAppear() {
    this.bundleName = this.context.abilityInfo.bundleName;
    this.abilityName = this.context.abilityInfo.name;
  }

  build() {
    Row() {
      Column() {
        Row() {
          Text(this.mainModel.getNoonContent(this.alarmItem.hour))
            .CommonTextAttr(
              DimensionUtils.getFp($r('app.float.reminder_alarms_item_noon_font_size')),
              FontWeight.Regular
            )
          Text(this.mainModel.getTaskTimeContent(this.alarmItem.hour, this.alarmItem.minute))
            .CommonTextAttr(
              DimensionUtils.getFp($r('app.float.reminder_alarms_item_time_font_size')),
              FontWeight.Regular,
              {
                left: DimensionUtils.getVp($r('app.float.reminder_alarms_item_time_margin_left'))
              }
            )
        }
        Text(this.mainModel.getDescContent(this.alarmItem))
          .CommonTextAttr(
            DimensionUtils.getFp($r('app.float.reminder_alarms_item_dec_font_size')),
            FontWeight.Normal,
            {
              top: DimensionUtils.getVp($r('app.float.reminder_alarms_item_dec_margin_top'))
            },
            $r('app.float.reminder_alarms_item_desc_text_opacity')
          )
      }
      .width(CommonConstants.FULL_LENGTH)
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(CommonConstants.DEFAULT_LAYOUT_WEIGHT)
      Toggle({
        type: ToggleType.Switch,
        isOn: this.alarmItem.isOpen
      })
        .onChange((isOn: boolean) => {
          this.mainModel.openAlarm(this.alarmItem.id, isOn, this.bundleName, this.abilityName);
        })
        .width(DimensionUtils.getVp($r('app.float.reminder_alarms_item_toggle_width')))
        .height(DimensionUtils.getVp($r('app.float.reminder_alarms_item_toggle_height')))
    }
    .padding({
      left: DimensionUtils.getVp($r('app.float.reminder_alarm_list_content_distance')),
      right: DimensionUtils.getVp($r('app.float.reminder_alarm_list_content_distance'))
    })
    .width(CommonConstants.FULL_LENGTH)
    .height(DimensionUtils.getVp($r('app.float.reminder_alarms_item_height')))
    .backgroundColor(Color.White)
    .borderRadius(DimensionUtils.getVp($r('app.float.reminder_alarms_item_radius')))
  }
}