import Prompt from '@ohos.promptAction';
import { APP_EXIT_INTERVAL, Style, TIME, TITLE, WEIGHT } from '../common/constants/Constants';
import { ListHeaderComponent } from '../view/ListHeaderComponent';
import { ListItemComponent } from '../view/ListItemComponent';
import { TitleComponent } from '../view/TitleComponent';
import { RankData } from '../viewmodel/RankData'
import { RankViewModel } from '../viewmodel/RankViewModel';

@Entry
@Component
struct RankPage {
  private clickBackTimeRecord: number = 0;

  @State dataSource1: RankData[] = [];
  @State dataSource2: RankData[] = [];
  @State isSwitchDataSource: boolean = true;

  aboutToAppear() {
    let rankModel: RankViewModel = new RankViewModel();
    this.dataSource1 = rankModel.loadRankDataSource1();
    this.dataSource2 = rankModel.loadRankDataSource2();
  }

  onBackPress() {
    if (new Date().getTime() - this.clickBackTimeRecord > APP_EXIT_INTERVAL) {
      Prompt.showToast({
        message: $r("app.string.rank_page_prompt_text"),
        duration: TIME
      })
      this.clickBackTimeRecord = new Date().getTime();
      return true;
    }
    return false;
  }

  build() {
    Column() {
      // 标题栏。
      TitleComponent({
        isRefreshData: $isSwitchDataSource,
        title: TITLE
      })
      // 列表表头。
      ListHeaderComponent({
        paddingValue: {
          left: Style.RANK_PADDING,
          right: Style.RANK_PADDING
        },
        widthValue: Style.CONTENT_WIDTH
      })
        .margin({
          top: Style.HEADER_MARGIN_TOP,
          bottom: Style.HEADER_MARGIN_BOTTOM
        })
      // 列表内容。
      this.RankList(Style.CONTENT_WIDTH)
    }
    .backgroundColor($r("app.color.page_background"))
    .height(WEIGHT)
    .width(WEIGHT)
  }

  /* 生成商品信息列表。 */
  @Builder RankList(widthValue: Length) {
    Column() {
      List() {
        ForEach(this.isSwitchDataSource ? this.dataSource1 : this.dataSource2,
          (item: RankData, index?: number) => {
            ListItem() {
              ListItemComponent({
                index: (Number(index) + 1),
                name: item.name,
                vote: item.vote,
                isSwitchDataSource: this.isSwitchDataSource
              })
            }
          },
          (item: RankData) => JSON.stringify(item))
      }
      .width(WEIGHT)
      .height(Style.LIST_HEIGHT)
      .divider({
        strokeWidth: Style.STROKE_WIDTH
      })
    }
    .padding({
      left: Style.RANK_PADDING,
      right:Style.RANK_PADDING
    })
    .borderRadius(Style.BORDER_RADIUS)
    .width(widthValue)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor(Color.White)
  }
}