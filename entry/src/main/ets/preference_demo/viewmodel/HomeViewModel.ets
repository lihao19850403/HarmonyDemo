import { SettingData } from '../model/SettingData'

export class HomeViewModel {
  settingArr: Array<SettingData> = [];

  initSettingData(): Array<SettingData> {
    if (this.settingArr.length === 0) {
      this.settingArr = new Array();
      let settingData = new SettingData();
      settingData.settingName = $r('app.string.preference_home_display_and_brightness');
      settingData.settingImage = $r('app.media.preference_ic_display_and_brightness');
      this.settingArr.push(settingData);
      settingData = new SettingData();
      settingData.settingName = $r('app.string.preference_home_voice');
      settingData.settingImage = $r('app.media.preference_ic_voice');
      this.settingArr.push(settingData);
      settingData = new SettingData();
      settingData.settingName = $r('app.string.preference_home_app_management');
      settingData.settingImage = $r('app.media.preference_ic_app_management');
      this.settingArr.push(settingData);
      settingData = new SettingData();
      settingData.settingName = $r('app.string.preference_home_storage');
      settingData.settingImage = $r('app.media.preference_ic_storage');
      this.settingArr.push(settingData);
      settingData = new SettingData();
      settingData.settingName = $r('app.string.preference_home_privacy');
      settingData.settingImage = $r('app.media.preference_ic_privacy');
      this.settingArr.push(settingData);
      settingData = new SettingData();
      settingData.settingName = $r('app.string.preference_home_setting_the_font_size');
      settingData.settingImage = $r('app.media.preference_ic_setting_the_font_size');
      this.settingArr.push(settingData);
    }
    return this.settingArr;
  }
}

export default new HomeViewModel();