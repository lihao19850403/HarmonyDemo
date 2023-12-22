import promptAction from '@ohos.promptAction';
import { CommonConstants } from '../common/constants/CommonConstant';
import getCurrentTime from '../common/utils/DateUtil';
import { AddTargetDialog } from '../view/AddTargetDialog';
import { TargetInformation } from '../view/TargetInformation';
import { TargetList } from '../view/TargetList';
import dataModel, { TaskItemBean } from '../viewmodel/DataModel';

@Entry
@Component
struct MainPage {
  dialogController: CustomDialogController = new CustomDialogController({
    builder: AddTargetDialog({
      onClickOK: (subTaskName: string) => {
        this.saveTask(subTaskName);
      }
    }),
    alignment: DialogAlignment.Center,
    // offset: {
    //   dx: CommonConstants.DIALOG_OFFSET_X,
    //   dy: $r("app.float.target_dialog_offset_y")
    // },
    customStyle: true,
    autoCancel: false
  });

  /* 当前所有任务信息。 */
  @State targetData: Array<TaskItemBean> = dataModel.getData();
  @State completedTasksNumber: number = 0;
  @State totalTasksNumber: number = 0;
  @State latestUpdateDate: string = CommonConstants.DEFAULT_PROGRESS_VALUE;
  @Provide @Watch("onProgressChanged") overAllProgressChanged: boolean = false;

  build() {
    Column() {
      Text($r('app.string.target_title'))
        .width(CommonConstants.TITLE_WIDTH)
        .height($r('app.float.target_title_height'))
        .fontSize($r('app.float.target_title_font'))
        .fontWeight(CommonConstants.FONT_WEIGHT_LARGE)
        .textAlign(TextAlign.Start)
        .margin({
          top: $r('app.float.target_title_margin'),
          bottom: $r('app.float.target_title_margin')
        })
      TargetInformation({
        latestUpdateDate: this.latestUpdateDate,
        completedTasksNumber: this.completedTasksNumber,
        totalTasksNumber: this.totalTasksNumber
      })
      TargetList({
        targetData: $targetData,
        onAddClick: () => {
          this.dialogController.open();
        }
      })
        .height(CommonConstants.LIST_BOARD_HEIGHT)
    }
    .width(CommonConstants.FULL_WIDTH)
    .height(CommonConstants.FULL_HEIGHT)
    .backgroundColor($r("app.color.target_index_background"))
  }

  saveTask(subTaskName: string) {
    if (subTaskName === "") {
      promptAction.showToast({
        message: $r("app.string.target_cannot_input_empty"),
        duration: CommonConstants.TOAST_TIME,
        bottom: CommonConstants.TOAST_MARGIN_BOTTOM
      });
      return;
    }
    dataModel.addData(new TaskItemBean(subTaskName, getCurrentTime(), 0));
    this.targetData = dataModel.getData();
    this.overAllProgressChanged = !this.overAllProgressChanged;
    this.dialogController.close();
  }

  onProgressChanged() {
    this.totalTasksNumber = this.targetData.length;
    this.completedTasksNumber = this.targetData.filter((item: TaskItemBean) => {
      return item.progressValue === CommonConstants.SLIDER_MAX_VALUE;
    }).length;
    this.latestUpdateDate = getCurrentTime();
  }
}