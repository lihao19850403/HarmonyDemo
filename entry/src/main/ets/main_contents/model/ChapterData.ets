export class ChapterData {

  /* 章节ID。 */
  id: string;

  /* 章节名称。 */
  name: string;

  /* 章节路由，供跳转使用。 */
  url: string;

  constructor(id: string, name: string, url: string) {
    this.id = id;
    this.name = name;
    this.url = url;
  }
}