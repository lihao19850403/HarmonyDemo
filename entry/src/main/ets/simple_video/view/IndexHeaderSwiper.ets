import { MARGIN_FONT_SIZE, NET, SECOND_PAGE, STRING_PERCENT } from '../common/constants/CommonConstants'
import { ParamItem } from '../model/ParamItem';
import { SwiperVideoItem } from '../model/SwiperVideoItem';
import { SWIPER_VIDEOS } from "../viewmodel/VideoData";

/* 首页顶部banner。 */
@Component
export struct IndexHeaderSwiper {
  build() {
    Row() {
      Swiper() {
        ForEach(SWIPER_VIDEOS,
          (item: SwiperVideoItem, index?: number) => {
            Navigator({
              target: SECOND_PAGE,
              type: NavigationType.Push
            }) {
              Image(item.image)
                .borderRadius(MARGIN_FONT_SIZE.FIRST_MARGIN)
            }
            .params(this.navigatorParams(NET as unknown as Resource))
          },
          (item: SwiperVideoItem, index?: number) => {
            return JSON.stringify(item) + index;
          });
      }
      .autoPlay(true)
    }
    .width(STRING_PERCENT.INDEX_COMPONENT_WITH_PERCENT)
    .height(STRING_PERCENT.INDEX_SWIPER_HEIGHT_PERCENT)
    .backgroundColor($r("app.color.white"))
    .margin({
      left: STRING_PERCENT.INDEX_SWIPER_LEFT_RIGHT_MARGIN,
      right: STRING_PERCENT.INDEX_SWIPER_LEFT_RIGHT_MARGIN,
      top: MARGIN_FONT_SIZE.FOURTH_MARGIN
    })
  }

  navigatorParams(source: Resource): ParamItem {
    let paramItem: ParamItem = new ParamItem();
    paramItem.source = source;
    return paramItem;
  }
}