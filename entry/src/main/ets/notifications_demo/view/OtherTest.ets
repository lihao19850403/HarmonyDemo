import CommonConstants from '../common/constants/CommonConstants'
import notification from '@ohos.notificationManager';
import common from '@ohos.app.ability.common';
import image from '@ohos.multimedia.image';
import promptAction from '@ohos.promptAction';
import { WantAgent } from '@ohos.app.ability.wantAgent';
import { createWantAgent } from '../common/utils/NotificationUtils';

@Component
export struct OtherTest {
  private context = getContext(this) as common.UIAbilityContext;

  build() {
    Column() {
      // 普通文字通知。
      this.OtherTestButton("普通文字通知", this.normalText)
      // 图片类型通知。
      this.OtherTestButton("图片类型通知", async () => {
        await this.sendPicture();
      })
      // 额外的回复按钮。
      this.OtherTestButton("额外的回复按钮", async () => {
        await this.extraReply();
      })
      // 通知组。
      this.OtherTestButton("通知组（每点击一次发送一条组信息）", this.sendGroupNotification)
    }
  }

  @Builder OtherTestButton(tip: string, onClick: () => void) {
    Row() {
      Text(tip)
        .fontSize("17vp")
        .fontWeight(400)
    }
    .width(CommonConstants.CARD_WIDTH)
    .height("64vp")
    .backgroundColor(Color.White)
    .borderRadius($r("app.float.notifications_card_border_radius"))
    .justifyContent(FlexAlign.Center)
    .margin({
      top: 16
    })
    .onClick((event: ClickEvent) => onClick())
  }

  normalText() {
    // 通知Request对象
    let notificationRequest = {
      id: CommonConstants.NOTIFICATION_ID + 100,
      slotType: notification.SlotType.SOCIAL_COMMUNICATION,
      content: {
        contentType: notification.ContentType.NOTIFICATION_CONTENT_BASIC_TEXT,
        normal: {
          title: "普通文字通知",
          text: "这是普通文字通知的内容",
          additionalText: "普通文字通知附加信息"
        }
      }
    };
    notification.publish(notificationRequest)
      .then(() => console.log("publish success"));
  }

  async sendPicture() {
    let resourceManager = this.context.resourceManager;
    let imageArray = await resourceManager.getMediaContent($r("app.media.notifications_meizu_sample").id);
    let imageResource = image.createImageSource(imageArray.buffer);
    let pixelMap = await imageResource.createPixelMap({ // 注：图片不能太大，否则会发送失败。可以通过限制图片尺寸来缩减大小。
      desiredSize: {
        width: 467.5,
        height: 690
      }
    });
    let request: notification.NotificationRequest = {
      id: CommonConstants.NOTIFICATION_ID + 200,
      slotType: notification.SlotType.SOCIAL_COMMUNICATION,
      content: {
        contentType: notification.ContentType.NOTIFICATION_CONTENT_PICTURE,
        picture: {
          title: "好物热销中",
          text: "展开查看详情",
          expandedTitle: "今日热门推荐",
          briefText: "这里一定有您喜欢的",
          picture: pixelMap
        }
      }
    };
    notification.publish(request)
      .then(() => console.log("publish success"))
      .catch((error) => {
        promptAction.showToast({
          message: "发送通知失败：" + error.message
        });
      })
  }

  async extraReply() {
    // 创建一个意图。
    let bundleName = this.context.abilityInfo.bundleName;
    let abilityName = this.context.abilityInfo.name;
    let wantAgent: WantAgent = await createWantAgent(bundleName, abilityName);
    // 填写通知信息。
    let notificationRequest = {
      id: CommonConstants.NOTIFICATION_ID + 300,
      slotType: notification.SlotType.SOCIAL_COMMUNICATION,
      content: {
        contentType: notification.ContentType.NOTIFICATION_CONTENT_BASIC_TEXT,
        normal: {
          title: "张三",
          text: "吃饭了吗？",
        }
      },
      actionButtons: [
        {
          title: "回复",
          wantAgent: wantAgent
        }
      ]
    };
    notification.publish(notificationRequest)
      .then(() => console.log("publish success"));
  }

  sendGroupNotification() {
    let groupItemIndex = new Date().getTime();
    let notificationRequest = {
      id: CommonConstants.NOTIFICATION_ID + 400 + groupItemIndex,
      slotType: notification.SlotType.SOCIAL_COMMUNICATION,
      groupName: "ProductGroup",
      content: {
        contentType: notification.ContentType.NOTIFICATION_CONTENT_BASIC_TEXT,
        normal: {
          title: "组信息",
          text: "组内新信息：" + groupItemIndex,
        }
      }
    };
    notification.publish(notificationRequest)
      .then(() => console.log("publish success"));
  }
}