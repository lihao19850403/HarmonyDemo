import { CommonConstant } from '../common/constants/CommonConstant';
import { httpRequestGet } from '../common/utils/HttpUtils';
import { NewsData } from '../model/NewsData';
import { NewsTypeBean } from '../model/NewsTypeBean';
import { ResponseResult } from '../model/ResponseResult';

class NewsViewModel {

  /* 获取所有新闻类型。 */
  getNewsTypeList(): Promise<NewsTypeBean[]> {
    return new Promise((resolve: Function) => {
      let url = `${CommonConstant.SERVER}/${CommonConstant.GET_NEWS_TYPE}`;
      httpRequestGet(url)
        .then((responseResult: ResponseResult) => {
          if (responseResult.code === CommonConstant.SERVER_CODE_SUCCESS) {
            resolve(responseResult.data);
          } else {
            resolve(CommonConstant.TabBars_DEFAULT_NEWS_TYPES);
          }
        }).catch(() => resolve(CommonConstant.TabBars_DEFAULT_NEWS_TYPES));
    });
  }

  /* 获取默认的新闻类型。 */
  getDefaultTypeList(): NewsTypeBean[] {
    return CommonConstant.TabBars_DEFAULT_NEWS_TYPES;
  }

  /* 获取新闻列表。 */
  getNewsList(currentPage: number, pageSize: number, path: string): Promise<NewsData[]> {
    return new Promise(async (resolve: Function, reject: Function) => {
      let url = `${CommonConstant.SERVER}/${path}?currentPage=${currentPage}&pageSize=${pageSize}`;
      httpRequestGet(url)
        .then((responseResult: ResponseResult) => {
          if (responseResult.code === CommonConstant.SERVER_CODE_SUCCESS) {
            resolve(responseResult.data);
          } else {
            reject($r("app.string.news_page_none_msg"));
          }
        }).catch((error) => {
        reject($r("app.string.news_http_error_message"));
      });
    });
  }
}

export default new NewsViewModel();