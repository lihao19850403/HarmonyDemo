/* banner中展示的视频预览图。 */

@Observed
export class SwiperVideoItem {
  image: Resource;

  constructor(image: Resource) {
    this.image = image;
  }
}