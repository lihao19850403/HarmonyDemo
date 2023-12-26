import router from '@ohos.router';
import display from '@ohos.display';
import { CommonConstants } from '../common/constants/CommonConstants';
import { MainConstant } from '../common/constants/MainConstant';
import DimensionUtils from '../common/utils/DimensionUtils';
import { GlobalContext } from '../common/utils/GlobalContext';
import { AlarmItem } from '../model/AlarmItem';
import { PreferenceHandler } from '../model/database/PreferenceHandler';
import { AlarmList } from '../view/main/AlarmList';
import ClockArea from '../view/main/ClockArea';
import { MainViewModel } from '../viewmodel/MainViewModel';

@Entry
@Component
struct MainIndex {
  private mainModel: MainViewModel = MainViewModel.getInstance();

  @State alarmItems: Array<AlarmItem> = new Array();
  @State isAuth: boolean = false;
  @State isInitialized: boolean = false;

  aboutToAppear() {
    // 初始化参数。
    let globalDisplay: display.Display = display.getDefaultDisplaySync();
    GlobalContext.getInstance().setObject('globalDisplay', globalDisplay);
    let preference = PreferenceHandler.getInstance();
    GlobalContext.getInstance().setObject('preference', preference);
    let context = getContext(this);
    preference.configure(context.getApplicationContext());
    let that = this;
    that.mainModel.queryAlarmTask((alarms: Array<AlarmItem>) => {
      that.alarmItems = alarms;
    });
    this.isInitialized = true;
  }

  build() {
    if (this.isInitialized) {
      Column() {
        Text(MainConstant.DEFAULT_STRING_ALARM)
          .height(DimensionUtils.getVp($r('app.float.reminder_page_title_height')))
          .textAlign(TextAlign.Start)
          .fontSize(DimensionUtils.getFp($r('app.float.reminder_title_font_size')))
          .width(CommonConstants.FULL_LENGTH)
          .fontColor($r('app.color.grey_divider'))
          .fontWeight(FontWeight.Bold)
          .margin({
            bottom: DimensionUtils.getVp($r('app.float.reminder_content_margin_body'))
          })
          .padding({
            left: DimensionUtils.getVp($r('app.float.reminder_title_horizon_margin'))
          })
        ClockArea()
        AlarmList({
          alarmItems: $alarmItems
        })
        Blank()
        Button() {
          Image($r('app.media.reminder_ic_add'))
            .objectFit(ImageFit.Fill)
        }
        .backgroundColor($r('app.color.trans_parent'))
        .width(DimensionUtils.getVp($r('app.float.reminder_new_alarm_button_size')))
        .height(DimensionUtils.getVp($r('app.float.reminder_new_alarm_button_size')))
        .margin({
          bottom: DimensionUtils.getVp($r('app.float.reminder_new_alarm_button_margin_vertical')),
          top: DimensionUtils.getVp($r('app.float.reminder_new_alarm_button_margin_vertical'))
        })
        .onClick(() => {
          router.pushUrl({
            url: 'reminder_demo/pages/DetailIndex'
          });
        })
      }
      .width(CommonConstants.FULL_LENGTH)
      .height(CommonConstants.FULL_LENGTH)
      .backgroundColor($r('app.color.grey_light'))
    }
  }
}