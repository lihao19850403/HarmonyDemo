import { NewsOfTypeModel } from '../model/NewsOfTypeModel';
import { touchMovePullRefresh, touchUpPullRefresh } from './PullDownRefresh';
import { touchMoveLoadMore, touchUpLoadMore } from './PullUpLoadMore';

/* 完整的列表触摸动作。 */
export function listTouchEvent(newsOfTypeModel: NewsOfTypeModel, event: TouchEvent) {
  switch (event.type) {
    case TouchType.Down:
      newsOfTypeModel.downY = event.touches[0].y;
      newsOfTypeModel.lastMoveY = event.touches[0].y;
      break;
    case TouchType.Move:
      if ((newsOfTypeModel.isRefreshing === true)
      || (newsOfTypeModel.isLoading === true)) {
        return;
      }
      let isDownPull = event.touches[0].y - newsOfTypeModel.lastMoveY > 0;
      if (((isDownPull === true) || (newsOfTypeModel.isPullRefreshOperation === true))
      && (newsOfTypeModel.isCanLoadMore === false)) {
        touchMovePullRefresh(newsOfTypeModel, event);
      } else {
        touchMoveLoadMore(newsOfTypeModel, event);
      }
      newsOfTypeModel.lastMoveY = event.touches[0].y;
      break;
    case TouchType.Cancel:
      break;
    case TouchType.Up:
      if ((newsOfTypeModel.isRefreshing === true)
      || (newsOfTypeModel.isLoading === true)) {
        return;
      }
      if ((newsOfTypeModel.isPullRefreshOperation === true)) {
        touchUpPullRefresh(newsOfTypeModel);
      } else {
        touchUpLoadMore(newsOfTypeModel);
      }
      break;
    default:
      break;
  }
}