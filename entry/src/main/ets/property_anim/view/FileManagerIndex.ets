import display from '@ohos.display'
import CommonConstants from '../common/constants/CommonConstants';
import { RefreshConstants, RefreshHeaderStyle, RefreshState } from '../common/constants/RefreshConstants';
import DimensionUtils from '../common/utils/DimensionUtils';
import { GlobalContext } from '../../main_contents/common/utils/GlobalContext'
import { RefreshComponent } from './RefreshComponent';

@Component
export struct FileManagerIndex {
  private deviceDisplay: display.Display = GlobalContext.getInstance().getObject("display") as display.Display;

  @Provide(RefreshConstants.REFRESH_STATE_TAG) state: number = RefreshState.REFRESHING;

  build() {
    Stack({
      alignContent: Alignment.Top
    }) {
      Text($r("app.string.anim_file_index_title"))
        .backgroundColor(Color.White)
        .width(CommonConstants.FULL_LENGTH)
        .height(DimensionUtils.getVp($r('app.float.anim_file_index_title_height')))
        .fontSize(DimensionUtils.getFp($r('app.float.anim_file_index_title_size')))
        .fontWeight(FontWeight.Regular)
        .padding({
          left: DimensionUtils.getVp($r('app.float.anim_file_index_title_padding'))
        })
        .zIndex(CommonConstants.FILE_MANAGER_Z_INDEX)
      RefreshComponent({
        headerStyle: RefreshHeaderStyle.CLOUD,
        itemLayout: () => this.ContentBody(),
        displayHeight: px2vp(this.deviceDisplay.height) - DimensionUtils.getVp($r("app.float.anim_file_index_title_height")),
        onRefresh: () => {
          setTimeout(() => this.state = RefreshState.COMPLETE,
            CommonConstants.REFRESH_DEFAULT_TIMEOUT)
        }
      })
        .width(CommonConstants.FULL_LENGTH)
        .margin({
          top: DimensionUtils.getVp($r("app.float.anim_file_index_title_height"))
        })
    }
    .height(CommonConstants.FULL_LENGTH)
  }

  @Builder ContentBody() {
    Image($r("app.media.anim_bg_content"))
      .width(CommonConstants.FULL_LENGTH)
      .height(DimensionUtils.getVp($r("app.float.anim_content_height")))
      .objectFit(ImageFit.Fill)
  }
}