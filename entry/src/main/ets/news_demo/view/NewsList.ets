import promptAction from '@ohos.promptAction';
import { CommonConstant, PageState } from '../common/constants/CommonConstant';
import { CustomRefreshLoadLayoutClass } from '../model/CustomRefreshLoadLayoutClass';
import { NewsData } from '../model/NewsData';
import { NewsOfTypeModel } from '../model/NewsOfTypeModel';
import NewsViewModel from "../viewmodel/NewsViewModel";
import { CustomRefreshLoadLayout } from './CustomRefreshLoadLayout';
import { LoadMoreLayout } from './LoadMoreLayout';
import { NewsItem } from './NewsItem';
import { NoMoreLayout } from './NoMoreLayout';
import { RefreshLayout } from './RefreshLayout';
import { listTouchEvent } from "../viewmodel/ListTouchEvent";

/* 新闻列表页面。 */
@Component
export struct NewsList {
  @State newsOfTypeModel: NewsOfTypeModel = new NewsOfTypeModel();
  @Link @Watch("changeCategory") currentIndex: number;

  aboutToAppear() {
    this.changeCategory();
  }

  build() {
    Column() {
      if (this.newsOfTypeModel.pageState === PageState.Success) {
        this.ListLayout();
      } else if (this.newsOfTypeModel.pageState === PageState.Loading) {
        this.LoadingLayout();
      } else {
         this.FailLayout();
      }
    }
    .width(CommonConstant.FULL_WIDTH)
    .height(CommonConstant.FULL_HEIGHT)
    .justifyContent(FlexAlign.Center)
    .onTouch((event: TouchEvent | undefined) => {
      if (event) {
        if (this.newsOfTypeModel.pageState === PageState.Success) {
          listTouchEvent(this.newsOfTypeModel, event);
        }
      }
    })
  }

  changeCategory() {
    this.newsOfTypeModel.currentPage = 1;
    NewsViewModel.getNewsList(
      this.newsOfTypeModel.currentPage,
      this.newsOfTypeModel.pageSize,
      CommonConstant.GET_NEWS_LIST
    )
      .then((data: NewsData[]) => {
        this.newsOfTypeModel.pageState = PageState.Success;
        if (data.length === this.newsOfTypeModel.pageSize) {
          this.newsOfTypeModel.currentPage++;
          this.newsOfTypeModel.hasMore = true;
        } else {
          this.newsOfTypeModel.hasMore = false;
        }
        this.newsOfTypeModel.newsData = data;
      })
      .catch((error) => {
        promptAction.showToast({
          message: error,
          duration: CommonConstant.ANIMATION_DURATION
        });
        this.newsOfTypeModel.pageState = PageState.Fail;
      });
  }

  @Builder LoadingLayout() {
    CustomRefreshLoadLayout({
      customRefreshLoadClass: new CustomRefreshLoadLayoutClass(
        true,
        $r("app.media.news_ic_pull_up_load"),
        $r("app.string.news_pull_up_load_text"),
        this.newsOfTypeModel.pullDownRefreshHeight
      )
    })
  }

  @Builder FailLayout() {
    Image($r("app.media.news_none"))
      .width(CommonConstant.NewsListConstant_NONE_IMAGE_SIZE)
      .height(CommonConstant.NewsListConstant_NONE_IMAGE_SIZE)
    Text($r("app.string.news_page_none_msg"))
      .opacity(CommonConstant.NewsListConstant_NONE_TEXT_opacity)
      .fontSize(CommonConstant.NewsListConstant_NONE_IMAGE_SIZE)
      .fontColor($r("app.color.news_fontColor_text3"))
      .margin({
        top: CommonConstant.NewsListConstant_NONE_TEXT_margin
      })
  }

  @Builder ListLayout() {
    List() {
      ListItem() {
        // 下拉刷新提示。
        RefreshLayout({
          refreshLayoutClass: new CustomRefreshLoadLayoutClass(
            this.newsOfTypeModel.isVisiblePullDown,
            this.newsOfTypeModel.pullDownRefreshImage,
            this.newsOfTypeModel.pullDownRefreshText,
            this.newsOfTypeModel.pullDownRefreshHeight
          )
        })
      }
      // 新闻列表。
      ForEach(this.newsOfTypeModel.newsData,
        (item: NewsData, index?: number) => {
          ListItem() {
            NewsItem({
              newsData: item
            })
          }
          .height($r("app.float.news_list_height"))
          .backgroundColor($r("app.color.white"))
          .margin({
            top: $r("app.float.news_list_margin_top")
          })
          .borderRadius(CommonConstant.NewsListConstant_ITEM_BORDER_RADIUS)
        },
        (item: NewsData, index?: number) => {
          return JSON.stringify(item) + index;
        })
      // 上啦加载更多提示。
      ListItem() {
        if (this.newsOfTypeModel.hasMore) {
          LoadMoreLayout({
            loadMoreLayoutClass: new CustomRefreshLoadLayoutClass(
              this.newsOfTypeModel.isVisiblePullUpLoad,
              this.newsOfTypeModel.pullUpLoadImage,
              this.newsOfTypeModel.pullUpLoadText,
              this.newsOfTypeModel.pullUpLoadHeight
            )
          })
        } else {
          NoMoreLayout()
        }
      }
    }
    .width(CommonConstant.NewsListConstant_LIST_WIDTH)
    .height(CommonConstant.FULL_HEIGHT)
    .margin({
      left: CommonConstant.NewsListConstant_LIST_MARGIN_LEFT,
      right: CommonConstant.NewsListConstant_LIST_MARGIN_RIGHT
    })
    .backgroundColor($r("app.color.news_listColor"))
    .divider({
      color:$r("app.color.news_dividerColor"),
      strokeWidth: CommonConstant.NewsListConstant_LIST_DIVIDER_STROKE_WIDTH,
      endMargin: CommonConstant.NewsListConstant_LIST_MARGIN_RIGHT
    })
    .edgeEffect(EdgeEffect.None)
    .offset({
      x: 0,
      y: `${this.newsOfTypeModel.offsetY}${CommonConstant.LIST_OFFSET_UNIT}`
    })
    .onScrollIndex((start: number, end: number) => {
      this.newsOfTypeModel.startIndex = start;
      this.newsOfTypeModel.endIndex = end;
    })
  }
}