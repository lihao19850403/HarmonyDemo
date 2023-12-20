import CommonConstants from '../common/constants/CommonConstant';

@Component
export default struct TodoListItem {
  private content?: string;

  @State isComplete: boolean = false;

  build() {
    Row() {
      // 图标。
      // this.LabelIcon(this.isComplete ? $r("app.media.todo_list_ic_ok") : $r("app.media.todo_list_ic_default"))
      if (this.isComplete) {
        this.LabelIcon($r("app.media.todo_list_ic_ok"))
      } else {
        this.LabelIcon($r("app.media.todo_list_ic_default"))
      }
      // 文字提示。
      Text(this.content)
        .fontSize($r("app.float.todo_list_item_font_size"))
        .fontWeight(CommonConstants.FONT_WEIGHT)
        .opacity(this.isComplete ? CommonConstants.OPACITY_COMPLETED : CommonConstants.OPACITY_DEFAULT)
        .decoration({
          type: this.isComplete ? TextDecorationType.LineThrough : TextDecorationType.None
        })
    }
    .borderRadius(CommonConstants.BORDER_RADIUS)
    .backgroundColor($r("app.color.start_window_background"))
    .width(CommonConstants.LIST_DEFAULT_WIDTH)
    .height($r("app.float.todo_list_list_item_height"))
    .onClick(() => {
      this.isComplete = !this.isComplete
    })
  }

  @Builder LabelIcon(icon: Resource) {
    Image(icon)
      .objectFit(ImageFit.Contain)
      .width($r("app.float.todo_list_checkbox_width"))
      .height($r("app.float.todo_list_checkbox_width"))
      .margin($r("app.float.todo_list_checkbox_margin"))
  }
}