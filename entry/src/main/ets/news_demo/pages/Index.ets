import { CommonConstant } from '../common/constants/CommonConstant'
import { NewsTypeBean } from '../model/NewsTypeBean'
import { NewsList } from '../view/NewsList';
import NewsViewModel from "../viewmodel/NewsViewModel";

@Entry
@Component
struct Index {
  @State tabBarArray: NewsTypeBean[] = NewsViewModel.getDefaultTypeList();
  @State currentIndex: number = 0;
  @State currentPage: number = 1;

  aboutToAppear() {
    NewsViewModel.getNewsTypeList()
      .then((typeLists: NewsTypeBean[]) => this.tabBarArray = typeLists)
      .catch((typeLists: NewsTypeBean[]) => this.tabBarArray = typeLists);
  }

  build() {
    Column() {
      Tabs() {
        ForEach(this.tabBarArray,
          (item: NewsTypeBean, index?: number) => {
            TabContent() {
              Column() {
                NewsList({
                  currentIndex: $currentIndex
                })
              }
            }
            .tabBar(this.TabBuilder(item.id))
          },
          (item: NewsTypeBean, index?: number) => {
            return JSON.stringify(item) + index;
          })
      }
      .barHeight(CommonConstant.TabBars_BAR_HEIGHT)
      .barMode(BarMode.Scrollable)
      .barWidth(CommonConstant.TabBars_BAR_WIDTH)
      .onChange((index: number) => {
        this.currentIndex = index;
        this.currentPage = 1;
      })
      .vertical(false)
    }
    .width(CommonConstant.FULL_WIDTH)
    .backgroundColor($r("app.color.news_listColor"))
    .justifyContent(FlexAlign.Center)
  }

  @Builder TabBuilder(index: number) {
    Column() {
      Text(this.tabBarArray[index].name)
        .height(CommonConstant.FULL_HEIGHT)
        .padding({
          left: CommonConstant.TabBars_HORIZONTAL_PADDING,
          right: CommonConstant.TabBars_HORIZONTAL_PADDING
        })
        .fontSize(this.currentIndex === index ? CommonConstant.TabBars_SELECT_TEXT_FONT_SIZE : CommonConstant.TabBars_UN_SELECT_TEXT_FONT_SIZE)
        .fontWeight(this.currentIndex === index ? CommonConstant.TabBars_SELECT_TEXT_FONT_WEIGHT : CommonConstant.TabBars_UN_SELECT_TEXT_FONT_WEIGHT)
        .fontColor($r("app.color.news_fontColor_text3"))
    }
  }
}