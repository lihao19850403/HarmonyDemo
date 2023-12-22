import { CommonConstants } from '../common/constants/CommonConstant'
import getCurrentTime from '../common/utils/DateUtil';
import dataModel, { TaskItemBean } from '../viewmodel/DataModel';
import { ProgressEditPanel } from './ProgressEditPanel';

@Extend(Text)
function opacityTextStyle() {
  .fontSize($r('app.float.target_text_font'))
  .fontColor($r('app.color.target_title_black_color'))
  .opacity(CommonConstants.OPACITY)
  .fontWeight(CommonConstants.FONT_WEIGHT)
}

@Component
export struct TargetListItem {

  /* 列表项的序号。 */
  public index: number = 0;

  /* 任务信息。 */
  private taskItem?: TaskItemBean;

  /* 任务进度信息。 */
  @State latestProgress?: number = 0;

  /* 任务更新时间。 */
  @State updateDate?: string = '';

  /* 是否纵向展开，显示进度控制条？。 */
  @State isExpanded: boolean = false;

  /* 任务侧边显示模式（是否有点击框？）。 */
  @State sliderMode: number = CommonConstants.DEFAULT_SLIDER_MODE;

  /* 选中了哪些任务？用于改变背景色。 */
  @Link selectArr: Array<boolean>;

  /* 监听点击了哪个任务，并传给父组件，收起其他展开的任务。 */
  @Link @Watch('onClickIndexChanged') clickIndex: number;

  /* 是否处于编辑模式。 */
  @Prop isEditMode: boolean;

  /* 消费首页传递过来的状态信息。 */
  @Consume overAllProgressChanged: boolean;

  aboutToAppear() {
    this.latestProgress = this.taskItem?.progressValue;
    this.updateDate = this.taskItem?.updateDate;
  }

  onClickIndexChanged() {
    if (this.index !== this.clickIndex) {
      this.isExpanded = false;
    }
  }

  build() {
    Stack({
      alignContent: Alignment.Start
    }) {
      Column() {
        // 信息头。
        this.TargetItem()
        // 进度编辑区域。
        if (this.isExpanded) {
          Blank()
          ProgressEditPanel({
            sliderMode: $sliderMode,
            slidingProgress: this.latestProgress,
            onCancel: () => {
              this.isExpanded = false;
            },
            onClickOK: (progress: number) => {
              this.isExpanded = false;
              this.latestProgress = progress;
              this.updateDate = getCurrentTime();
              let result = dataModel.updateProgress(this.index, this.latestProgress, this.updateDate);
              if (result) {
                this.overAllProgressChanged = !this.overAllProgressChanged;
              }
            },
          })
            .transition({
              scale: {
                x: CommonConstants.TRANSITION_ANIMATION_X,
                y: CommonConstants.TRANSITION_ANIMATION_Y
              }
            })
        }
      }
      .padding({
        left: $r("app.float.target_list_padding"),
        top: $r("app.float.target_list_padding_top"),
        bottom: $r("app.float.target_list_padding_bottom"),
        right: this.isEditMode ? $r("app.float.target_list_edit_padding") : $r("app.float.target_list_padding")
      })
      .width(CommonConstants.FULL_WIDTH)
      .height(this.isExpanded ? $r("app.float.target_expanded_item_height") : $r("app.float.target_list_item_height"))
      .opacity(this.latestProgress === CommonConstants.SLIDER_MAX_VALUE ? CommonConstants.OPACITY : CommonConstants.NO_OPACITY)
      .borderRadius(CommonConstants.LIST_RADIUS)
      .animation({
        duration: CommonConstants.DURATION
      })
      .backgroundColor(this.selectArr[this.index] ? $r("app.color.target_edit_blue") : Color.White)
      .onClick(() => {
        if (this.sliderMode === CommonConstants.CLICK_SLIDER_MODE) {
          // 普通情况下单击此区域会退出编辑模式。
          this.sliderMode = CommonConstants.DEFAULT_SLIDER_MODE;
          return;
        }
        if (!this.isEditMode) {
          animateTo({
            duration: CommonConstants.DURATION
          }, () => {
            // 进度区域的展开与收回。
            this.isExpanded = !this.isExpanded;
          });
          // 向父组件汇报当前点击的列表序号。
          this.clickIndex = this.index;
        }
      })
      // 右侧编辑区域。
      if (this.isEditMode) {
        Row() {
          Checkbox()
            .select(this.selectArr[this.index])
            .selectedColor($r("app.color.target_main_blue"))
            .width(CommonConstants.CHECKBOX_WIDTH)
            .margin({
              right: $r("app.float.target_list_padding")
            })
            .onChange((isChecked: boolean) => {
              this.selectArr[this.index] = isChecked;
            })
        }
        .width(CommonConstants.FULL_WIDTH)
        .justifyContent(FlexAlign.End)
      }
    }
    .width(CommonConstants.FULL_WIDTH)
  }

  /* 生成任务头信息。 */
  @Builder TargetItem() {
    Row() {
      Text(this.taskItem?.taskName)
        .fontSize($r("app.float.target_list_font"))
        .fontWeight(CommonConstants.FONT_WEIGHT)
        .fontColor($r("app.color.target_title_black_color"))
        .width(CommonConstants.TASK_NAME_WIDTH)
        .textAlign(TextAlign.Start)
        .maxLines(CommonConstants.MAX_LINES)
      Blank()
      Column() {
        Text(this.latestProgress + "%")
          .fontSize($r("app.float.target_list_font"))
          .fontWeight(CommonConstants.FONT_WEIGHT)
          .fontColor($r("app.color.target_title_black_color"))
        Row() {
          Text($r("app.string.target_latest_updateTime"))
            .opacityTextStyle()
          Text(this.updateDate)
            .opacityTextStyle()
        }
        .margin({
          top: $r("app.float.target_text_margin")
        })
      }
      .alignItems(HorizontalAlign.End)
    }
    .width(CommonConstants.FULL_WIDTH)
  }
}