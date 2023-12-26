import { CommonConstants } from '../../common/constants/CommonConstants';
import { MainConstant } from '../../common/constants/MainConstant';
import DimensionUtils from '../../common/utils/DimensionUtils';
import { MainViewModel } from '../../viewmodel/MainViewModel';

@Component
export default struct ClockArea {
  private mainModel: MainViewModel = MainViewModel.getInstance();
  private drawInterval: number = CommonConstants.DEFAULT_NUMBER_NEGATIVE;
  private canvasSize: number = DimensionUtils.getVp($r('app.float.reminder_clock_size'));
  private clockRadius: number = this.canvasSize / CommonConstants.DEFAULT_DOUBLE - CommonConstants.DEFAULT_DOUBLE;
  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private renderContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  @State showClock: boolean = true;

  aboutToDisappear() {
    clearInterval(this.drawInterval);
  }

  build() {
    Canvas(this.renderContext)
      .width(this.canvasSize)
      .aspectRatio(CommonConstants.DEFAULT_LAYOUT_WEIGHT)
      .onReady(() => {
        if (this.drawInterval === CommonConstants.DEFAULT_NUMBER_NEGATIVE) {
          this.startDrawTask();
        }
      })
      .onClick(() => {
        this.showClock = !this.showClock;
      })
  }

  // 启动绘画任务
  private startDrawTask() {
    let that = this;
    that.renderContext.translate(
      this.canvasSize / CommonConstants.DEFAULT_DOUBLE,
      this.canvasSize / CommonConstants.DEFAULT_DOUBLE);
    that.drawClockArea();
    this.drawInterval = setInterval(() => {
      that.drawClockArea();
    }, MainConstant.DEFAULT_ONE_SECOND_MS);
  }

  // 开始绘制时钟区域
  private drawClockArea(): void {
    this.renderContext.clearRect(
      -this.canvasSize,
      -this.canvasSize / CommonConstants.DEFAULT_DOUBLE,
      this.canvasSize * CommonConstants.DEFAULT_DOUBLE,
      this.canvasSize);
    let date = new Date();
    let hours = date.getHours();
    let minutes = date.getMinutes();
    let seconds = date.getSeconds();
    if (this.showClock) {
      this.drawPan();
      let hourInfo = hours;
      if (hours > CommonConstants.DEFAULT_TOTAL_HOUR) {
        hourInfo = hours - CommonConstants.DEFAULT_TOTAL_HOUR;
      }
      let minuteInfo = minutes / CommonConstants.DEFAULT_TOTAL_HOUR * CommonConstants.DEFAULT_COMMON_DEGREE;
      this.drawPointer(CommonConstants.DEFAULT_INTERVAL_MINUTE_MAX * hourInfo + minuteInfo, MainConstant.HOUR_POINTER_IMAGE_URL);
      this.drawPointer(CommonConstants.DEFAULT_COMMON_DEGREE * minutes, MainConstant.MINUTE_POINTER_IMAGE_URL);
      this.drawPointer(CommonConstants.DEFAULT_COMMON_DEGREE * seconds, MainConstant.SECOND_POINTER_IMAGE_URL);
    } else {
      this.drawTime(hours, minutes, seconds);
    }
  }

  // 绘制表盘
  private drawPan(): void {
    this.renderContext.beginPath();
    let secondImg = new ImageBitmap(MainConstant.CLOCK_PAN_IMAGE_URL);
    let imgWidth = this.clockRadius * 2;
    this.renderContext.drawImage(secondImg, -this.clockRadius, -this.clockRadius, imgWidth, imgWidth);
    this.renderContext.restore();
  }

  // 绘制时针、分针、秒针
  private drawPointer(degree: number, pointerImgRes: string) {
    this.renderContext.save();
    let theta = (degree + MainConstant.DEFAULT_HORIZONTAL_ANGLE) * Math.PI / MainConstant.DEFAULT_HORIZONTAL_ANGLE;
    this.renderContext.rotate(theta);
    this.renderContext.beginPath();
    let secondImg = new ImageBitmap(pointerImgRes);
    let imgWidth = CommonConstants.DEFAULT_POINTER_WIDTH;
    this.renderContext.drawImage(
      secondImg,
      -imgWidth / CommonConstants.DEFAULT_DOUBLE,
      -this.clockRadius,
      imgWidth,
      this.clockRadius * CommonConstants.DEFAULT_DOUBLE);
    this.renderContext.restore();
  }

  // 绘制完整时间回显
  private drawTime(hour: number, minute: number, second: number): void {
    let time = this.mainModel.fillZero(hour)
      + MainConstant.DEFAULT_STRING_COLON
      + this.mainModel.fillZero(minute)
      + MainConstant.DEFAULT_STRING_COLON
      + this.mainModel.fillZero(second);
    this.renderContext.save();
    this.renderContext.font = DimensionUtils.getPx($r('app.float.reminder_clock_time_font_size')) + MainConstant.CLOCK_TIME_FONT_SIZE_UNIT;
    this.renderContext.beginPath();
    this.renderContext.textAlign = 'center';
    this.renderContext.fillText(time, 0, 0);
    this.renderContext.restore();
  }
}