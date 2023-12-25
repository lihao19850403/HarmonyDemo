import promptAction from '@ohos.promptAction';
import { CommonConstant } from '../common/constants/CommonConstant';
import { NewsData } from '../model/NewsData';
import { NewsOfTypeModel } from '../model/NewsOfTypeModel';
import NewsViewModel from './NewsViewModel';

/* 移动手指时候加载更多。 */
export function touchMoveLoadMore(newsOfTypeModel: NewsOfTypeModel, event: TouchEvent) {
  if (newsOfTypeModel.endIndex === newsOfTypeModel.newsData.length - 1
  || newsOfTypeModel.endIndex === newsOfTypeModel.newsData.length) {
    newsOfTypeModel.offsetY = event.touches[0].y - newsOfTypeModel.downY;
    if (Math.abs(newsOfTypeModel.offsetY) > vp2px(newsOfTypeModel.pullUpLoadHeight) / 2) {
      newsOfTypeModel.isCanLoadMore = true;
      newsOfTypeModel.isVisiblePullUpLoad = true;
      newsOfTypeModel.offsetY = -vp2px(newsOfTypeModel.pullUpLoadHeight) + newsOfTypeModel.offsetY * CommonConstant.Y_OFF_SET_COEFFICIENT;
    }
  }
}

/* 停止加载更多。 */
export function closeLoadMore(newsOfTypeModel: NewsOfTypeModel) {
  newsOfTypeModel.isCanLoadMore = false;
  newsOfTypeModel.isLoading = false;
  newsOfTypeModel.isVisiblePullUpLoad = false;
}

/* 抬起手指时加载更多。 */
export function touchUpLoadMore(newsOfTypeModel: NewsOfTypeModel) {
  let self: NewsOfTypeModel = newsOfTypeModel;
  animateTo({
    duration: CommonConstant.ANIMATION_DURATION,
  }, () => self.offsetY = 0)
  if ((self.isCanLoadMore === true) && (self.hasMore === true)) {
    self.isLoading = true;
    setTimeout(() => {
      closeLoadMore(newsOfTypeModel);
      NewsViewModel.getNewsList(self.currentPage, self.pageSize, CommonConstant.GET_NEWS_LIST)
        .then((data: NewsData[]) => {
          if (data.length === self.pageSize) {
            self.currentPage++;
            self.hasMore = true;
          } else {
            self.hasMore = false;
          }
          self.newsData = self.newsData.concat(data);
        }).catch((err: string | Resource) => {
          promptAction.showToast({
            message: err
          });
        })
    }, CommonConstant.DELAY_TIME);
  } else {
    closeLoadMore(self);
  }
}