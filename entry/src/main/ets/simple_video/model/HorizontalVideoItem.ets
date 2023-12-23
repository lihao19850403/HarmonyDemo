/* 横向列表中展示的图片信息。 */

@Observed
export class HorizontalVideoItem {
  id: number;
  image: Resource;
  name: string;

  constructor(id: number, image: Resource, name: string) {
    this.id = id;
    this.image = image;
    this.name = name;
  }
}