import CommonConstants from '../common/constants/CommonConstants';

@Component
export struct TextInputWidget {
  private inputImage?: Resource;
  private hintText?: Resource;

  build() {
    Row() {
      Image(this.inputImage ? this.inputImage : '')
        .width($r('app.float.multi_dialogs_input_image_size'))
        .height($r('app.float.multi_dialogs_input_image_size'))
        .margin({
          left: $r('app.float.multi_dialogs_input_image_left')
        })
      TextInput({
        placeholder: this.hintText
      })
        .height($r('app.float.multi_dialogs_text_input_height'))
        .fontSize($r('app.float.multi_dialogs_input_text_size'))
        .fontWeight(FontWeight.Normal)
        .fontStyle(FontStyle.Normal)
        .fontColor(Color.Black)
        .padding({
          left: $r('app.float.multi_dialogs_input_left_inside'),
          right: $r('app.float.multi_dialogs_input_left_inside'),
        })
        .margin({
          right: $r('app.float.multi_dialogs_input_right_inside')
        })
        .placeholderColor($r('app.color.shop_mall_placeholder_color'))
        .backgroundColor(Color.White)
        .layoutWeight(CommonConstants.WEIGHT_ONE)
    }
    .width(CommonConstants.COMMON_DIALOG_WIDTH)
    .height($r("app.float.multi_dialogs_input_row_height"))
    .margin({
      top: $r("app.float.multi_dialogs_input_row_top")
    })
    .borderRadius($r("app.float.multi_dialogs_input_row_radius"))
    .backgroundColor(Color.White)
  }
}