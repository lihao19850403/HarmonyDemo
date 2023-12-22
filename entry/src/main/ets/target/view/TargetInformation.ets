import { CommonConstants } from '../common/constants/CommonConstant'

@Extend(Text)
function opacityTextStyle() {
  .fontSize($r("app.float.target_text_font"))
  .fontWeight(CommonConstants.FONT_WEIGHT)
  .fontColor($r("app.color.target_title_black_color"))
  .opacity(CommonConstants.OPACITY)
}

@Component
export struct TargetInformation {
  @Prop completedTasksNumber: number;
  @Prop totalTasksNumber: number;
  @Prop latestUpdateDate: string;

  build() {
    Column() {
      this.TargetItem()
      this.OverallProgress()
    }
    .width(CommonConstants.MAIN_BOARD_WIDTH)
    .height($r("app.float.target_info_height"))
    .padding($r("app.float.target_padding"))
    .backgroundColor(Color.White)
    .borderRadius(CommonConstants.TARGET_BORDER_RADIUS)
  }

  /* 标题部分。 */
  @Builder TargetItem() {
    Row() {
      Image($r("app.media.target_ic_main"))
        .width($r("app.float.target_image_length"))
        .height($r("app.float.target_image_length"))
        .objectFit(ImageFit.Fill)
        .borderRadius(CommonConstants.IMAGE_BORDER_RADIUS)
      Column() {
        Text($r('app.string.target_name'))
          .fontSize($r('app.float.target_name_font'))
          .fontWeight(CommonConstants.FONT_WEIGHT_LARGE)
          .width(CommonConstants.TITLE_WIDTH)
        Text($r('app.string.target_info'))
          .opacityTextStyle()
          .fontSize($r('app.float.target_desc_font'))
          .margin({ top: $r('app.float.target_title_margin') })
      }
      .margin({
        left: CommonConstants.TARGET_MARGIN_LEFT
      })
      .alignItems(HorizontalAlign.Start)
    }
    .width(CommonConstants.FULL_WIDTH)
  }

  /* 任务统计。 */
  @Builder OverallProgress() {
    Row() {
      // 提示与更新时间。
      Column() {
        Text($r('app.string.target_overall_progress'))
          .fontSize($r('app.float.target_button_font'))
          .fontWeight(CommonConstants.FONT_WEIGHT)
          .fontColor($r('app.color.target_title_black_color'))
        Row() {
          Text($r('app.string.target_latest_updateTime'))
            .opacityTextStyle()
          Text(this.latestUpdateDate)
            .opacityTextStyle()
        }
        .margin({
          top: $r('app.float.target_text_margin')
        })
      }
      .alignItems(HorizontalAlign.Start)
      Blank()
      // 进度指示器。
      Stack() { // 使用了层叠布局。
        // 任务完成情况，使用分数表示。
        Row() {
          Text(String(this.completedTasksNumber))
            .fontSize($r('app.float.target_progress_font'))
            .fontWeight(CommonConstants.FONT_WEIGHT)
            .fontColor($r('app.color.target_main_blue'))
          Text(String("/" + this.totalTasksNumber))
            .fontSize($r('app.float.target_progress_font'))
            .fontWeight(CommonConstants.FONT_WEIGHT)
        }
        // 环形进度条。
        Progress({
          type: ProgressType.Ring,
          total: this.totalTasksNumber,
          value: this.completedTasksNumber
        })
          .width($r('app.float.target_progress_length'))
          .height($r('app.float.target_progress_length'))
          .color($r("app.color.target_main_blue"))
          .borderColor($r("app.color.target_main_red"))
          .style({
            strokeWidth: CommonConstants.STROKE_WIDTH
          })
      }
    }
    .width(CommonConstants.FULL_WIDTH)
    .height($r("app.float.target_progress_length"))
    .margin({
      top: $r("app.float.target_progress_margin_top")
    })
  }
}