import wantAgent, { WantAgent } from '@ohos.app.ability.wantAgent';
import notification from '@ohos.notificationManager';
import CommonConstants from '../constants/CommonConstants';

export function createWantAgent(bundleName: string, abilityName: string): Promise<WantAgent> {
  let wantAgentInfo = {
    wants: [
      {
        bundleName: bundleName,
        abilityName: abilityName
      }
    ],
    operationType: wantAgent.OperationType.START_ABILITY,
    requestCode: 0,
    wantAgentFlags:[
      wantAgent.WantAgentFlags.CONSTANT_FLAG
    ]
  } as wantAgent.WantAgentInfo;
  return wantAgent.getWantAgent(wantAgentInfo);
}

export function publishNotification(
  progress: number,
  title: string,
  wantAgentObj: WantAgent
) {
  let template: notification.NotificationTemplate = {
    name: "downloadTemplate",
    data: {
      progressValue: progress,
      progressMaxValue: CommonConstants.PROGRESS_TOTAL,
      isProgressIndeterminate: false
    }
  };
  let notificationRequest: notification.NotificationRequest = {
    id: CommonConstants.NOTIFICATION_ID,
    slotType: notification.SlotType.CONTENT_INFORMATION,
    template: template,
    content: {
      contentType: notification.ContentType.NOTIFICATION_CONTENT_BASIC_TEXT,
      normal: {
        title: `${title}:${CommonConstants.DOWNLOAD_FILE}`,
        text: "",
        additionalText: `${progress}%`
      }
    },
    wantAgent: wantAgentObj
  };
  notification.publish(notificationRequest)
    .catch((error) => console.log(`[ANS] publish failed,message is ${error}`))
}

export function openNotificationPermission() {
  notification.requestEnableNotification()
    .then(() => console.log('Enable notification success'))
    .catch((error) => console.log('Enable notification failed because ' + JSON.stringify(error)))
}