import { MyDataSource } from '../viewmodel/MyDataSource'

@Entry
@Component
struct Index {
  private data: MyDataSource = new MyDataSource();

  build() {
    List({
      space: 25,
    }) {
      LazyForEach(this.data,
        (item: string, index?: number) => {
          ListItem() {
            Text(item)
              .width("80%")
              .height(50)
              .backgroundColor(Color.Green)
              .fontColor(Color.White)
              .textAlign(TextAlign.Center)
              .fontSize(16)
              .margin({
                left: "10%"
              })
          }
          .onClick(() => {
            const timeInfo = new Date().toString();
            this.data.pushData(String("新加入的项目：" + timeInfo));
          })
        },
        (item: string, index?: number) => {
          return JSON.stringify(item) + index;
        })
    }
    .width("100%")
    .height("100%")
  }
}