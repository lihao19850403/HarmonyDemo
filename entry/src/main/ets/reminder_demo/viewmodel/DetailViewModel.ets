import { CommonConstants, WeekDays } from '../common/constants/CommonConstants';
import { DetailConstant } from '../common/constants/DetailConstant';
import DataTypeUtils from '../common/utils/DataTypeUtils';
import { GlobalContext } from '../common/utils/GlobalContext';
import { AlarmItem } from '../model/AlarmItem';
import { PreferenceHandler } from '../model/database/PreferenceHandler';
import { DayDataItem } from '../model/DayDataItem';
import ReminderService from '../model/ReminderService';

export class DetailViewModel {
  private static instance: DetailViewModel;
  private reminderService: ReminderService;
  private alarms: Array<AlarmItem>;

  private constructor() {
    this.reminderService = new ReminderService();
    this.alarms = new Array<AlarmItem>();
  }

  public static getInstance(): DetailViewModel {
    if (!DetailViewModel.instance) {
      DetailViewModel.instance = new DetailViewModel();
    }
    return DetailViewModel.instance;
  }

  public transAlarmRepeatDayContent(repeatDay: number): string {
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
    return repeatContent;
  }

  public setAlarmDefaultTime(alarmItem?: AlarmItem) {
    let hour: number;
    let minute: number;
    if (!alarmItem) {
      let date = new Date();
      hour = date.getHours();
      minute = date.getMinutes();
    } else {
      hour = alarmItem.hour;
      minute = alarmItem.minute;
    }
    if (hour >= CommonConstants.DEFAULT_TOTAL_HOUR) {
      DetailConstant.DAY_DATA[0].delSelect = CommonConstants.DEFAULT_SINGLE;
    } else {
      DetailConstant.DAY_DATA[0].delSelect = 0;
    }
    let singleDelSelectValue: number;
    if (hour === 0) {
      singleDelSelectValue = CommonConstants.DEFAULT_TOTAL_HOUR;
    } else {
      if (hour > CommonConstants.DEFAULT_TOTAL_HOUR) {
        singleDelSelectValue = hour - CommonConstants.DEFAULT_TOTAL_HOUR;
      } else {
        singleDelSelectValue = hour;
      }
    }
    DetailConstant.DAY_DATA[CommonConstants.DEFAULT_SINGLE].delSelect =
      singleDelSelectValue - CommonConstants.DEFAULT_SINGLE;
    if (minute === 0) {
      DetailConstant.DAY_DATA[CommonConstants.DEFAULT_DATA_PICKER_HOUR_SELECTION].delSelect =
        CommonConstants.DEFAULT_TOTAL_MINUTE - CommonConstants.DEFAULT_SINGLE;
    } else {
      DetailConstant.DAY_DATA[CommonConstants.DEFAULT_DATA_PICKER_HOUR_SELECTION].delSelect =
        minute - CommonConstants.DEFAULT_SINGLE;
    }
  }

  public async setAlarmRemind(alarmItem: AlarmItem, bundleName: string, abilityName: string) {
    alarmItem.hour = this.getAlarmTime(CommonConstants.DEFAULT_SINGLE);
    alarmItem.minute = this.getAlarmTime(CommonConstants.DEFAULT_DATA_PICKER_HOUR_SELECTION);
    let index = await this.findAlarmWithID(alarmItem.id);
    if (index !== CommonConstants.DEFAULT_NUMBER_NEGATIVE) {
      this.reminderService.deleteReminder(alarmItem.id);
    } else {
      index = this.alarms.length;
      alarmItem.notificationId = index;
      this.alarms.push(alarmItem);
    }
    this.reminderService.addReminder(alarmItem, bundleName, abilityName, (newID: number) => {
      alarmItem.id = newID;
      alarmItem.isOpen = true;
      this.alarms[index] = alarmItem;
      let preference = GlobalContext.getInstance().getObject("preference") as PreferenceHandler;
      preference.set(CommonConstants.ALARM_KEY, JSON.stringify(this.alarms));
    });
  }

  public async removeAlarmRemind(id: number) {
    this.reminderService.deleteReminder(id);
    let index = await this.findAlarmWithID(id);
    if (index !== CommonConstants.DEFAULT_NUMBER_NEGATIVE) {
      this.alarms.splice(index, CommonConstants.DEFAULT_SINGLE);
    }
    let preference = GlobalContext.getInstance().getObject("preference") as PreferenceHandler;
    preference.set(CommonConstants.ALARM_KEY, JSON.stringify(this.alarms));
  }

  private getAlarmTime(aType: number): number {
    let times: DayDataItem = DetailConstant.DAY_DATA[aType];
    let selectedIndex = times.delSelect;
    let time = Number(times.data[selectedIndex]);
    if (aType === CommonConstants.DEFAULT_SINGLE) {
      let preHour: number = time;
      if (time === CommonConstants.DEFAULT_TOTAL_HOUR) {
        preHour = 0;
      }
      let lastHour: number = 0;
      if (DetailConstant.DAY_DATA[0].delSelect === CommonConstants.DEFAULT_SINGLE) {
        lastHour = CommonConstants.DEFAULT_TOTAL_HOUR;
      }
      time = preHour + lastHour;
    }
    return time;
  }

  private async findAlarmWithID(id: number) {
    let preference = GlobalContext.getInstance().getObject("preference") as PreferenceHandler;
    let data = await preference.get(CommonConstants.ALARM_KEY);
    if (!DataTypeUtils.isNull(data)) {
      this.alarms = JSON.parse(data);
      for (let index = 0; index < this.alarms.length; index++) {
        if (this.alarms[index].id === id) {
          return index;
        }
      }
    }
    return CommonConstants.DEFAULT_NUMBER_NEGATIVE;
  }
}