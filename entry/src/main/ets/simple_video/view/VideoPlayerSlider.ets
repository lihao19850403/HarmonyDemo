import { ALL_PERCENT, BIG_TRACK_THICK_NESS, DEFAULT_OPACITY, IMAGE_SIZE, MARGIN_FONT_SIZE, SMALL_TRACK_THICK_NESS, STACK_STYLE, STRING_PERCENT } from '../common/constants/CommonConstants';

/* 滑动条。 */
@Component
export struct VideoPlayerSlider {
  private controller: VideoController = new VideoController();

  @Consume currentStringTime: string;
  @Consume currentTime: number;
  @Consume durationStringTime: string;
  @Consume durationTime: number;
  @Consume isOpacity: boolean;
  @Consume isPlay: boolean;
  @Consume isLoading: boolean;
  @Consume isLoadingFinished: boolean;
  @Consume progressVal: number;

  build() {
    Row() {
      Image(this.isPlay ? $r("app.media.simple_video_ic_pause") : $r("app.media.simple_video_ic_play"))
        .width(IMAGE_SIZE)
        .height(IMAGE_SIZE)
        .margin({
          left: MARGIN_FONT_SIZE.FIRST_MARGIN
        })
        .onClick(() => this.iconOnClick());
      Text(this.currentStringTime)
        .fontSize(MARGIN_FONT_SIZE.SECOND_MARGIN)
        .fontColor(Color.White)
        .margin({
          left: MARGIN_FONT_SIZE.FIRST_MARGIN
        })
      Slider({
        style: SliderStyle.OutSet,
        min: 0,
        max: this.durationTime,
        step: 1,
        value: this.currentTime
      })
        .width(STRING_PERCENT.SLIDER_WITH)
        .blockColor($r("app.color.white"))
        .trackColor(Color.Gray)
        .selectedColor($r("app.color.white"))
        .showSteps(true)
        .showTips(true)
        .trackThickness(this.isOpacity ? SMALL_TRACK_THICK_NESS : BIG_TRACK_THICK_NESS)
        .onChange((value: number, mode: SliderChangeMode) => this.sliderOnChange(value, mode))
      Text(this.durationStringTime)
        .fontSize(MARGIN_FONT_SIZE.SECOND_MARGIN)
        .fontColor(Color.White)
        .margin({
          right: MARGIN_FONT_SIZE.FIRST_MARGIN
        })
    }
    .opacity(this.isOpacity ? DEFAULT_OPACITY : 1)
    .width(ALL_PERCENT)
    .alignItems(VerticalAlign.Center)
    .justifyContent(FlexAlign.Center)
  }

  iconOnClick() {
    if (this.isPlay === true) {
      this.isPlay = false;
      this.isOpacity = false;
      this.controller.pause();
      return;
    }
    if (this.isLoadingFinished === true) {
      this.isPlay = true;
      this.isOpacity = true;
      this.controller.start();
    } else {
      this.isLoading = true;
      // 加载资源。
      let intervalLoading = setInterval(() => {
        if (this.progressVal >= STACK_STYLE.PROGRESS_TOTAL) {
          this.progressVal = 0;
        } else {
          this.progressVal += STACK_STYLE.PROGRESS_STEP;
        }
      }, STACK_STYLE.MILLI_SECONDS);
      let intervalFlag = setInterval(() => {
        if (this.isLoadingFinished === true) {
          this.isPlay = true;
          this.isOpacity = true;
          this.isLoading = false;
          this.controller.start();
          clearInterval(intervalFlag);
          clearInterval(intervalLoading);
        }
      }, STACK_STYLE.MILLI_SECONDS);
    }
  }

  sliderOnChange(value: number, mode: SliderChangeMode) {
    this.currentTime = Number.parseInt(String(value));
    this.controller.setCurrentTime(this.currentTime, SeekMode.Accurate);
    switch (mode) {
      case SliderChangeMode.Begin:
      case SliderChangeMode.Moving:
        this.isOpacity = false;
        break;
      case SliderChangeMode.End:
        this.isOpacity = true;
        break;
      default:
        break;
    }
  }
}