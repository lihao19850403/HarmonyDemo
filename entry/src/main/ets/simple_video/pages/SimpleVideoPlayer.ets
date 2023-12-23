import router from '@ohos.router'
import { ALL_PERCENT, COMMON_NUM_FONT_WEIGHT, MARGIN_FONT_SIZE, STACK_STYLE } from '../common/constants/CommonConstants';
import { ParamItem } from '../model/ParamItem'
import { VideoPlayer } from '../view/VideoPlayer';
@Entry
@Component
struct SimpleVideoPlayer {
  private source: string = (router.getParams() as Record<string, Object>).source as string;
  private startIconResource: Resource = $r("app.media.simple_video_ic_public_play");
  private backIconResource: Resource = $r("app.media.simple_video_ic_back");
  controller: VideoController = new VideoController();

  @Provide isPlay: boolean = false;
  @Provide isOpacity: boolean = false;
  @Provide isLoading: boolean = false;
  @Provide isLoadingFinished: boolean = false;
  @Provide progressVal: number = 0;

  aboutToAppear() {
    this.source;
  }

  onPageHide() {
    this.controller.pause();
  }

  build() {
    Column() {
      // 标题。
      Row() {
        Image(this.backIconResource)
          .width(MARGIN_FONT_SIZE.FOURTH_MARGIN)
          .height(MARGIN_FONT_SIZE.FOURTH_MARGIN)
          .margin({
            left: MARGIN_FONT_SIZE.FOURTH_MARGIN
          })
          .onClick(() => router.back())
        Text($r("app.string.simple_video_back"))
          .fontSize(MARGIN_FONT_SIZE.FOURTH_MARGIN)
          .fontWeight(COMMON_NUM_FONT_WEIGHT)
          .fontColor(Color.White)
          .margin({
            left: MARGIN_FONT_SIZE.FIRST_MARGIN
          })
      }
      .width(ALL_PERCENT)
      .margin({
        left: MARGIN_FONT_SIZE.FIRST_MARGIN,
        top: MARGIN_FONT_SIZE.FIRST_MARGIN
      })
      .justifyContent(FlexAlign.Start)
      // 视频区域。
      Stack() {
        if (!this.isPlay && !this.isLoading) {
          Image(this.startIconResource)
            .width(MARGIN_FONT_SIZE.FIFTH_MARGIN)
            .height(MARGIN_FONT_SIZE.FIFTH_MARGIN)
            .zIndex(STACK_STYLE.IMAGE_Z_INDEX)
        }
        if (this.isLoading) {
          Progress({
            type: ProgressType.ScaleRing,
            total: STACK_STYLE.PROGRESS_TOTAL,
            value: STACK_STYLE.PROGRESS_VALUE
          })
            .width(STACK_STYLE.PROGRESS_WIDTH)
            .color(Color.Grey)
            .value(this.progressVal)
            .style({
              strokeWidth:STACK_STYLE.PROGRESS_STROKE_WIDTH,
              scaleWidth: STACK_STYLE.PROGRESS_SCALE_WIDTH,
              scaleCount: STACK_STYLE.PROGRESS_SCALE_COUNT
            })
            .zIndex(STACK_STYLE.PROGRESS_Z_INDEX)
        }
        VideoPlayer({
          source: this.source,
          controller: this.controller
        })
          .zIndex(0)
      }
    }
    .height(ALL_PERCENT)
    .backgroundColor(Color.Black)
  }
}