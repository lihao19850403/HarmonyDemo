import CommonConstants from '../common/constants/CommonConstants';

@Component
export struct TextCommonWidget {
  private textImage?: Resource;
  private title?: Resource;
  onItemClick?: (event?: ClickEvent) => void;

  @Link content: string;

  build() {
    Row() {
      Image(this.textImage ? this.textImage : '')
        .width($r('app.float.multi_dialogs_text_image_size'))
        .height($r('app.float.multi_dialogs_text_image_size'))
        .margin({
          left: $r('app.float.multi_dialogs_image_left_distance')
        })
      Text(this.title)
        .height(CommonConstants.FULL_HEIGHT)
        .fontSize($r('app.float.multi_dialogs_input_text_size'))
        .margin({
          left: $r('app.float.multi_dialogs_image_left_distance')
        })
      Text(this.content)
        .width(CommonConstants.FULL_WIDTH)
        .fontSize($r('app.float.multi_dialogs_input_text_size'))
        .textAlign(TextAlign.End)
        .textOverflow({
          overflow: TextOverflow.Ellipsis
        })
        .maxLines(CommonConstants.ONE_LINES)
        .margin({
          left: $r('app.float.multi_dialogs_content_left_distance'),
          right: $r('app.float.multi_dialogs_content_right_distance')
        })
        .layoutWeight(CommonConstants.WEIGHT_ONE)
      Image($r('app.media.multi_dialogs_ic_arrow'))
        .width($r('app.float.multi_dialogs_arrow_image_width'))
        .height($r('app.float.multi_dialogs_arrow_image_height'))
        .margin({
          right: $r('app.float.multi_dialogs_arrow_right_distance')
        })
    }
    .width(CommonConstants.COMMON_DIALOG_WIDTH)
    .height($r('app.float.multi_dialogs_input_row_height'))
    .margin({
      top: $r('app.float.multi_dialogs_row_top_distance')
    })
    .borderRadius($r('app.float.multi_dialogs_row_radius'))
    .backgroundColor(Color.White)
    .onClick(this.onItemClick)
  }
}