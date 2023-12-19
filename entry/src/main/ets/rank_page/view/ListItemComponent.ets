
import { FontSize, FontWeight, ItemStyle, WEIGHT } from '../common/constants/Constants';

@Component
export struct ListItemComponent {
  name?: Resource;
  index?: number;
  vote?: string;

  @State isChange: boolean = false;
  @Prop isSwitchDataSource: boolean;

  build() {
    // 列表条目。
    Row() {
      // 商品序号。
      this.IndexComponent(this.index);
      // 商品名称。
      Text(this.name)
        .width(ItemStyle.LAYOUT_WEIGHT_CENTER)
        .fontWeight(FontWeight.BOLDER)
        .fontSize(FontSize.MIDDLE)
        .fontColor(this.isChange ? ItemStyle.COLOR_BLUE : ItemStyle.COLOR_BLACK)
      // 商品受欢迎程度。
      Text(this.vote)
        .width(ItemStyle.LAYOUT_WEIGHT_RIGHT)
        .fontWeight(FontWeight.BOLD)
        .fontSize(FontSize.SMALL)
        .fontColor(this.isChange ? ItemStyle.COLOR_BLUE : ItemStyle.COLOR_BLACK)
    }
    .height(ItemStyle.BAR_HEIGHT)
    .width(WEIGHT)
    .onClick(() => {
      // this.isSwitchDataSource = !this.isSwitchDataSource;
      this.isChange = !this.isChange;
    })
  }

  /* 生成圆形序号组件。 */
  @Builder CircleText(index: number) {
    Row() {
      Text(index?.toString())
        .fontWeight(FontWeight.BOLD)
        .fontSize(FontSize.SMALL)
        .fontColor(Color.White) // 白色文字。
    }
    .justifyContent(FlexAlign.Center)
    .borderRadius(ItemStyle.CIRCLE_TEXT_BORDER_RADIUS)
    .size({
      width: ItemStyle.CIRCLE_TEXT_SIZE,
      height: ItemStyle.CIRCLE_TEXT_SIZE
    })
    // 蓝色背景。
    .backgroundColor($r("app.color.rank_page_circle_text_background"))
  }

  /* 生成普通序号组件。 */
  @Builder NormalText(index: number) {
    Text(index?.toString())
      .lineHeight(ItemStyle.TEXT_LAYOUT_SIZE)
      .textAlign(TextAlign.Center)
      .width(ItemStyle.TEXT_LAYOUT_SIZE)
      .fontWeight(FontWeight.BOLD)
      .fontSize(FontSize.SMALL)
  }

  /* 序号组件。 */
  @Builder IndexComponent(index: number) {
    Column() {
      if (this.isRenderCircleText(index)) {
        if (index !== undefined) {
          this.CircleText(index)
        }
      } else {
        this.NormalText(index)
      }
    }
    .width(ItemStyle.LAYOUT_WEIGHT_LEFT)
    .alignItems(HorizontalAlign.Start)
  }

  /* 只将前3个商品序号标记为蓝色圆形。 */
  isRenderCircleText(index: number): boolean {
    return index === 1 || index === 2 || index === 3;
  }
}