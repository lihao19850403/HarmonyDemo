import { CommonConstants } from '../common/constants/CommonConstant';

@Component
export struct CustomButton {
  buttonText?: Resource;

  @State buttonColor: Resource = $r("app.color.start_window_background");

  build() {
    Text(this.buttonText)
      .width($r("app.float.target_dialog_btn_width"))
      .height($r("app.float.target_dialog_btn_height"))
      .fontSize($r("app.float.target_button_font"))
      .fontColor($r("app.color.target_main_blue"))
      .borderRadius(CommonConstants.LIST_RADIUS)
      .textAlign(TextAlign.Center)
      .backgroundColor(this.buttonColor)
      .onTouch((event?: TouchEvent) => {
        switch (event.type) {
          case TouchType.Down:
            this.buttonColor = $r("app.color.target_custom_button_color");
            break;
          case TouchType.Up:
            this.buttonColor = $r("app.color.start_window_background");
            break;
          default:
            break;
        }
      })
  }
}