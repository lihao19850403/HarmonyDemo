import { SonComponent } from '../view/SonComponent';

@Entry
@Component
struct Index {
  @Provide("reviewVote") fatherValue: number = 0;

  build() {
    Column() {
      Text("@Provide与@Consume")
        .fontSize(20)
        .fontWeight(700)
        .fontColor(Color.White)
        .margin({
          top: 5,
          bottom: 10
        })
      Text("父组件的值：" + this.fatherValue)
        .fontSize(30)
        .fontWeight(700)
        .fontColor(Color.White)
        .margin({
          top: 10,
          bottom: 20
        })
      Row() {
        Button("+", {
          type: ButtonType.Normal
        })
          .borderRadius(8)
          .backgroundColor(0xFF1493)
          .width(90)
          .margin({
            right: 40
          })
          .onClick((event: ClickEvent) => this.fatherValue++)
        Button("-", {
          type: ButtonType.Normal
        })
          .borderRadius(8)
          .backgroundColor(0xFF1493)
          .width(90)
          .onClick((event: ClickEvent) => this.fatherValue--)
      }
      .margin({
        bottom: 30
      })
      SonComponent()
    }
    .width("100%")
    .height("100%")
    .backgroundColor(0x1E90FF)
  }
}