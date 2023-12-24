import CommonConstants from '../common/constants/CommonConstants'
import DimensionUtils from '../common/utils/DimensionUtils';
import CardModel from '../model/CardModel';
import { FileManagerIndex } from '../view/FileManagerIndex';

@Entry
@Component
struct TabIndex {
  @State currentPage: number = CommonConstants.INDEX_DEFAULT_SELECT;

  build() {
    Tabs({
      barPosition: BarPosition.End,
      index: this.currentPage
    }) {
      ForEach(CommonConstants.INDEX_TAB,
        (item: CardModel, index?: number) => {
          TabContent() {
            if (index === CommonConstants.INDEX_DEFAULT_SELECT) {
              FileManagerIndex()
            }
          }
          .tabBar(this.TabBuilder(item, index))
        },
        (item: CardModel, index?: number) => JSON.stringify(item) + index)
    }
    .width(CommonConstants.FULL_LENGTH)
    .height(CommonConstants.FULL_LENGTH)
    .barMode(BarMode.Fixed)
    .onChange((index: number) => this.currentPage = index)
  }

  @Builder TabBuilder(item: CardModel, index: number | undefined) {
    Column() {
      Image(this.currentPage === index ? item.selectedIcon : item.defaultIcon)
        .width(DimensionUtils.getVp($r('app.float.anim_index_tab_icon_size')))
        .height(DimensionUtils.getVp($r('app.float.anim_index_tab_icon_size')))
        .objectFit(ImageFit.Contain)
      Text(item.content)
        .fontColor(this.currentPage === index ? $r('app.color.anim_index_tab_font_color') : Color.Black)
        .fontSize(DimensionUtils.getFp($r('app.float.anim_index_tab_font_size')))
        .margin({
          top: DimensionUtils.getVp($r('app.float.anim_index_tab_vertical_margin'))
        })
        .opacity(this.currentPage === index
          ? $r('app.float.anim_index_tab_font_selected_opacity')
          : $r('app.float.anim_index_tab_font_default_opacity'))
    }
    .width(CommonConstants.FULL_LENGTH)
    .height(CommonConstants.FULL_LENGTH)
    .justifyContent(FlexAlign.Center)
  }
}