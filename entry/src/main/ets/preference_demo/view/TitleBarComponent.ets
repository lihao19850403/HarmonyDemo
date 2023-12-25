import router from '@ohos.router';
import StyleConstants from '../common/constants/StyleConstants';

@Component
export struct TitleBarComponent {
  isBack: boolean = true;
  title: Resource = $r('app.string.preference_empty');

  build() {
    Row() {
      if (this.isBack) {
        Image($r('app.media.preference_ic_public_back'))
          .width($r('app.float.preference_title_ic_size'))
          .height($r('app.float.preference_title_ic_size'))
          .margin({
            right: $r('app.float.preference_title_ic_margin')
          })
          .onClick(() => router.back())
      }
      Text(this.title)
        .fontColor(Color.Black)
        .fontSize($r('sys.float.ohos_id_text_size_headline8'))
        .fontWeight(FontWeight.Medium)
        .margin({
          left: $r('app.float.preference_title_text_margin_left')
        })
    }
    .width(StyleConstants.FULL_WIDTH)
    .height(StyleConstants.TITLE_BAR_HEIGHT_PERCENT)
    .padding({
      left: $r('app.float.preference_title_padding_left')
    })
  }
}