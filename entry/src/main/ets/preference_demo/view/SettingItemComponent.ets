import StyleConstants from '../common/constants/StyleConstants';
import { SettingData } from '../model/SettingData';

@Component
export struct SettingItemComponent {
  setting: SettingData = new SettingData();
  itemClick: Function = () => {};

  @Prop changeFontSize: number;

  build() {
    Row() {
      Image(this.setting.settingImage)
        .width($r('app.float.preference_setting_item_ic_size'))
        .height($r('app.float.preference_setting_item_ic_size'))
        .margin({
          left: $r('app.float.preference_setting_ic_margin_left'),
          right: $r('app.float.preference_setting_ic_margin_right') })
      Text(this.setting.settingName)
        .fontSize(this.changeFontSize + StyleConstants.UNIT_FP)
        .fontWeight(FontWeight.Medium)
        .fontColor($r('app.color.preference_text'))
    }
    .width(StyleConstants.FULL_WIDTH)
    .height($r('app.float.preference_setting_item_height'))
    .onClick(() => this.itemClick())
  }
}