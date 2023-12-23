import prompt from '@ohos.promptAction';
import { ALL_PERCENT, COMMON_NUM_DURATION, MESSAGE, START_TIME, STRING_PERCENT } from '../common/constants/CommonConstants';
import { changeSliderTime } from '../common/utils/VideoControll';
import { VideoPlayerSlider } from './VideoPlayerSlider';

/* 视频播放器。 */
@Component
export struct VideoPlayer {
  private source: string | Resource = "";
  private controller: VideoController = new VideoController();
  private previewUris: Resource = $r("app.media.simple_video_preview");

  @Provide currentStringTime: string = START_TIME;
  @Provide currentTime: number = 0;
  @Provide durationStringTime: string = START_TIME;
  @Provide durationTime: number = 0;
  @Consume isOpacity: boolean;
  @Consume isPlay: boolean;
  @Consume isLoading: boolean;
  @Consume isLoadingFinished: boolean;
  @Consume progressVal: number;

  build() {
    Column() {
      Video({
        src: this.source,
        previewUri: this.previewUris,
        controller: this.controller
      })
        .width(ALL_PERCENT)
        .height(STRING_PERCENT.NINETY_PERCENT)
        .controls(false)
        .autoPlay(false)
        .objectFit(ImageFit.Contain)
        .loop(false)
        .onUpdate((event) => {
          if (event) {
            this.currentTime = event.time;
            this.currentStringTime = changeSliderTime(this.currentTime);
          }
        })
        .onPrepared((event) => this.prepared(event?.duration))
        .onFinish(() => this.finish())
        .onError(() => {
          prompt.showToast({
            message: MESSAGE,
            duration: COMMON_NUM_DURATION
          })
        })
      VideoPlayerSlider({
        controller: this.controller
      })
    }
  }

  prepared(duration: number) {
    this.durationTime = duration;
    this.durationStringTime = changeSliderTime(this.durationTime);
    this.isLoadingFinished = true;
  }

  finish() {
    this.isPlay = false;
    this.isOpacity = false;
  }
}