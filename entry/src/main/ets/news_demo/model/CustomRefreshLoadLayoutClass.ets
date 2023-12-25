/* 滑动刷新组件用到的数据。 */
@Observed
export class CustomRefreshLoadLayoutClass {
  isVisible: boolean;
  imageSrc: Resource;
  textValue: Resource;
  heightValue: number;

  constructor(isVisible: boolean, imageSrc: Resource, textValue: Resource, heightValue: number) {
    this.isVisible = isVisible;
    this.imageSrc = imageSrc;
    this.textValue = textValue;
    this.heightValue = heightValue;
  }
}