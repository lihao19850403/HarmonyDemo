import { ChapterData } from '../model/ChapterData'
import { SectionData } from '../model/SectionData';
import ChapterItem from '../view/ChapterItem';
import Contents from '../viewmodel/Contents'

@Entry
@Component
struct Index {
  // 所有章节信息。
  private contents: SectionData[] = Contents.get();

  @State currentIndex: number = 0;
  @State currentPage: number = 0;

  build() {
    Tabs() {
      ForEach(this.contents,
        (item: SectionData, index?: number) => {
          TabContent() {
            this.ListBuilder(item.chapters)
          }
          .tabBar(this.TabBuilder(index))
        },
        (item: SectionData, index?: number) => {
          return JSON.stringify(item) + index;
        });
    }
    .barWidth("100%")
    .barHeight("7%")
    .barMode(BarMode.Scrollable)
    .vertical(false)
    .backgroundColor($r("app.color.page_background"))
    .onChange((index: number) => {
      this.currentIndex = index;
      this.currentPage = index;
    })
  }

  @Builder TabBuilder(index: number) {
    Column() {
      Text(this.contents[index].name)
        .height("100%")
        .padding({
          left: "2%",
          right: "2%"
        })
        .fontSize(this.currentIndex === index ? 24 : 18)
        .fontWeight(this.currentIndex === index ? 24 : 18)
        .fontColor($r("app.color.blue"))
    }
  }

  @Builder ListBuilder(chapters: ChapterData[]) {
    List({
      space: 16,
    }) {
      ForEach(chapters, (item: ChapterData, index?: number) => {
        ListItem() {
          ChapterItem({
            chapter: item
          })
        }
      }, (item: ChapterData, index?: number) => {
        return JSON.stringify(item) + index;
      })
      ListItem() {
        Row()
          .height("5%")
      }
    }
    .alignListItem(ListItemAlign.Center)
    .width("100%")
    .height("100%")
  }
}