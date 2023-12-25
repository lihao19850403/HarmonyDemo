import { CustomRefreshLoadLayoutClass } from '../model/CustomRefreshLoadLayoutClass'
import { CustomRefreshLoadLayout } from './CustomRefreshLoadLayout';

/* 加载更多的提示布局。 */
@Component
export struct LoadMoreLayout {
  @ObjectLink loadMoreLayoutClass: CustomRefreshLoadLayoutClass;

  build() {
    if (this.loadMoreLayoutClass.isVisible) {
      CustomRefreshLoadLayout({
        customRefreshLoadClass: new CustomRefreshLoadLayoutClass(
          this.loadMoreLayoutClass.isVisible,
          this.loadMoreLayoutClass.imageSrc,
          this.loadMoreLayoutClass.textValue,
          this.loadMoreLayoutClass.heightValue
        )
      })
    } else {
      CustomRefreshLoadLayout({
        customRefreshLoadClass: new CustomRefreshLoadLayoutClass(
          this.loadMoreLayoutClass.isVisible,
          this.loadMoreLayoutClass.imageSrc,
          this.loadMoreLayoutClass.textValue,
          0
        )
      })
    }
  }
}