import router from '@ohos.router';
import common from '@ohos.app.ability.common';
import { AlarmSettingType } from '../common/constants/AlarmSettingType';
import { CommonConstants } from '../common/constants/CommonConstants';
import { DetailConstant } from '../common/constants/DetailConstant';
import DimensionUtils from '../common/utils/DimensionUtils';
import { AlarmItem } from '../model/AlarmItem';
import { AlarmSettingItem } from '../model/AlarmSettingItem';
import BackContainer from '../view/BackContainer';
import { DetailViewModel } from '../viewmodel/DetailViewModel';
import { DatePickArea } from '../view/detail/DatePickArea';
import { SettingItem } from '../view/detail/SettingItem';

@Entry
@Component
struct DetailIndex {
  private context = getContext(this) as common.UIAbilityContext;
  private isNow: boolean = true;
  private viewModel: DetailViewModel = DetailViewModel.getInstance();
  private bundleName: string;
  private abilityName: string;

  @Provide(DetailConstant.DEFAULT_PROVIDER_KEY) @Watch('onAlarmItemChange')  alarmItem: AlarmItem = new AlarmItem();
  @State repeatSettingArr: Array<AlarmSettingItem> = [];
  @State alarmSettingInfoArr: Array<AlarmSettingItem> = [];

  aboutToAppear() {
    let params = router.getParams() as Record<string, Object | undefined>;
    if (params !== undefined) {
      let alarmItem: AlarmItem = params.alarmItem as AlarmItem;
      if (alarmItem !== undefined) {
        this.isNow = false;
        this.alarmItem = alarmItem;
        this.viewModel.setAlarmDefaultTime(this.alarmItem);
      }else {
        this.viewModel.setAlarmDefaultTime();
      }
    } else {
      this.viewModel.setAlarmDefaultTime();
    }
    this.initData();
  }

  onAlarmItemChange() {
    this.initData();
  }

  initData() {
    this.repeatSettingArr = [
      new AlarmSettingItem(
        DetailConstant.DEFAULT_STRING_REPEAT,
        this.alarmItem.isRepeat ? DetailConstant.DEFAULT_STRING_REPEAT : CommonConstants.DEFAULT_STRING_NO_REPEAT,
        AlarmSettingType.REPEAT
      )
    ];
    this.alarmSettingInfoArr = [
      new AlarmSettingItem(
        DetailConstant.DEFAULT_STRING_ALARM_NAME,
        this.alarmItem.name,
        AlarmSettingType.ALARM_NAME
      ),
      new AlarmSettingItem(
        DetailConstant.DEFAULT_STRING_DURATION,
        this.alarmItem.duration + DetailConstant.DEFAULT_STRING_MINUTE,
        AlarmSettingType.RING_DURATION
      ),
      new AlarmSettingItem(
        DetailConstant.DEFAULT_STRING_INTERVAL,
        this.alarmItem.intervalMinute + DetailConstant.DEFAULT_STRING_MINUTE + CommonConstants.DEFAULT_STRING_COMMA + this.alarmItem.intervalTimes + DetailConstant.DEFAULT_STRING_TIMES,
        AlarmSettingType.INTERVAL
      )
    ];
    this.bundleName = this.context.abilityInfo.bundleName;
    this.abilityName = this.context.abilityInfo.name;
  }

  build() {
    Column() {
      BackContainer({
        header: this.isNow ? $r('app.string.reminder_new_alarm') : $r('app.string.reminder_update_alarm'),
        backImgRes: $r('app.media.reminder_ic_cancel'),
      }) {
        Button() {
          Image($r('app.media.reminder_ic_confirm'))
            .objectFit(ImageFit.Fill)
        }
        .backgroundColor($r('app.color.trans_parent'))
        .width(DimensionUtils.getVp($r('app.float.reminder_title_button_size')))
        .height(DimensionUtils.getVp($r('app.float.reminder_title_button_size')))
        .onClick(() => {
          this.viewModel.setAlarmRemind(this.alarmItem, this.bundleName, this.abilityName);
          router.back();
        })
      }
      DatePickArea()
      SettingItem({
        settingInfo: $repeatSettingArr
      })
      SettingItem({
        settingInfo: $alarmSettingInfoArr
      })
      Blank()
      Button($r('app.string.reminder_delete'))
        .visibility(this.isNow ? Visibility.None : Visibility.Visible)
        .width(DimensionUtils.getVp($r('app.float.reminder_delete_button_width')))
        .height(DimensionUtils.getVp($r('app.float.reminder_delete_button_height')))
        .fontSize(DimensionUtils.getFp($r('app.float.reminder_delete_button_font_size')))
        .fontColor($r('app.color.red_light'))
        .backgroundColor($r('app.color.grey_with_opacity'))
        .borderRadius(DimensionUtils.getVp($r('app.float.reminder_delete_button_radius')))
        .margin({
          bottom: DimensionUtils.getVp($r('app.float.reminder_delete_button_margin_bottom'))
        })
        .onClick(() => {
          this.viewModel.removeAlarmRemind(this.alarmItem.id);
          router.back();
        })
    }
    .backgroundColor($r('app.color.grey_light'))
    .width(CommonConstants.FULL_LENGTH)
    .height(CommonConstants.FULL_LENGTH)
  }
}