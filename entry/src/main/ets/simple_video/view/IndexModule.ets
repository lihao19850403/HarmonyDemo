import router from '@ohos.router';
import { MARGIN_FONT_SIZE, NET, SECOND_PAGE, STRING_PERCENT } from '../common/constants/CommonConstants';
import { HorizontalVideoItem } from '../model/HorizontalVideoItem';
import { HORIZONTAL_VIDEOS } from '../viewmodel/VideoData';

/* 首页中部横向列表。 */
@Component
export struct IndexModule {
  private moduleName: string = "";

  build() {
    Column() {
      // 标题。
      Flex({
        direction: FlexDirection.Row
      }) {
        Text(this.moduleName)
          .fontSize(MARGIN_FONT_SIZE.THIRD_MARGIN)
          .fontWeight(FontWeight.Bolder)
      }
      .margin({
        left: STRING_PERCENT.INDEX_SWIPER_LEFT_RIGHT_MARGIN,
        top: MARGIN_FONT_SIZE.FIRST_MARGIN,
        bottom: MARGIN_FONT_SIZE.FIRST_MARGIN
      })
      // 横向滑动列表。
      List({
        space: MARGIN_FONT_SIZE.FIRST_MARGIN
      }) {
        ForEach(HORIZONTAL_VIDEOS,
          (item: HorizontalVideoItem, index?: number) => {
            ListItem() {
              this.HorizontalItem(item.image, NET, item.name);
            }
          },
          (item: HorizontalVideoItem, index?: number) => {
            return JSON.stringify(item) + index;
          });
      }
      .listDirection(Axis.Horizontal)
    }
    .width(STRING_PERCENT.INDEX_COMPONENT_WITH_PERCENT)
    .margin({
      left: STRING_PERCENT.INDEX_SWIPER_LEFT_RIGHT_MARGIN,
      right: STRING_PERCENT.INDEX_SWIPER_LEFT_RIGHT_MARGIN
    })
    .borderRadius(MARGIN_FONT_SIZE.FOURTH_MARGIN)
    .borderStyle(BorderStyle.Solid)
    .borderColor(Color.White)
    .backgroundColor($r("app.color.white"))
    .justifyContent(FlexAlign.Center)
  }

  @Builder HorizontalItem(
    imageSrc: Resource = $r("app.string.simple_video_empty"),
    source: string = "",
    videoName: string = ""
  ) {
    Column() {
      Image(imageSrc)
        .width(MARGIN_FONT_SIZE.SEVENTH_MARGIN)
        .height(MARGIN_FONT_SIZE.SIXTH_MARGIN)
        .onClick(() => {
          router.pushUrl({
            url: SECOND_PAGE,
            params: {
              source: source
            }
          })
        })
      Text(videoName)
        .margin({
          top: MARGIN_FONT_SIZE.FIRST_MARGIN,
          bottom: MARGIN_FONT_SIZE.FIRST_MARGIN
        })
        .textAlign(TextAlign.Center)
        .fontSize(MARGIN_FONT_SIZE.SECOND_MARGIN)
    }
    .justifyContent(FlexAlign.Center)
  }
}