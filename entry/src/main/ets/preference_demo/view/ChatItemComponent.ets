import StyleConstants from '../common/constants/StyleConstants';
import { ChatData } from '../model/ChatData'
import { ItemDirection } from '../model/ItemDirection';
import { ChatContent } from './ChatContent';
@Component
export struct ChatItemComponent {
  item: ChatData = new ChatData();

  @Prop changedFontSize: number;

  build() {
    Row() {
      Image(this.item.itemDirection === ItemDirection.LEFT
        ? $r('app.media.preference_left_head')
        : $r('app.media.preference_right_head'))
        .width(StyleConstants.SET_CHAT_HEAD_SIZE_PERCENT)
        .aspectRatio(StyleConstants.HEAD_ASPECT_RATIO)
        .margin({
          left: this.item.itemDirection === ItemDirection.LEFT
            ? StyleConstants.HEAD_RIGHT_PERCENT
            : StyleConstants.HEAD_LEFT_PERCENT,
          right: this.item.itemDirection === ItemDirection.LEFT
            ? StyleConstants.HEAD_LEFT_PERCENT
            : StyleConstants.HEAD_RIGHT_PERCENT
        })
      ChatContent({
        item: this.item,
        changeFontSize: this.changedFontSize
      })
    }
    .alignItems(VerticalAlign.Top)
    .width(StyleConstants.FULL_WIDTH)
    .direction(this.item.itemDirection === ItemDirection.LEFT ? Direction.Ltr : Direction.Rtl)
    .margin({
      top: StyleConstants.CHAT_TOP_MARGIN_PERCENT
    })
  }
}