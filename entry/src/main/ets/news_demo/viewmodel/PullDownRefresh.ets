import promptAction from '@ohos.promptAction';
import { CommonConstant, RefreshState } from '../common/constants/CommonConstant';
import { NewsData } from '../model/NewsData';
import { NewsOfTypeModel } from '../model/NewsOfTypeModel';
import NewsViewModel from './NewsViewModel';

/* 下拉刷新的状态。 */
export function pullRefreshState(newsOfTypeModel: NewsOfTypeModel, state: number) {
  switch (state) {
    case RefreshState.DropDown:
      newsOfTypeModel.pullDownRefreshText = $r('app.string.news_pull_down_refresh_text');
      newsOfTypeModel.pullDownRefreshImage = $r('app.media.news_ic_pull_down_refresh');
      newsOfTypeModel.isCanRefresh = false;
      newsOfTypeModel.isRefreshing = false;
      newsOfTypeModel.isVisiblePullDown = true;
      break;
    case RefreshState.Release:
      newsOfTypeModel.pullDownRefreshText = $r('app.string.news_release_refresh_text');
      newsOfTypeModel.pullDownRefreshImage = $r('app.media.news_ic_pull_up_refresh');
      newsOfTypeModel.isCanRefresh = true;
      newsOfTypeModel.isRefreshing = false;
      break;
    case RefreshState.Refreshing:
      newsOfTypeModel.offsetY = vp2px(newsOfTypeModel.pullDownRefreshHeight);
      newsOfTypeModel.pullDownRefreshText = $r('app.string.news_refreshing_text');
      newsOfTypeModel.pullDownRefreshImage = $r('app.media.news_ic_pull_up_load');
      newsOfTypeModel.isCanRefresh = true;
      newsOfTypeModel.isRefreshing = true;
      break;
    case RefreshState.Success:
      newsOfTypeModel.pullDownRefreshText = $r('app.string.news_refresh_success_text');
      newsOfTypeModel.pullDownRefreshImage = $r('app.media.news_ic_succeed_refresh');
      newsOfTypeModel.isCanRefresh = true;
      newsOfTypeModel.isRefreshing = true;
      break;
    case RefreshState.Fail:
      newsOfTypeModel.pullDownRefreshText = $r('app.string.news_refresh_fail_text');
      newsOfTypeModel.pullDownRefreshImage = $r('app.media.news_ic_fail_refresh');
      newsOfTypeModel.isCanRefresh = true;
      newsOfTypeModel.isRefreshing = true;
      break;
    default:
      break;
  }
}

/* 手指触摸时候刷新。 */
export function touchMovePullRefresh(newsOfTypeModel: NewsOfTypeModel, event: TouchEvent) {
  if (newsOfTypeModel.startIndex === 0) {
    newsOfTypeModel.isPullRefreshOperation = true;
    let height = vp2px(newsOfTypeModel.pullDownRefreshHeight);
    newsOfTypeModel.offsetY = event.touches[0].y - newsOfTypeModel.downY;
    if (newsOfTypeModel.offsetY >= height) {
      pullRefreshState(newsOfTypeModel, RefreshState.Release);
      newsOfTypeModel.offsetY = height + newsOfTypeModel.offsetY * CommonConstant.Y_OFF_SET_COEFFICIENT;
    } else {
      pullRefreshState(newsOfTypeModel, RefreshState.DropDown);
    }
    if (newsOfTypeModel.offsetY < 0) {
      newsOfTypeModel.offsetY = 0;
      newsOfTypeModel.isPullRefreshOperation = false;
    }
  }
}

/* 手指抬起时候刷新。 */
export function touchUpPullRefresh(newsOfTypeModel: NewsOfTypeModel) {
  if (newsOfTypeModel.isCanRefresh === true) {
    newsOfTypeModel.offsetY = vp2px(newsOfTypeModel.pullDownRefreshHeight);
    pullRefreshState(newsOfTypeModel, RefreshState.Refreshing);
    newsOfTypeModel.currentPage = 1;
    setTimeout(() => {
      let self: NewsOfTypeModel = newsOfTypeModel;
      NewsViewModel.getNewsList(newsOfTypeModel.currentPage, newsOfTypeModel.pageSize, CommonConstant.GET_NEWS_LIST)
        .then((data: NewsData[]) => {
          if (data.length === newsOfTypeModel.pageSize) {
            self.hasMore = true;
            self.currentPage++;
          } else {
            self.hasMore = false;
          }
          self.newsData = data;
          closeRefresh(self, true);
        }).catch((err: string | Resource) => {
          promptAction.showToast({
            message: err
          });
          closeRefresh(self, false);
        });
    }, CommonConstant.DELAY_TIME);
  } else {
    closeRefresh(newsOfTypeModel, false);
  }
}

/* 停止刷新的动作。 */
export function closeRefresh(newsOfTypeModel: NewsOfTypeModel, isRefreshSuccess: boolean) {
  let self = newsOfTypeModel;
  setTimeout(() => {
    let delay = CommonConstant.RefreshConstant_DELAY_PULL_DOWN_REFRESH;
    if (self.isCanRefresh === true) {
      pullRefreshState(newsOfTypeModel, isRefreshSuccess ? RefreshState.Success : RefreshState.Fail);
      delay = CommonConstant.RefreshConstant_DELAY_SHRINK_ANIMATION_TIME;
    }
    animateTo({
      duration: CommonConstant.RefreshConstant_CLOSE_PULL_DOWN_REFRESH_TIME,
      delay: delay,
      onFinish: () => {
        pullRefreshState(newsOfTypeModel, RefreshState.DropDown);
        self.isVisiblePullDown = false;
        self.isPullRefreshOperation = false;
      }
    }, () => {
      self.offsetY = 0;
    })
  }, self.isCanRefresh ? CommonConstant.DELAY_ANIMATION_DURATION : 0);
}