import prompt from '@ohos.promptAction';
import router from '@ohos.router';
import CommonConstants from '../common/constants/CommonConstants';

/* 此处对TextInput组件进行了扩展，在扩展中可以列出能够复用的属性。 */
@Extend(TextInput)
function inputStyle() {
  .placeholderColor($r('app.color.shop_mall_placeholder_color'))
  .height($r('app.float.shop_mall_login_input_height'))
  .fontSize($r('app.float.shop_mall_big_text_size'))
  .backgroundColor($r('app.color.page_background'))
  .width(CommonConstants.FULL_PARENT)
  .padding({
    left: CommonConstants.INPUT_PADDING_LEFT
  })
  .margin({
    top: $r('app.float.shop_mall_input_margin_top')
  })
}

@Entry
@Component
struct LoginPage {

  /* 模拟登录超时操作。 */
  private timeOutID: number = -1;

  @State account: string = "";
  @State password: string = "";
  @State isShowProgress: boolean = false;

  aboutToDisappear() {
    clearTimeout(this.timeOutID);
    this.timeOutID = -1;
  }

  build() {
    Column() {
      // 顶部logo。
      Image($r('app.media.shop_mall_logo'))
        .width($r("app.float.shop_mall_logo_image_size"))
        .height($r("app.float.shop_mall_logo_image_size"))
        .margin({
          top: $r("app.float.shop_mall_logo_margin_top"),
          bottom: $r("app.float.shop_mall_logo_margin_bottom")
        })
      // 标题。
      Text($r('app.string.shop_mall_login_page'))
        .fontSize($r('app.float.shop_mall_page_title_text_size'))
        .fontWeight(FontWeight.Medium)
        .fontColor($r('app.color.shop_mall_title_text_color'))
      // 副标题。
      Text($r('app.string.shop_mall_login_more'))
        .fontSize($r('app.float.shop_mall_normal_text_size'))
        .fontColor($r('app.color.shop_mall_login_more_text_color'))
        .margin({
          top: $r('app.float.shop_mall_login_more_margin_top'),
          bottom: $r('app.float.shop_mall_login_more_margin_bottom')
        })
      // 输入账号。
      TextInput({
        placeholder: $r('app.string.shop_mall_account')
      })
        .maxLength(CommonConstants.INPUT_ACCOUNT_LENGTH)
        .type(InputType.Normal)
        .inputStyle()
        .onChange((value: string) => {
          this.account = value;
        })
      this.SeparateLine()
      // 输入密码。
      TextInput({
        placeholder: $r('app.string.shop_mall_password')
      })
        .maxLength(CommonConstants.INPUT_PASSWORD_LENGTH)
        .type(InputType.Password)
        .inputStyle()
        .onChange((value: string) => {
          this.password = value;
        })
      this.SeparateLine()
      // 其他登录方式提示。
      Row() {
        this.TipText($r('app.string.shop_mall_message_login'))
        this.TipText($r('app.string.shop_mall_forgot_password'))
      }
      .justifyContent(FlexAlign.SpaceBetween)
      .width(CommonConstants.FULL_PARENT)
      .margin({
        top: $r('app.float.shop_mall_forgot_margin_top')
      })
      // 登录按钮。
      Button($r("app.string.shop_mall_login"), {
        type:ButtonType.Capsule
      })
        .width(CommonConstants.BUTTON_WIDTH)
        .height($r('app.float.shop_mall_login_button_height'))
        .fontSize($r('app.float.shop_mall_normal_text_size'))
        .fontWeight(FontWeight.Medium)
        .backgroundColor($r('app.color.shop_mall_login_button_color'))
        .margin({
          top: $r('app.float.shop_mall_login_button_margin_top'),
          bottom: $r('app.float.shop_mall_login_button_margin_bottom')
        })
        .onClick(() => {
          this.login();
        })
      // 注册新用户的提示。
      Text($r('app.string.shop_mall_register_account'))
        .fontSize($r('app.float.shop_mall_normal_text_size'))
        .fontColor($r('app.color.shop_mall_login_blue_text_color'))
        .fontWeight(FontWeight.Medium)
      // loading。
      if (this.isShowProgress) {
        LoadingProgress()
          .width($r('app.float.shop_mall_login_progress_size'))
          .height($r('app.float.shop_mall_login_progress_size'))
          .color($r('app.color.shop_mall_loading_color'))
          .margin({ top: $r('app.float.shop_mall_login_progress_margin_top') })
      }
      // 填充空白区域。
      Blank()
      // 再次提示其他登录方式。
      Text($r('app.string.shop_mall_other_login_method'))
        .fontSize($r('app.float.shop_mall_little_text_size'))
        .fontColor($r('app.color.shop_mall_other_login_text_color'))
        .fontWeight(FontWeight.Medium)
        .margin({
          top: $r('app.float.shop_mall_other_login_margin_top'),
          bottom: $r('app.float.shop_mall_other_login_margin_bottom')
        })
      // 底部圆形按钮。
      Row({
        space: CommonConstants.LOGIN_METHODS_SPACE
      }) {
        ForEach([
        $r('app.media.shop_mall_login_method1'),
        $r('app.media.shop_mall_login_method2'),
        $r('app.media.shop_mall_login_method3')
        ],
          (src: Resource, index?: number) => {
            this.ImageButton(src)
          },
          (src: Resource, index?: number) => {
            return JSON.stringify(src);
          })
      }
    }
    .backgroundColor($r("app.color.page_background"))
    .width(CommonConstants.FULL_PARENT)
    .height(CommonConstants.FULL_PARENT)
    .padding({
      left: $r('app.float.shop_mall_page_padding_hor'),
      right: $r('app.float.shop_mall_page_padding_hor'),
      bottom: $r('app.float.shop_mall_login_page_padding_bottom')
    })
  }

  /* 分割线。 */
  @Builder SeparateLine() {
    Line()
      .width(CommonConstants.FULL_PARENT)
      .height($r('app.float.shop_mall_line_height'))
      .backgroundColor($r('app.color.shop_mall_line_color'))
  }

  /* 其他登录选项提示。 */
  @Builder TipText(text: Resource) {
    Text(text)
      .fontColor($r('app.color.shop_mall_login_blue_text_color'))
      .fontSize($r('app.float.shop_mall_small_text_size'))
      .fontWeight(FontWeight.Medium)
  }

  /* 在页面下方构造的圆形按钮。 */
  @Builder ImageButton(src: Resource) {
    Button({
      type: ButtonType.Circle,
      stateEffect: true
    }) {
      Image(src)
    }
    .width($r("app.float.shop_mall_other_login_image_size"))
    .height($r("app.float.shop_mall_other_login_image_size"))
    .backgroundColor($r("app.color.page_background"))
    .onClick(() => {
      console.log("点击了圆形按钮：" + JSON.stringify(src));
    })
  }

  /* 登录。 */
  login(): void {
    if (this.account === "" || this.password === "") {
      prompt.showToast({
        message: $r("app.string.shop_mall_input_empty_tips")
      })
      return;
    }
    // 限定登录时间。
    this.isShowProgress = true;
    if (this.timeOutID === -1) {
      this.timeOutID = setTimeout(() => {
        this.isShowProgress = false;
        this.timeOutID = -1;
        router.replaceUrl({
          url: "shop_mall/pages/MainPage"
        });
      },
        CommonConstants.LOGIN_DELAY_TIME);
    }
  }
}