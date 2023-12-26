import { AlarmSettingType } from '../common/constants/AlarmSettingType';

export class AlarmSettingItem {
  title: string;
  content: string;
  sType: AlarmSettingType;

  constructor(title: string, content: string, sType: AlarmSettingType) {
    this.title = title;
    this.content = content;
    this.sType = sType;
  }
}