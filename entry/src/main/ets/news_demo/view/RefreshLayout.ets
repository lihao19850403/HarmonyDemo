import { CustomRefreshLoadLayoutClass } from '../model/CustomRefreshLoadLayoutClass'
import { CustomRefreshLoadLayout } from './CustomRefreshLoadLayout';

/* 刷新的提示布局。 */
@Component
export struct RefreshLayout {
  @ObjectLink refreshLayoutClass: CustomRefreshLoadLayoutClass;

  build() {
    if (this.refreshLayoutClass.isVisible) {
      CustomRefreshLoadLayout({
        customRefreshLoadClass: new CustomRefreshLoadLayoutClass(
          this.refreshLayoutClass.isVisible,
          this.refreshLayoutClass.imageSrc,
          this.refreshLayoutClass.textValue,
          this.refreshLayoutClass.heightValue
        )
      })
    }
  }
}