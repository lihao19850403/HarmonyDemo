import { FontSize, ListHeaderStyle } from '../common/constants/Constants'

@Component
export struct ListHeaderComponent {
  widthValue: Length = 0;
  paddingValue: Padding | Length = 0;

  build() {
    Row() {
      Text($r("app.string.rank_page_number"))
        .fontSize(FontSize.SMALL)
        .width(ListHeaderStyle.LAYOUT_WEIGHT_LEFT)
        .fontWeight(ListHeaderStyle.FONT_WEIGHT)
        .fontColor($r("app.color.rank_page_font_description"))
      Text($r("app.string.rank_page_type"))
        .fontSize(FontSize.SMALL)
        .width(ListHeaderStyle.LAYOUT_WEIGHT_CENTER)
        .fontWeight(ListHeaderStyle.FONT_WEIGHT)
        .fontColor($r("app.color.rank_page_font_description"))
      Text($r("app.string.rank_page_vote"))
        .fontSize(FontSize.SMALL)
        .width(ListHeaderStyle.LAYOUT_WEIGHT_RIGHT)
        .fontColor($r("app.color.rank_page_font_description"))
    }
    .width(this.widthValue)
    .padding(this.paddingValue)
  }
}