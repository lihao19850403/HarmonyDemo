/* 网络请求返回值。 */
export class ResponseResult {
  code: string = "";
  msg: string | Resource = "";
  data: string | Object | ArrayBuffer = "";
}