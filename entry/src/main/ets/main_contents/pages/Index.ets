import { ChapterData } from '../model/ChapterData'
import ChapterItem from '../view/ChapterItem';
import Contents from '../viewmodel/Contents'

@Entry
@Component
struct Index {
  // 所有章节信息。
  private contents: ChapterData[] = Contents.get();

  build() {
    List({
      space: 16,
    }) {
      ListItem() {
        // 标题。
        Text("目录")
          .fontSize("28fp")
          .fontWeight(FontWeight.Bold)
          .lineHeight("33vp")
          .width("80%")
          .margin({
            top: "24vp",
            bottom: "12vp"
          })
          .textAlign(TextAlign.Start)
      }
      // 目录。
      ForEach(this.contents, (item: ChapterData, index?: number) => {
        ListItem() {
          ChapterItem({
            chapter: item
          })
        }
      }, (item: ChapterData, index?: number) => {
        return JSON.stringify(item.id);
      })
    }
    .alignListItem(ListItemAlign.Center)
    .width("100%")
    .height("100%")
    .backgroundColor($r("app.color.page_background"))
  }
}