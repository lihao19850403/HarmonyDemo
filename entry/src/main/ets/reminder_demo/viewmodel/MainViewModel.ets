import { CommonConstants, WeekDays } from '../common/constants/CommonConstants';
import { MainConstant } from '../common/constants/MainConstant';
import DataTypeUtils from '../common/utils/DataTypeUtils';
import { GlobalContext } from '../common/utils/GlobalContext';
import { AlarmItem } from '../model/AlarmItem';
import { PreferenceHandler } from '../model/database/PreferenceHandler';
import ReminderService from '../model/ReminderService';

export class MainViewModel {
  private static instance: MainViewModel;
  private reminderService: ReminderService;
  private alarms: Array<AlarmItem>;

  private constructor() {
    this.alarms = new Array<AlarmItem>();
    this.reminderService = new ReminderService();
    this.reminderService.openNotificationPermission();
  }

  public static getInstance(): MainViewModel {
    if (!MainViewModel.instance) {
      MainViewModel.instance = new MainViewModel();
    }
    return MainViewModel.instance;
  }

  private queryDatabaseAlarms(callback: (alarms: Array<AlarmItem>) => void) {
    let preference = GlobalContext.getInstance().getObject("preference") as PreferenceHandler;
    preference.get(CommonConstants.ALARM_KEY)
      .then((data: string) => {
        if (!DataTypeUtils.isNull(data)) {
          this.alarms = JSON.parse(data);
          callback(this.alarms);
        }
      });
  }

  private getAlarmRepeatDayContent(repeatDays: Array<number>): string {
    let content = MainConstant.DEFAULT_STRING_NULL;
    for (let i = 0; i < repeatDays.length; i++) {
      let repeatDay = repeatDays[i];
      let repeatContent: string = CommonConstants.DEFAULT_STRING_MONDAY;
      switch (repeatDay) {
        case WeekDays.DEFAULT_NUMBER_MONDAY:
          repeatContent = CommonConstants.DEFAULT_STRING_MONDAY;
          break;
        case WeekDays.DEFAULT_NUMBER_TUESDAY:
          repeatContent = CommonConstants.DEFAULT_STRING_TUESDAY;
          break;
        case WeekDays.DEFAULT_NUMBER_WEDNESDAY:
          repeatContent = CommonConstants.DEFAULT_STRING_WEDNESDAY;
          break;
        case WeekDays.DEFAULT_NUMBER_THURSDAY:
          repeatContent = CommonConstants.DEFAULT_STRING_THURSDAY;
          break;
        case WeekDays.DEFAULT_NUMBER_FRIDAY:
          repeatContent = CommonConstants.DEFAULT_STRING_FRIDAY;
          break;
        case WeekDays.DEFAULT_NUMBER_SATURDAY:
          repeatContent = CommonConstants.DEFAULT_STRING_SATURDAY;
          break;
        case WeekDays.DEFAULT_NUMBER_SUNDAY:
          repeatContent = CommonConstants.DEFAULT_STRING_SUNDAY;
          break;
        default:
          break;
      }
      content += (repeatContent + CommonConstants.DEFAULT_STRING_SPACE);
    }
    return content;
  }

  public queryAlarmTask(callback: (alarms: Array<AlarmItem>) => void) {
    let that = this;
    that.queryDatabaseAlarms(callback);
    let preference = GlobalContext.getInstance().getObject("preference") as PreferenceHandler;
    preference.addPreferenceListener({
      onDataChanged: (key: string) => {
        that.queryDatabaseAlarms(callback);
      }
    });
  }
  
  public fillZero(val: number): string {
    if (val > MainConstant.DEFAULT_SINGLE_DIGIT_MAX) {
      return val.toString();
    }
    return MainConstant.DEFAULT_ZEROING + val;
  }

  public getNoonContent(hour: number): string {
    if (hour < CommonConstants.DEFAULT_TOTAL_HOUR) {
      return MainConstant.DEFAULT_STRING_MORNING;
    }
    return MainConstant.DEFAULT_STRING_AFTERNOON;
  }

  public getTaskTimeContent(hour: number, minute: number): string {
    var hourInfo = hour;
    if (hour > CommonConstants.DEFAULT_TOTAL_HOUR) {
      hourInfo = hour - CommonConstants.DEFAULT_TOTAL_HOUR;
    }
    return this.fillZero(hourInfo) + MainConstant.DEFAULT_STRING_COLON + this.fillZero(minute);
  }

  public getDescContent(alarmItem: AlarmItem): string {
    var repeatInfo = CommonConstants.DEFAULT_STRING_NO_REPEAT;
    if (alarmItem.isRepeat) {
      repeatInfo = this.getAlarmRepeatDayContent(alarmItem.repeatDays);
    }
    return alarmItem.name + CommonConstants.DEFAULT_STRING_COMMA + repeatInfo;
  }

  public openAlarm(id: number, isOpen: boolean, bundleName: string, abilityName: string) {
    if (this.alarms.length === 0) {
      return;
    }

    for (let i = 0; i < this.alarms.length; i++) {
      if (this.alarms[i].id === id) {
        this.alarms[i].isOpen = isOpen;
        if (isOpen) {
          this.reminderService.addReminder(this.alarms[i], bundleName, abilityName);
        } else {
          this.reminderService.deleteReminder(this.alarms[i].id);
        }
        let preference = GlobalContext.getInstance().getObject("preference") as PreferenceHandler;
        preference.set(CommonConstants.ALARM_KEY, JSON.stringify(this.alarms));
        break;
      }
    }
  }
}