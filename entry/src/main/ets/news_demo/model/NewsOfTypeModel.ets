import { CommonConstant, PageState } from '../common/constants/CommonConstant';
import { NewsData } from './NewsData'

/* 一个分类下的所有新闻。 */
export class NewsOfTypeModel {
  newsData: Array<NewsData> = [];
  currentPage: number = 1;
  pageSize: number = CommonConstant.PAGE_SIZE;
  pullDownRefreshText: Resource = $r('app.string.news_pull_down_refresh_text');
  pullDownRefreshImage: Resource = $r('app.media.news_ic_pull_down_refresh');
  pullDownRefreshHeight: number = CommonConstant.CUSTOM_LAYOUT_HEIGHT;
  isVisiblePullDown: boolean = false;
  pullUpLoadText: Resource = $r('app.string.news_pull_up_load_text');
  pullUpLoadImage: Resource = $r('app.media.news_ic_pull_up_load');
  pullUpLoadHeight: number = CommonConstant.CUSTOM_LAYOUT_HEIGHT;
  isVisiblePullUpLoad: boolean = false;
  offsetY: number = 0;
  pageState: number = PageState.Loading;
  hasMore: boolean = true;
  startIndex = 0;
  endIndex = 0;
  downY = 0;
  lastMoveY = 0;
  isRefreshing: boolean = false;
  isCanRefresh = false;
  isPullRefreshOperation = false;
  isLoading: boolean = false;
  isCanLoadMore: boolean = false;
}