import CommonConstants from '../common/constants/CommonConstants';
import { RefreshConstants, RefreshState } from '../common/constants/RefreshConstants';
import DimensionUtils from '../common/utils/DimensionUtils';

@Component
export struct RefreshDefaultHeader {
  @State refreshTitle: Resource = $r("app.string.anim_refresh_default_header_hint");
  @Consume(RefreshConstants.REFRESH_STATE_TAG) @Watch("onStateCheck") state: number;

  build() {
    if (this.state !== RefreshState.IDLE) {
      Text(this.refreshTitle)
        .width(CommonConstants.FULL_LENGTH)
        .height(CommonConstants.FULL_LENGTH)
        .textAlign(TextAlign.Center)
        .fontSize(DimensionUtils.getFp($r("app.float.anim_default_header_font_size")))
        .onAppear(() => this.onStateCheck())
    }
  }

  onStateCheck() {
    switch (this.state) {
      case RefreshState.IDLE:
        this.refreshTitle = $r("app.string.anim_refresh_default_header_hint");
        break;
      case RefreshState.DRAGGING_REFRESHABLE:
        this.refreshTitle = $r("app.string.anim_refresh_default_header_load");
        break;
      case RefreshState.REFRESHING:
        this.refreshTitle = $r("app.string.anim_refresh_default_header_loading");
        break;
      default:
        break;
    }
  }
}