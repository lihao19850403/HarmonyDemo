import StyleConstants from '../common/constants/StyleConstants';
import { ChatData } from '../model/ChatData'
import { ItemDirection } from '../model/ItemDirection';

@Component
export struct ChatContent {
  item: ChatData = new ChatData();

  @State isLineFeeded: boolean = true;
  @Prop changeFontSize: number;

  build() {
    Row() {
      Text(this.item.content)
        .fontColor($r("app.color.preference_text"))
        .fontSize(this.changeFontSize + StyleConstants.UNIT_FP)
        .fontWeight(FontWeight.Medium)
        .onAreaChange((oldValue: Area, newValue: Area) => {
          this.isLineFeeded = newValue.height > StyleConstants.DOUBLE_ROW_MIN;
        })
      if (this.isLineFeeded) {
        Blank()
          .layoutWeight(StyleConstants.WEIGHT_FULL)
      }
    }
    .constraintSize({
      maxWidth: StyleConstants.MAX_CHAT_WIDTH_PERCENT
    })
    .direction(Direction.Ltr)
    .padding({
      left: $r('app.float.preference_set_chat_content_vertical_padding'),
      right: $r('app.float.preference_set_chat_content_vertical_padding'),
      top: $r('app.float.preference_set_chat_content_horizontal_padding'),
      bottom: $r('app.float.preference_set_chat_content_horizontal_padding')
    })
    .backgroundColor(this.item.itemDirection === ItemDirection.LEFT
      ? $r("app.color.preference_set_chat_left_bg")
      : $r("app.color.preference_set_chat_right_bg"))
    .borderRadius($r("app.float.preference_set_chat_content_bg_radius"))
  }
}