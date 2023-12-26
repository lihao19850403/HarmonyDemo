import notification from '@ohos.notificationManager'
import reminderAgent from '@ohos.reminderAgentManager';
import { CommonConstants } from '../common/constants/CommonConstants';
import { ReminderItem } from './ReminderItem';

export default class ReminderService {

  public openNotificationPermission() {
    notification.requestEnableNotification()
      .then(() => console.log('Enable notification success'))
      .catch((error) => 'Enable notification failed because ' + JSON.stringify(error));
  }

  public addReminder(
    alarmItem: ReminderItem,
    bundleName: string,
    abilityName: string,
    callback?: (reminderID: number) => void) {
    let reminder: reminderAgent.ReminderRequestAlarm = {
      reminderType: alarmItem.remindType,
      hour: alarmItem.hour,
      minute: alarmItem.minute,
      daysOfWeek: alarmItem.repeatDays,
      title: alarmItem.name,
      ringDuration: alarmItem.duration * CommonConstants.DEFAULT_TOTAL_MINUTE,
      snoozeTimes: alarmItem.intervalTimes,
      timeInterval: alarmItem.intervalMinute * CommonConstants.DEFAULT_TOTAL_MINUTE,
      actionButton: [
        {
          title: "关闭",
          type: reminderAgent.ActionButtonType.ACTION_BUTTON_TYPE_CLOSE
        },
        {
          title: "稍后提醒",
          type: reminderAgent.ActionButtonType.ACTION_BUTTON_TYPE_SNOOZE
        }
      ],
      wantAgent: {
        pkgName: bundleName,
        abilityName: abilityName
      },
      notificationId: alarmItem.notificationId,
      expiredContent: "此提醒已过期",
      snoozeContent: "稍后提醒我",
      slotType: notification.SlotType.SOCIAL_COMMUNICATION
    };
    reminderAgent.publishReminder(reminder)
      .then((reminderID: number) => {
        if (callback) {
          callback(reminderID);
        }
      })
  }

  deleteReminder(reminderID: number) {
    reminderAgent.cancelReminder(reminderID);
  }
}