import http from '@ohos.net.http';
import { ResponseResult } from '../../model/ResponseResult';
import { CommonConstant, ContentType } from '../constants/CommonConstant';

/* 发送一个Http Get请求。 */
export function httpRequestGet(url: string): Promise<ResponseResult> {
  let httpRequest = http.createHttp();
  let request = httpRequest.request(url, {
    method: http.RequestMethod.GET,
    readTimeout: CommonConstant.HTTP_READ_TIMEOUT,
    connectTimeout: CommonConstant.HTTP_READ_TIMEOUT,
    header: {
      'Content-Type': ContentType.JSON
    },
    extraData: {}
  });
  let responseResult = new ResponseResult();
  return request.then((response: http.HttpResponse) => {
    if (response.responseCode == CommonConstant.HTTP_CODE_200) {
      let result = `${response.result}`;
      let resultJson: ResponseResult = JSON.parse(result);
      if (resultJson.code === CommonConstant.SERVER_CODE_SUCCESS) {
        responseResult.data = resultJson.data;
      }
      responseResult.code = resultJson.code;
      responseResult.msg = resultJson.msg;
    } else {
      responseResult.msg = `${$r("app.string.news_http_error_message")}&${response.responseCode}`;
    }
    return responseResult;
  }).catch(() => {
    responseResult.msg = $r("app.string.news_http_error_message");
    return responseResult;
  });
}