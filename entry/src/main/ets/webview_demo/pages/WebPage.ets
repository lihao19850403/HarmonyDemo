import webview from '@ohos.web.webview'
import router from '@ohos.router';
import { CommonConstant } from '../common/Constant';
import prompt from '@ohos.promptAction';

@Entry
@Component
struct WebPage {
  webController: webview.WebviewController = new webview.WebviewController();
  @State params: object = router.getParams();
  @State progressVal: number = 0;
  @State isLoading: boolean = true;
  @State intervalLoading: number = -1;

  aboutToAppear() {
    this.intervalLoading = setInterval(() => {
      if (this.progressVal >= CommonConstant.WebConstant_PROGRESS_MAX) {
        this.progressVal = CommonConstant.WebConstant_PROGRESS_MIN;
      } else {
        this.progressVal = this.progressVal + CommonConstant.WebConstant_PROGRESS_STEP;
      }
    }, CommonConstant.WebConstant_MILLI_SECONDS);
  }

  build() {
    Stack({
      alignContent: Alignment.TopStart
    }) {
      // 实际上这个图充当背景，是靠上的。
      Image($r("app.media.webview_background"))
        .width(CommonConstant.WebConstant_FULL_HEIGHT)
        .height(CommonConstant.MainConstant_IMAGE_HEIGHT)
      // 盖在了背景图上。
      Column() {
        // 标题部分。
        Row() {
          Image($rawfile("webview_demo/img/ic_public_back.png"))
            .width(CommonConstant.WebConstant_IMAGE_WIDTH)
            .height(CommonConstant.WebConstant_IMAGE_HEIGHT)
            .margin({
              left: CommonConstant.WebConstant_IMAGE_MARGIN_LEFT
            })
            .onClick(() => router.back())
          Text($r("app.string.webview_prompts"))
            .width(CommonConstant.WebConstant_TOP_TEXT_WIDTH)
            .height(CommonConstant.WebConstant_TOP_TEXT_HEIGHT)
            .fontSize(CommonConstant.WebConstant_TOP_TEXT_FONT_SIZE)
            .fontColor($r("app.color.black"))
            .margin({
              left: CommonConstant.WebConstant_TOP_TEXT_MARGIN_LEFT
            })
        }
        .height(CommonConstant.WebConstant_TOP_ROW_HEIGHT)
        // WebView组件。
        Web({
          src: this.params["path"],
          controller: this.webController
        })
          .zoomAccess(false)
          .width(CommonConstant.WebConstant_WIDTH)
          .aspectRatio(1)
          .margin({
            left: CommonConstant.WebConstant_MARGIN_LEFT,
            right: CommonConstant.WebConstant_MARGIN_RIGHT,
            top: CommonConstant.WebConstant_MARGIN_TOP
          })
          .onConfirm((event) => {
            // 当接收到网页confirm请求的时候执行此回调。
            AlertDialog.show({
              message: CommonConstant.WEB_ALERT_DIALOG_TEXT_VALUE + event?.message,
              confirm: {
                value: $r("app.string.webview_web_alert_dialog_button_value"),
                action: () => event?.result.handleConfirm()
              },
              cancel: () => event?.result.handleCancel()
            });
            return true;
          })
          .onErrorReceive((event) => {
            // 当加载出错时触发此回调。
            let errorInfo = event?.error.getErrorInfo();
            if (!errorInfo) {
              return;
            }
            if (errorInfo === "ERR_INTERNET_DISCONNECTED") {
              prompt.showToast({
                message: $r("app.string.webview_internet_err"),
                duration: CommonConstant.WebConstant_DURATION
              })
            }
            if (errorInfo === "ERR_CONNECTION_TIMED_OUT") {
              prompt.showToast({
                message: $r("app.string.webview_internet_err"),
                duration: CommonConstant.WebConstant_DURATION
              })
            }
          })
          .onProgressChange((event) => {
            // 当进度改变时候的回调。
            if (event?.newProgress === CommonConstant.WebConstant_PROGRESS_MAX) {
              this.isLoading = false;
              clearInterval(this.intervalLoading);
              this.intervalLoading = -1;
            }
          })
        // 文字说明。
        Text($r('app.string.webview_textValue'))
          .height(CommonConstant.WebConstant_TEXT_VALUE_HEIGHT)
          .fontSize(CommonConstant.WebConstant_TEXT_VALUE_FONT_SIZE)
          .fontColor($r('app.color.webview_text_value_font_color'))
          .fontWeight(CommonConstant.WebConstant_TEXT_VALUE_FONT_WEIGHT)
          .textAlign(TextAlign.Center)
          .margin({
            top: CommonConstant.WebConstant_TEXT_VALUE_MARGIN_TOP
          })
        Text(this.params['tips'])
          .width(CommonConstant.WebConstant_TIP_TEXT_VALUE_WIDTH)
          .height(CommonConstant.WebConstant_TIP_TEXT_VALUE_HEIGHT)
          .fontSize(CommonConstant.WebConstant_TIP_TEXT_VALUE_FONT_SIZE)
          .fontColor($r('app.color.webview_text_value_font_color'))
          .textAlign(TextAlign.Center)
          .opacity(CommonConstant.WebConstant_TIP_TEXT_VALUE_OPACITY)
          .margin({
            top: CommonConstant.WebConstant_TIP_TEXT_VALUE_MARGIN_TOP
          })
        // 蓝色按钮。
        Button($r("app.string.webview_btnValue"))
          .width(CommonConstant.WebConstant_BUTTON_WIDTH)
          .height(CommonConstant.WebConstant_BUTTON_HEIGHT)
          .fontSize(CommonConstant.WebConstant_BUTTON_FONT_SIZE)
          .fontColor($r('app.color.start_window_background'))
          .margin({
            top: CommonConstant.WebConstant_BUTTON_MARGIN_TOP
          })
          .backgroundColor($r('app.color.blue'))
          .borderRadius(CommonConstant.WebConstant_BUTTON_BORDER_RADIUS)
          .onClick((event: ClickEvent) => this.webController.runJavaScript("startDraw()"))
      }
      .width(CommonConstant.WebConstant_FULL_WIDTH)
      .height(CommonConstant.WebConstant_FULL_HEIGHT)
      // 加载提示。
      if (this.isLoading) {
        Progress({
          type: ProgressType.ScaleRing,
          value: CommonConstant.WebConstant_PROGRESS_MIN,
          total: CommonConstant.WebConstant_PROGRESS_MAX
        })
          .width(CommonConstant.WebConstant_PROGRESS_WIDTH)
          .color(Color.Grey)
          .value(this.progressVal)
          .style({
            strokeWidth: CommonConstant.WebConstant_PROGRESS_STROKE_WIDTH,
            scaleCount: CommonConstant.WebConstant_PROGRESS_SCALE_COUNT,
            scaleWidth: CommonConstant.WebConstant_PROGRESS_SCALE_WIDTH
          })
          .zIndex(1)
          .position({
            x: CommonConstant.WebConstant_PROGRESS_POSITION_X,
            y: CommonConstant.WebConstant_PROGRESS_POSITION_Y
          })
      }
    }
    .backgroundColor($r("app.color.navy_blue"))
  }
}