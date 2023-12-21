/* 用于在标签页中显示的内容。 */
export class ItemData {

  /* 标题。 */
  title: Resource;

  /* 图标。 */
  img: Resource;

  /* 其他资源。 */
  others?: Resource;

  constructor(title: Resource, img: Resource, others?: Resource) {
    this.title = title;
    this.img = img;
    this.others = others;
  }
}