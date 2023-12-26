import common from '@ohos.app.ability.common';
import { WantAgent } from '@ohos.app.ability.wantAgent';
import notification from '@ohos.notificationManager';
import promptAction from '@ohos.promptAction';
import CommonConstants, { DOWNLOAD_STATUS } from '../common/constants/CommonConstants';
import { createWantAgent, openNotificationPermission, publishNotification } from '../common/utils/NotificationUtils';
import { getStringByRes } from '../common/utils/ResourceUtils';
import { OtherTest } from '../view/OtherTest';

@Extend(Button)
function buttonStyle() {
  .height($r('app.float.notifications_button_height'))
  .fontSize($r('app.float.notifications_button_font_size'))
  .constraintSize({
    minWidth: $r('app.float.notifications_button_width')
  })
  .borderRadius($r('app.float.notifications_button_border_radius'))
}

@Entry
@Component
struct MainPage {
  private context = getContext(this) as common.UIAbilityContext;
  private isSupport: boolean = true;
  private notificationTitle: string = "";
  private wantAgentObj: WantAgent = new Object();
  private interval: number = -1;

  @State downloadStatus: number = DOWNLOAD_STATUS.INITIAL;
  @State downloadProgress: number = 0;

  aboutToAppear() {
    openNotificationPermission();
    let bundleName = this.context.abilityInfo.bundleName;
    let abilityName = this.context.abilityInfo.name;
    createWantAgent(bundleName, abilityName)
      .then((want: WantAgent) => this.wantAgentObj = want)
      .catch((error) => console.log(`getWantAgent fail, err: ${JSON.stringify(error)}`))
    notification.isSupportTemplate("downloadTemplate")
      .then((isSupport: boolean) => {
        if (!isSupport) {
          promptAction.showToast({
            message: $r("app.string.notifications_invalid_button_toast"),
          });
        }
        this.isSupport = isSupport;
      })
  }

  onBackPress() {
    this.cancel();
  }

  build() {
    Scroll() {
      Column() {
        Text($r('app.string.notifications_title'))
          .width(CommonConstants.TITLE_WIDTH)
          .fontSize($r('app.float.notifications_title_font_size'))
          .fontWeight(CommonConstants.FONT_WEIGHT_LAGER)
          .textAlign(TextAlign.Start)
          .margin({
            top: $r('app.float.notifications_title_margin_top'),
            bottom: $r('app.float.notifications_title_margin_top')
          })
        Row() {
          Column() {
            Image($r('app.media.notifications_ic_image'))
              .width($r('app.float.notifications_card_image_length'))
              .height($r('app.float.notifications_card_image_length'))
              .objectFit(ImageFit.Fill)
          }
          .height(CommonConstants.FULL_LENGTH)
          .layoutWeight(CommonConstants.IMAGE_WEIGHT)
          .alignItems(HorizontalAlign.Start)
          Column() {
            Row() {
              Text(CommonConstants.DOWNLOAD_FILE)
                .fontSize($r('app.float.notifications_name_font_size'))
                .fontWeight(CommonConstants.FONT_WEIGHT_LAGER)
                .textAlign(TextAlign.Center)
                .lineHeight($r('app.float.notifications_name_font_height'))
              Text(`${this.downloadProgress}%`)
                .fontSize($r('app.float.notifications_normal_font_size'))
                .lineHeight($r('app.float.notifications_name_font_height'))
                .opacity(CommonConstants.FONT_OPACITY)
            }
            .width(CommonConstants.FULL_LENGTH)
            .justifyContent(FlexAlign.SpaceBetween)
            Progress({
              value: this.downloadProgress,
              total: CommonConstants.PROGRESS_TOTAL
            })
              .width(CommonConstants.FULL_LENGTH)
            Row() {
              Text(CommonConstants.FILE_SIZE)
                .fontSize($r("app.float.notifications_normal_font_size"))
                .lineHeight($r("app.float.notifications_name_font_height"))
                .opacity(CommonConstants.FONT_OPACITY)
              if (this.downloadStatus === DOWNLOAD_STATUS.INITIAL) {
                this.CustomButton($r("app.string.notifications_button_download"), () => this.start())
              } else if (this.downloadStatus === DOWNLOAD_STATUS.DOWNLOADING) {
                Row() {
                  this.CancelButton()
                  this.CustomButton($r("app.string.notifications_button_pause"), () => this.pause())
                }
              } else if (this.downloadStatus === DOWNLOAD_STATUS.PAUSE) {
                Row() {
                  this.CancelButton()
                  this.CustomButton($r("app.string.notifications_button_resume"), () => this.resume())
                }
              } else {
                this.CustomButton($r("app.string.notifications_button_finish"), () => this.open())
              }
            }
            .width(CommonConstants.FULL_LENGTH)
            .justifyContent(FlexAlign.SpaceBetween)
          }
          .height(CommonConstants.FULL_LENGTH)
          .layoutWeight(CommonConstants.CARD_CONTENT_WEIGHT)
          .justifyContent(FlexAlign.SpaceBetween)
        }
        .width(CommonConstants.CARD_WIDTH)
        .height($r("app.float.notifications_card_height"))
        .backgroundColor(Color.White)
        .borderRadius($r("app.float.notifications_card_border_radius"))
        .padding($r("app.float.notifications_card_padding"))
        .justifyContent(FlexAlign.SpaceBetween)
        /* 其他通知发送示例。 */
        OtherTest()
      }
    }
    .width(CommonConstants.FULL_LENGTH)
    .height(CommonConstants.FULL_LENGTH)
    .backgroundColor($r('app.color.notifications_index_background_color'))
    .align(Alignment.Top)
  }

  @Builder CustomButton(text: Resource, click: () => void) {
    Button(text)
      .backgroundColor($r("app.color.notifications_button_color"))
      .buttonStyle()
      .onClick((event: ClickEvent) => click())
  }

  @Builder CancelButton() {
    Button($r("app.string.notifications_button_cancel"))
      .backgroundColor($r("app.color.notifications_cancel_button_color"))
      .buttonStyle()
      .fontColor($r("app.color.notifications_button_color"))
      .margin({
        right: $r("app.float.notifications_button_margin")
      })
      .onClick(() => this.cancel())
  }

  download() {
    this.interval = setInterval(async () => {
      if (this.downloadProgress === CommonConstants.PROGRESS_TOTAL) {
        this.notificationTitle = await getStringByRes(this.context, $r("app.string.notifications_notification_title_finish"));
        this.downloadStatus = DOWNLOAD_STATUS.FINISHED;
        clearInterval(this.interval);
      } else {
        this.downloadProgress += CommonConstants.PROGRESS_SPEED;
      }
      if (this.isSupport) {
        publishNotification(this.downloadProgress, this.notificationTitle, this.wantAgentObj);
      }
    }, CommonConstants.UPDATE_FREQUENCY);
  }

  async start() {
    this.notificationTitle = await getStringByRes(this.context, $r("app.string.notifications_notification_title_download"));
    this.downloadStatus = DOWNLOAD_STATUS.DOWNLOADING;
    this.downloadProgress = 0;
    this.download();
  }

  async pause() {
    this.notificationTitle = await getStringByRes(this.context, $r("app.string.notifications_notification_title_pause"));
    clearInterval(this.interval);
    this.downloadStatus = DOWNLOAD_STATUS.PAUSE;
    if (this.isSupport) {
      publishNotification(this.downloadProgress, this.notificationTitle, this.wantAgentObj);
    }
  }

  async resume() {
    this.notificationTitle = await getStringByRes(this.context, $r("app.string.notifications_notification_title_download"));
    this.download();
    this.downloadStatus = DOWNLOAD_STATUS.DOWNLOADING;
  }

  async cancel() {
    clearInterval(this.interval);
    this.downloadProgress = 0;
    this.downloadStatus = DOWNLOAD_STATUS.INITIAL;
    notification.cancel(CommonConstants.NOTIFICATION_ID);
  }

  open() {
    promptAction.showToast({
      message: $r("app.string.notifications_invalid_button_toast")
    });
  }
}