import CommonConstants from '../common/constants/CommonConstants'
import { RefreshConstants, RefreshState } from '../common/constants/RefreshConstants';
import DimensionUtils from '../common/utils/DimensionUtils';
import ClassifyModel from '../model/AnimationModel';

@Component
export struct RefreshAnimHeader {
  @State iconWidth: number = CommonConstants.REFRESH_HEADER_ITEM_DEFAULT_WIDTH;
  @Consume(RefreshConstants.REFRESH_STATE_TAG) @Watch("onStateCheck") state: number;

  build() {
    Row() {
      if (this.state !== RefreshState.IDLE) {
        ForEach(CommonConstants.REFRESH_HEADER_FEATURE,
          (item: ClassifyModel, index?: number) => {
            this.AttrAnimIcons(item);
          },
          (item: ClassifyModel, index?: number) => {
            return JSON.stringify(item) + index;
          });
      }
    }
    .width(CommonConstants.FULL_LENGTH)
    .height(CommonConstants.FULL_LENGTH)
    .onAppear(() => this.onStateCheck())
  }

  @Builder AttrAnimIcons(iconItem: ClassifyModel) {
    Image(iconItem.imgRes)
      .width(px2vp(DimensionUtils.adaptDimension(this.iconWidth)))
      .objectFit(ImageFit.Contain)
      .position({
        x: iconItem.posX
      })
      .animation({
        duration:CommonConstants.REFRESH_HEADER_ITEM_ANIM_DURATION,
        tempo: CommonConstants.REFRESH_HEADER_ITEM_ANIM_TEMPO,
        delay: iconItem.delay,
        curve: Curve.Linear,
        playMode: PlayMode.Alternate,
        iterations: CommonConstants.REFRESH_HEADER_ITEM_ANIM_ITERATIONS
      })
  }

  onStateCheck() {
    switch (this.state) {
      case RefreshState.REFRESHING:
        this.iconWidth = CommonConstants.REFRESH_HEADER_ITEM_SCALE_WIDTH;
        break;
      default:
        this.iconWidth = CommonConstants.REFRESH_HEADER_ITEM_DEFAULT_WIDTH;
        break;
    }
  }
}