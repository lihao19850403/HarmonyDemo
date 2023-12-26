import { ReminderItem } from './ReminderItem';

@Observed
export class AlarmItem extends ReminderItem {
  name = '闹钟';
  isOpen: boolean = true;
  isRepeat: boolean = false;
  duration: number = 5;
  intervalMinute: number = 10;
  intervalTimes: number = 3;
}