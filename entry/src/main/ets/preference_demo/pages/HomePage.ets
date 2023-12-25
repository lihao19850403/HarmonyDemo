import router from '@ohos.router';
import CommonConstants from '../common/constants/CommonConstants';
import StyleConstants from '../common/constants/StyleConstants'
import PreferenceUtils from '../common/database/PreferenceUtils';
import { SettingData } from '../model/SettingData';
import { SettingItemComponent } from '../view/SettingItemComponent';
import { TitleBarComponent } from '../view/TitleBarComponent';
import HomeViewModel from "../viewmodel/HomeViewModel";

@Extend(Row)
function blockBackground(marginTop: string) {
  .width(StyleConstants.BLOCK_WIDTH_PERCENT)
  .backgroundColor(Color.White)
  .borderRadius($r('app.float.preference_block_background_radius'))
  .margin({
    top: marginTop
  })
  .padding({
    top: $r('app.float.preference_block_vertical_padding'),
    bottom: $r('app.float.preference_block_vertical_padding')
  })
}

@Entry
@Component
struct HomePage {
  private settingArr = HomeViewModel.initSettingData();

  @State changedFontSize: number = CommonConstants.SET_SIZE_NORMAL;
  @State isInitialized: boolean = false;

  async onPageShow() {
    PreferenceUtils.createFontPreference(getContext(this).getApplicationContext());
    await PreferenceUtils.saveDefaultFontSize(CommonConstants.SET_SIZE_NORMAL);
    PreferenceUtils.getChangedFontSize()
      .then((value: number) => {
        this.changedFontSize = value;
        this.isInitialized = true;
      })
  }

  build() {
    if (this.isInitialized) {
      Column() {
        TitleBarComponent({
          isBack: true,
          title: $r("app.string.preference_home_title")
        })
        Row() {
          SettingItemComponent({
            setting: this.settingArr[CommonConstants.DISPLAY_INDEX],
            changeFontSize: this.changedFontSize,
            itemClick: () => {}
          })
        }
        .blockBackground(StyleConstants.BLOCK_TOP_MARGIN_FIRST_PERCENT)
        Row() {
          SettingItemComponent({
            setting: this.settingArr[CommonConstants.VOICE_INDEX],
            changeFontSize: this.changedFontSize,
            itemClick: () => {}
          })
        }
        .blockBackground(StyleConstants.BLOCK_TOP_MARGIN_SECOND_PERCENT)
        Row() {
          this.settingItems()
        }
        .blockBackground(StyleConstants.BLOCK_TOP_MARGIN_SECOND_PERCENT)
      }
      .width(StyleConstants.FULL_WIDTH)
      .height(StyleConstants.FULL_HEIGHT)
      .backgroundColor($r("sys.color.ohos_id_color_sub_background"))
    }
  }

  @Builder settingItems() {
    List() {
      ForEach(this.settingArr.slice(CommonConstants.START_INDEX, CommonConstants.END_INDEX),
        (item: SettingData, index?: number) => {
          ListItem() {
            SettingItemComponent({
              setting: item,
              changeFontSize: this.changedFontSize,
              itemClick: () => {
                if (index == CommonConstants.SET_FONT_INDEX) {
                  router.pushUrl({
                    url: CommonConstants.SET_URL
                  })
                    .catch((error) => {});
                }
              }
            })
          }
        },
        (item: SettingData, index?: number) => {
          return JSON.stringify(item) + index
        })
    }
    .divider({
      strokeWidth: $r("app.float.preference_setting_item_divider_width"),
      color: $r("app.color.preference_setting_item_divider"),
      startMargin: $r("app.float.preference_setting_item_divider_start_margin"),
      endMargin: StyleConstants.DIVIDER_END_MARGIN_PERCENT
    })
  }
}