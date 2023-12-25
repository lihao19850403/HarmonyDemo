import { CommonConstant } from '../common/constants/CommonConstant';
import { NewsData } from '../model/NewsData'
import { NewsImageFile } from '../model/NewsImageFile';

/* 一篇文章。 */
@Component
export struct NewsItem {
  private newsData: NewsData = new NewsData();

  build() {
    Column() {
      // 标题。
      Row() {
        Image($r("app.media.news"))
          .width(CommonConstant.NewsTitle_IMAGE_WIDTH)
          .height($r("app.float.news_title_image_height"))
          .objectFit(ImageFit.Fill)
        Text(this.newsData.title)
          .width(CommonConstant.NewsTitle_TEXT_WIDTH)
          .fontSize(CommonConstant.NewsTitle_TEXT_FONT_SIZE)
          .fontWeight(CommonConstant.NewsTitle_TEXT_FONT_WEIGHT)
          .fontColor($r("app.color.news_fontColor_text"))
          .maxLines(2)
          .margin({
            left: CommonConstant.NewsTitle_TEXT_MARGIN_LEFT
          })
          .textOverflow({
            overflow: TextOverflow.Ellipsis
          })
      }
      .height($r("app.float.news_title_row_height"))
      .alignItems(VerticalAlign.Center)
      .margin({
        top: $r("app.float.news_title_row_margin_top"),
        left: CommonConstant.NewsTitle_IMAGE_MARGIN_LEFT
      })
      // 新闻内容。
      Text(this.newsData.content)
        .width(CommonConstant.NewsContent_WIDTH)
        .height(CommonConstant.NewsContent_HEIGHT)
        .fontSize(CommonConstant.NewsContent_FONT_SIZE)
        .fontColor($r("app.color.news_fontColor_text"))
        .maxLines(CommonConstant.NewsContent_MAX_LINES)
        .margin({
          left: CommonConstant.NewsContent_MARGIN_LEFT,
          top: CommonConstant.NewsContent_MARGIN_TOP
        })
        .textOverflow({
          overflow: TextOverflow.Ellipsis
        })
      // 图片信息。
      Grid() {
        ForEach(this.newsData.imagesUrl,
          (item: NewsImageFile, index?: number) => {
            GridItem() {
              Image(CommonConstant.SERVER + item.url)
                .objectFit(ImageFit.Cover)
                .borderRadius(CommonConstant.NewsGrid_IMAGE_BORDER_RADIUS)
            }
          },
          (item: NewsImageFile, index?: number) => {
            return JSON.stringify(item) + index;
          })
      }
      .width(CommonConstant.NewsGrid_WIDTH)
      .height(CommonConstant.NewsGrid_HEIGHT)
      .columnsTemplate(CommonConstant.GRID_COLUMN_TEMPLATES.repeat(this.newsData.imagesUrl.length))
      .columnsGap(CommonConstant.NewsGrid_COLUMNS_GAP)
      .rowsTemplate(CommonConstant.NewsGrid_ROWS_TEMPLATE)
      .margin({
        left: CommonConstant.NewsGrid_MARGIN_LEFT,
        top: CommonConstant.NewsGrid_MARGIN_TOP,
        right: CommonConstant.NewsGrid_MARGIN_RIGHT
      })
      // 文章来源信息。
      Text(this.newsData.source)
        .width(CommonConstant.NewsSource_WIDTH)
        .height(CommonConstant.NewsSource_HEIGHT)
        .fontSize(CommonConstant.NewsSource_FONT_SIZE)
        .fontColor($r("app.color.news_fontColor_text2"))
        .maxLines(CommonConstant.NewsSource_MAX_LINES)
        .margin({
          left: CommonConstant.NewsSource_MARGIN_LEFT,
          top: CommonConstant.NewsSource_MARGIN_TOP
        })
        .textOverflow({
          overflow: TextOverflow.None
        })
    }
    .alignItems(HorizontalAlign.Start) // 横向靠左对齐。
  }
}