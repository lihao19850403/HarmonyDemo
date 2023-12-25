import CommonConstants from '../common/constants/CommonConstants';
import StyleConstants from '../common/constants/StyleConstants';
import PreferenceUtils from '../common/database/PreferenceUtils';
import SettingViewModel from '../viewmodel/SettingViewModel';

@Component
export struct SliderLayout {
  @Link changedFontSize: number;
  @Link fontSizeText: Resource;

  build() {
    Column() {
      Text($r('app.string.preference_set_font_size'))
        .fontSize($r('app.float.preference_set_text'))
        .fontColor($r('app.color.preference_text'))
        .margin({
          left: StyleConstants.SLIDER_LAYOUT_LEFT_PERCENT,
          top: StyleConstants.SLIDER_LAYOUT_TOP_PERCENT
        })
        .fontWeight(FontWeight.Medium)
      Column() {
        Text(this.fontSizeText)
          .fontSize($r('app.float.preference_set_text'))
          .fontColor($r('app.color.preference_text'))
        Row() {
          Text($r('app.string.preference_set_char_a'))
            .width(StyleConstants.A_WIDTH_PERCENT)
            .fontSize($r('app.float.preference_set_small_a'))
            .fontWeight(FontWeight.Medium)
            .fontColor($r('app.color.preference_text'))
            .textAlign(TextAlign.End)
            .padding({
              right: $r('app.float.preference_a_right_padding')
            })
          Slider({
            style: SliderStyle.InSet,
            min: CommonConstants.SET_SLIDER_MIN,
            max: CommonConstants.SET_SLIDER_MAX,
            step: CommonConstants.SET_SLIDER_STEP,
            value: this.changedFontSize === CommonConstants.SET_SIZE_HUGE
              ? CommonConstants.SET_SLIDER_MAX
              : this.changedFontSize
          })
            .width(StyleConstants.SLIDER_WIDTH_PERCENT)
            .showSteps(true)
            .onChange(async (value: number) => {
              if (this.changedFontSize === 0) {
                this.changedFontSize = await PreferenceUtils.getChangedFontSize();
                this.fontSizeText = SettingViewModel.getTextByFontSize(value);
                return;
              }
              this.changedFontSize = (value === CommonConstants.SET_SLIDER_MAX ? CommonConstants.SET_SIZE_HUGE : value);
              this.fontSizeText = SettingViewModel.getTextByFontSize(this.changedFontSize);
              PreferenceUtils.saveChangedFontSize(this.changedFontSize);
            })
          Text($r('app.string.preference_set_char_a'))
            .width(StyleConstants.A_WIDTH_PERCENT)
            .fontSize($r('app.float.preference_set_big_a'))
            .fontWeight(FontWeight.Bold)
            .fontColor($r('app.color.preference_text'))
            .padding({
              left: $r('app.float.preference_a_left_padding')
            })
        }
      }
      .backgroundColor(Color.White)
      .borderRadius($r('app.float.preference_block_background_radius'))
      .width(StyleConstants.BLOCK_WIDTH_PERCENT)
      .padding({
        top: $r('app.float.preference_slider_top_padding'),
        bottom: $r('app.float.preference_slider_bottom_padding')
      })
      .margin({
        left: StyleConstants.SLIDER_HORIZONTAL_MARGIN_PERCENT,
        right: StyleConstants.SLIDER_HORIZONTAL_MARGIN_PERCENT,
        top: StyleConstants.SLIDER_TOP_MARGIN_PERCENT,
        bottom: StyleConstants.SLIDER_BOTTOM_MARGIN_PERCENT
      })
    }
    .alignItems(HorizontalAlign.Start)
    .justifyContent(FlexAlign.End)
  }
}