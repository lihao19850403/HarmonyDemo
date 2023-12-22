import { CommonConstants } from '../common/constants/CommonConstant';

@Extend(Button)
function dialogButtonStyle() {
  .fontSize($r('app.float.target_button_font'))
  .height($r('app.float.target_dialog_btn_height'))
  .width($r('app.float.target_dialog_btn_width'))
  .backgroundColor(Color.White)
  .fontColor($r('app.color.target_main_blue'))
}

@CustomDialog
export struct AddTargetDialog {
  private controller?: CustomDialogController;
  onClickOK?: (value: string) => void;

  @State subTaskName: string = "";

  build() {
    Column() {
      // 提示。
      Text($r('app.string.target_add_task_dialog'))
        .width(CommonConstants.FULL_WIDTH)
        .fontSize($r('app.float.target_secondary_title'))
        .fontWeight(CommonConstants.FONT_WEIGHT)
        .fontColor($r('app.color.target_title_black_color'))
        .textAlign(TextAlign.Start)
      // 输入任务名称。
      TextInput({
        placeholder: $r('app.string.target_input_target_name')
      })
        .placeholderColor(Color.Grey)
        .placeholderFont({
          size: $r('app.float.target_list_font')
        })
        .caretColor(Color.Blue)
        .backgroundColor($r('app.color.target_input_background'))
        .width(CommonConstants.FULL_WIDTH)
        .height(CommonConstants.DIALOG_INPUT_HEIGHT)
        .margin({ top: CommonConstants.DIALOG_INPUT_MARGIN })
        .fontSize($r('app.float.target_list_font'))
        .fontColor($r('app.color.target_title_black_color'))
        .onChange((value: string) => {
          this.subTaskName = value;
        })
      Blank()
      Row() {
        Button($r("app.string.target_cancel_button"))
          .dialogButtonStyle()
          .onClick(() => {
            this.controller?.close();
          })
        Divider()
          .vertical(true)
        Button($r("app.string.target_confirm_button"))
          .dialogButtonStyle()
          .onClick(() => {
            if (this.onClickOK) {
              this.onClickOK(this.subTaskName);
            }
          })
      }
      .width(CommonConstants.DIALOG_OPERATION_WIDTH)
      .height(CommonConstants.DIALOG_OPERATION_HEIGHT)
      .justifyContent(FlexAlign.SpaceBetween)
    }
    .padding($r("app.float.target_dialog_padding"))
    .width(CommonConstants.DIALOG_WIDTH)
    .height($r("app.float.target_dialog_height"))
    .borderRadius(CommonConstants.DIALOG_BORDER_RADIUS)
    .backgroundColor(Color.White)
  }
}