import CommonConstants from '../common/constants/CommonConstants';
import { ChatData } from '../model/ChatData'
import { ItemDirection } from '../model/ItemDirection';

export class SettingViewModel {
  chatArr: Array<ChatData> = [];

  initChatData(): Array<ChatData> {
    if (this.chatArr.length === 0) {
      this.chatArr = new Array();
      let chatData = new ChatData();
      chatData.itemDirection = ItemDirection.RIGHT;
      chatData.content = $r('app.string.preference_set_chat_content1');
      this.chatArr.push(chatData);
      chatData = new ChatData();
      chatData.itemDirection = ItemDirection.LEFT;
      chatData.content = $r('app.string.preference_set_chat_content2');
      this.chatArr.push(chatData);
      chatData = new ChatData();
      chatData.itemDirection = ItemDirection.RIGHT;
      chatData.content = $r('app.string.preference_set_chat_content3');
      this.chatArr.push(chatData);
      chatData = new ChatData();
      chatData.itemDirection = ItemDirection.LEFT;
      chatData.content = $r('app.string.preference_set_chat_content4');
      this.chatArr.push(chatData);
    }
    return this.chatArr;
  }

  getTextByFontSize(fontSize: number) {
    let fontSizeText: Resource | string = '';
    switch (fontSize) {
      case CommonConstants.SET_SIZE_SMALL:
        fontSizeText = $r('app.string.preference_set_size_small');
        break;
      case CommonConstants.SET_SIZE_LARGE:
        fontSizeText = $r("app.string.preference_set_size_large");
        break;
      case CommonConstants.SET_SIZE_EXTRA_LARGE:
        fontSizeText = $r("app.string.preference_set_size_extra_large");
        break;
      case CommonConstants.SET_SIZE_HUGE:
        fontSizeText = $r("app.string.preference_set_size_huge");
        break;
      case CommonConstants.SET_SIZE_NORMAL:
      default:
        fontSizeText = $r("app.string.preference_set_size_normal");
    }
    return fontSizeText;
  }
}

export default new SettingViewModel();