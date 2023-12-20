import CommonConstants from '../common/constants/CommonConstant';
import TodoListItem from '../view/TodoListItem';
import DataModel from '../viewmodel/DataModel';

@Entry
@Component
struct TodoListPage {
  private totalTasks: Array<string> = [];

  aboutToAppear() {
    this.totalTasks = DataModel.getData();
  }

  build() {
    Column({
      space: CommonConstants.COLUMN_SPACE
    }) {
      // 标题。
      Text($r("app.string.todo_list_page_title"))
        .fontSize($r("app.float.todo_list_title_font_size"))
        .fontWeight(FontWeight.Bold)
        .lineHeight($r("app.float.todo_list_title_font_height"))
        .width(CommonConstants.TITLE_WIDTH)
        .margin({
          top: $r("app.float.todo_list_title_margin_top"),
          bottom: $r("app.float.todo_list_title_margin_bottom")
        })
        .textAlign(TextAlign.Start)
      // 待办事项列表。
      ForEach(this.totalTasks, (item: string, index?: number) => {
        TodoListItem({
          content: item
        })
      }, (item: string, index?: number) => {
        return JSON.stringify(item);
      })
    }
    .width(CommonConstants.FULL_LENGTH)
    .height(CommonConstants.FULL_LENGTH)
    .backgroundColor($r("app.color.todo_list_page_background"))
  }
}