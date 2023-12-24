import CommonConstants from '../common/constants/CommonConstants';
import { RefreshConstants, RefreshHeaderStyle, RefreshState } from '../common/constants/RefreshConstants'
import { RefreshAnimHeader } from './RefreshAnimHeader';
import { RefreshDefaultHeader } from './RefreshDefaultHeader';

@Component
export struct RefreshComponent {
  private headerStyle: RefreshHeaderStyle = RefreshHeaderStyle.DEFAULT;
  private displayHeight: number = 0;
  private listController: Scroller = new Scroller();
  private onRefresh?: () => void;

  @State headerOffset: number = 0;
  @Consume(RefreshConstants.REFRESH_STATE_TAG) @Watch("onStateChanged") state: number;
  // 此处接收从父组件传递进来的布局构造方法。
  @BuilderParam itemLayout?: () => void;

  aboutToAppear() {
    switch (this.state) {
      case RefreshState.REFRESHING:
        this.headerOffset = 0;
        this.onStateChanged();
        break;
      default:
        this.state = RefreshState.IDLE;
        this.headerOffset = -RefreshConstants.REFRESH_HEADER_HEIGHT;
        break;
    }
    this.displayHeight = RefreshConstants.REFRESH_HEADER_HEIGHT + Number(this.displayHeight);
  }

  build() {
    List({
      scroller: this.listController
    }) {
      ListItem() {
        Column() {
          if (this.headerStyle === RefreshHeaderStyle.DEFAULT) {
            RefreshDefaultHeader()
              .height(RefreshConstants.REFRESH_HEADER_HEIGHT)
          } else if (this.headerStyle === RefreshHeaderStyle.CLOUD) {
            RefreshAnimHeader()
              .height(RefreshConstants.REFRESH_HEADER_HEIGHT);
          }
          if (this.itemLayout) {
            this.itemLayout();
          }
        }
        .width(CommonConstants.FULL_LENGTH)
        .height(RefreshConstants.REFRESH_LAYOUT_EXTRA_HEIGHT + Number(this.displayHeight))
      }
    }
    .edgeEffect(EdgeEffect.Spring)
    .width(CommonConstants.FULL_LENGTH)
    .height(this.displayHeight)
    .listDirection(Axis.Vertical)
    .offset({
      y: this.headerOffset
    })
    // 这个动画是list的回弹动画。
    .animation({
      curve: Curve.Smooth,
      duration: RefreshConstants.REFRESH_HEADER_ANIM_DURATION,
      playMode: PlayMode.Normal,
      onFinish: () => {
        if (this.headerOffset === -RefreshConstants.REFRESH_HEADER_HEIGHT) {
          this.state = RefreshState.IDLE;
        }
      }
    })
    .onTouch((event?: TouchEvent) => {
      if (!event) {
        return;
      }
      switch (event.type) {
        case TouchType.Down:
          if (this.state === RefreshState.IDLE) {
            this.state = RefreshState.DRAGGING;
          }
          break;
        case TouchType.Move:
          if (this.state === RefreshState.DRAGGING && this.listController.currentOffset().yOffset <= -RefreshConstants.REFRESH_EFFECTIVE_HEIGHT) {
            this.state = RefreshState.DRAGGING_REFRESHABLE;
          }
          break;
        case TouchType.Up:
          if (this.state === RefreshState.DRAGGING_REFRESHABLE) {
            this.state = RefreshState.REFRESHING;
            this.headerOffset = 0;
          }
          break;
        default:
          break;
      }
    })
  }

  onStateChanged() {
    switch (this.state) {
      case RefreshState.REFRESHING:
        if (this.onRefresh) {
          this.onRefresh();
        }
        break;
      case RefreshState.COMPLETE:
        this.headerOffset = -RefreshConstants.REFRESH_HEADER_HEIGHT;
        break;
      default:
        break;
    }
  }
}