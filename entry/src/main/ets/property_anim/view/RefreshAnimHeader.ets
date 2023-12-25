import display from '@ohos.display';
import { GlobalContext } from '../common/utils/GlobalContext';
import CommonConstants from '../common/constants/CommonConstants'
import { RefreshConstants, RefreshState } from '../common/constants/RefreshConstants';
import DimensionUtils from '../common/utils/DimensionUtils';
import ClassifyModel from '../model/AnimationModel';

@Component
export struct RefreshAnimHeader {
  @State iconWidth: number = CommonConstants.REFRESH_HEADER_ITEM_DEFAULT_WIDTH;
  @Consume(RefreshConstants.REFRESH_STATE_TAG) @Watch("onStateCheck") state: number;

  private REFRESH_HEADER_FEATURE: ClassifyModel[] = this._initRefreshHeaderFeature();

  private _initRefreshHeaderFeature(): ClassifyModel[] {
    let deviceDisplay: display.Display = GlobalContext.getInstance().getObject('display') as display.Display;
    return [
      new ClassifyModel($r('app.media.anim_ic_loading_game'), (px2vp(deviceDisplay.width) / 2 - CommonConstants.REFRESH_HEADER_ITEM_DEFAULT_WIDTH / 2) - 100, 400),
      new ClassifyModel($r('app.media.anim_ic_loading_heart'), (px2vp(deviceDisplay.width) / 2 - CommonConstants.REFRESH_HEADER_ITEM_DEFAULT_WIDTH / 2) - 50, 800),
      new ClassifyModel($r('app.media.anim_ic_loading_louder'), px2vp(deviceDisplay.width) / 2 - CommonConstants.REFRESH_HEADER_ITEM_DEFAULT_WIDTH / 2, 1200),
      new ClassifyModel($r('app.media.anim_ic_loading_bag'), (px2vp(deviceDisplay.width) / 2 - CommonConstants.REFRESH_HEADER_ITEM_DEFAULT_WIDTH / 2) + 50, 1600),
      new ClassifyModel($r('app.media.anim_ic_loading_file'), (px2vp(deviceDisplay.width) / 2 - CommonConstants.REFRESH_HEADER_ITEM_DEFAULT_WIDTH / 2) + 100, 2000)
    ];
  }

  build() {
    Row() {
      if (this.state !== RefreshState.IDLE) {
        ForEach(this.REFRESH_HEADER_FEATURE,
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