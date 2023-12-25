import StyleConstants from '../common/constants/StyleConstants';
import PreferenceUtils from '../common/database/PreferenceUtils';
import { ChatData } from '../model/ChatData';
import { ChatItemComponent } from '../view/ChatItemComponent';
import { SliderLayout } from '../view/SliderLayout';
import { TitleBarComponent } from '../view/TitleBarComponent';
import SettingViewModel from "../viewmodel/SettingViewModel";

@Entry
@Component
struct SettingFontSizePage {
  private contentArr = SettingViewModel.initChatData();

  @State changedFontSize: number = 0;
  @State fontSizeText: Resource = $r("app.string.preference_set_size_normal");
  @State isInitialized: boolean = false;

  onPageShow() {
    PreferenceUtils.getChangedFontSize()
      .then((value: number) => {
        this.changedFontSize = value;
        this.fontSizeText = SettingViewModel.getTextByFontSize(value);
        this.isInitialized = true;
      });
  }

  build() {
    if (this.isInitialized) {
      Column() {
        TitleBarComponent({
          title: $r("app.string.preference_set_title")
        })
        if (this.changedFontSize > 0) {
          List() {
            ForEach(this.contentArr,
              (item: ChatData, index?: number) => {
                ListItem() {
                  ChatItemComponent({
                    item: item,
                    changedFontSize: this.changedFontSize
                  })
                }
              },
              (item: ChatData, index?: number) => {
                return JSON.stringify(item) + index;
              })
          }
          .layoutWeight(StyleConstants.WEIGHT_FULL)
        }
        SliderLayout({
          changedFontSize: $changedFontSize,
          fontSizeText: $fontSizeText
        })
      }
      .backgroundColor($r('sys.color.ohos_id_color_sub_background'))
      .height(StyleConstants.FULL_HEIGHT)
      .width(StyleConstants.FULL_WIDTH)
    }
  }
}