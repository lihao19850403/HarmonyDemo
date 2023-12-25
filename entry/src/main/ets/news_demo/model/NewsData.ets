import { NewsImageFile } from "./NewsImageFile";

/* 一篇新闻。 */
export class NewsData {
  title: string = "";
  content: string = "";
  source: string = "";
  // 新闻中可能有多张图片。
  imagesUrl: Array<NewsImageFile> = [
    new NewsImageFile()
  ];
}