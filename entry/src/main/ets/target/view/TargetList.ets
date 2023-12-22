import { CommonConstants } from '../common/constants/CommonConstant'
import dataModel, { TaskItemBean } from '../viewmodel/DataModel';
import { TargetListItem } from './TargetListItem';

@Extend(Text)
function operateTextStyle(color: Resource) {
  .fontSize($r('app.float.target_text_button_font'))
  .fontWeight(CommonConstants.FONT_WEIGHT)
  .fontColor(color)
  .lineHeight($r('app.float.target_text_line_height'))
}

@Extend(Button)
function operateButtonStyle(color: Resource) {
  .width($r('app.float.target_button_width'))
  .height($r('app.float.target_button_height'))
  .fontSize($r('app.float.target_button_font'))
  .fontWeight(CommonConstants.FONT_WEIGHT)
  .fontColor(color)
  .backgroundColor($r('app.color.target_button_background'))
}

@Component
export struct TargetList {

  /* 新增任务事件。 */
  onAddClick?: () => void;

  /* 是否处于编辑模式。。 */
  @State isEditMode: boolean = false;

  /* 哪些任务被选中。 */
  @State selectArray: Array<boolean> = [];

  /* 当前点击了哪个任务。。 */
  @State clickIndex: number = CommonConstants.DEFAULT_CLICK_INDEX;

  /* 全选标记。 */
  @State selectAll: boolean = false;

  /* 所有任务列表。 */
  @Link targetData: Array<TaskItemBean>;

  /* /* 消费首页传递过来的状态信息。 */
  @Consume overAllProgressChanged: boolean;

  build() {
    Column() {
      // 列表标题。
      Row() {
        Text($r("app.string.target_sub_goals"))
          .fontSize($r("app.float.target_secondary_title"))
          .fontWeight(CommonConstants.FONT_WEIGHT_LARGE)
          .fontColor($r("app.color.target_title_black_color"))
        Blank()
        if (this.targetData.length > 0) {
          if (this.isEditMode) {
            Text($r("app.string.target_cancel_button"))
              .operateTextStyle($r("app.color.target_main_blue"))
              .margin({
                left: $r("app.float.target_operate_button_margin")
              })
              .onClick(() => {
                this.selectAll = false;
                this.isEditMode = false;
                this.selectAllOrCancel(false);
              })
            Text($r("app.string.target_select_all_button"))
              .operateTextStyle($r("app.color.target_main_blue"))
              .margin({
                left: $r("app.float.target_operate_button_margin")
              })
            Checkbox()
              .select(this.isSelectAll())
              .selectedColor($r("app.color.target_main_blue"))
              .width(CommonConstants.CHECKBOX_WIDTH)
              .onClick(() => {
                this.selectAll = !this.selectAll;
                this.selectAllOrCancel(this.selectAll);
              })
          } else {
            Text($r("app.string.target_edit_button"))
              .operateTextStyle($r("app.color.target_main_blue"))
              .onClick(() => {
                this.isEditMode = true;
                this.selectAllOrCancel(false);
              })
          }
        }
      }
      .width(CommonConstants.FULL_WIDTH)
      .height($r("app.float.target_history_line_height"))
      .padding({
        left: $r("app.float.target_list_padding"),
        right: $r("app.float.target_list_padding_right")
      })
      // 任务列表内容。
      List({
        space: CommonConstants.LIST_SPACE
      }) {
        ForEach(this.targetData,
          (item: TaskItemBean, index?: number | undefined) => {
            ListItem() {
              TargetListItem({
                index: index,
                taskItem: item,
                selectArr: $selectArray,
                isEditMode: this.isEditMode,
                clickIndex: $clickIndex
              })
            }
          },
          (item: TaskItemBean, index?: number | undefined) => {
            // 此处混入index做为组件key的一部分，以便删除任务的时候触发列表的更新（主要是重新分配index）。
            return JSON.stringify(item) + index;
          })
      }
      .width(CommonConstants.FULL_WIDTH)
      .height(CommonConstants.LIST_HEIGHT)
      .edgeEffect(EdgeEffect.None)
      .margin({
        top:$r("app.float.target_list_margin_top")
      })
      Blank()
      // 底部控制按钮。
      if (this.isEditMode) {
        Button($r("app.string.target_delete_button"))
          .opacity(this.isSelectRows() ? CommonConstants.NO_OPACITY : CommonConstants.OPACITY)
          .enabled(this.isSelectRows())
          .operateButtonStyle($r("app.color.target_main_red"))
          .onClick(() => {
            this.deleteSelected();
            this.selectAllOrCancel(false);
            this.selectAll = false;
          })
      } else {
        Button($r("app.string.target_add_task"))
          .operateButtonStyle($r("app.color.target_main_blue"))
          .onClick(() => {
            if (this.onAddClick) {
              this.onAddClick();
            }
          })
      }
    }
    .width(CommonConstants.MAIN_BOARD_WIDTH)
    .height(CommonConstants.FULL_HEIGHT)
    .padding({
      top: $r("app.float.target_operate_row_margin")
    })
  }

  /* 删除选中的任务。 */
  deleteSelected() {
    dataModel.deleteData(this.selectArray);
    this.targetData = dataModel.getData();
    this.overAllProgressChanged = !this.overAllProgressChanged;
    this.isEditMode = false; // 退出编辑模式。
  }

  /* 全选或者取消全选。 */
  selectAllOrCancel(selectStatus: boolean) {
    let newSelectedArray: boolean[] = [];
    for (var i = 0; i < this.targetData.length; i++) {
      newSelectedArray.push(selectStatus);
    }
    this.selectArray = newSelectedArray;
  }

  /* 判断是否全选。 */
  isSelectAll(): boolean {
    if (!this.selectArray || this.selectArray.length === 0) {
      return false;
    }
    let unselectedArr = this.selectArray.filter((isSelected: boolean) => {
      return isSelected === false;
    });
    if (!unselectedArr || unselectedArr.length === 0) {
      this.selectAll = true;
      return true;
    }
    this.selectAll = false;
    return false;
  }

  /* 判断是否至少选中了某些行。 */
  isSelectRows(): boolean {
    if (!this.selectArray || this.selectArray.length === 0) {
      return false;
    }
    return this.selectArray.filter((isSelected: boolean) => {
      return isSelected === true;
    }).length !== 0;
  }
}