import router from '@ohos.router';
import { CommonConstants } from '../../common/constants/CommonConstants';
import DimensionUtils from '../../common/utils/DimensionUtils';
import { AlarmItem } from '../../model/AlarmItem';
import AlarmListItem from './AlarmListItem';

@Component
export struct AlarmList {
  @Link alarmItems: Array<AlarmItem>;

  build() {
    List({
      space: DimensionUtils.getVp($r('app.float.reminder_alarm_list_space'))
    }) {
      ForEach(this.alarmItems, (item: AlarmItem) => {
        ListItem() {
          AlarmListItem({
            alarmItem: item
          })
        }.onClick(() => {
          router.pushUrl({
            url: 'reminder_demo/pages/DetailIndex',
            params: {
              alarmItem: item
            }
          });
        })
      }, (item: AlarmItem) => JSON.stringify(item))
    }
    .padding({
      left: DimensionUtils.getVp($r('app.float.reminder_alarm_list_content_distance')),
      right: DimensionUtils.getVp($r('app.float.reminder_alarm_list_content_distance'))
    })
    .listDirection(Axis.Vertical)
    .layoutWeight(CommonConstants.DEFAULT_LAYOUT_WEIGHT)
    .margin({
      top: DimensionUtils.getVp($r('app.float.reminder_alarm_list_content_distance'))
    })
  }
}