import { SonComponent } from '../view/SonComponent';

@Entry
@Component
struct Index {
  @State thisFatherValue: number = 0;

  build() {
    Column() {
      Text("复杂的单双向绑定")
        .fontSize(20)
        .fontWeight(700)
        .fontColor(Color.White)
        .margin({
          top: 5,
          bottom: 10
        })
      Text("父组件的值：" + this.thisFatherValue)
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
          .onClick((event: ClickEvent) => {
            this.thisFatherValue++;
          })
        Button("-", {
          type: ButtonType.Normal
        })
          .borderRadius(8)
          .backgroundColor(0xFF1493)
          .width(90)
          .onClick((event: ClickEvent) => {
            this.thisFatherValue--;
          })
      }
      .margin({
        bottom: 30
      })
      SonComponent({
        thisSonValue: this.thisFatherValue,
      })
        .margin({
          bottom: 20
        })
      Text("只能在子组件中使用额外的@State，并配合@Watch来实现这样的状态传递")
        .fontSize(20)
        .fontWeight(700)
        .fontColor(Color.White)
    }
    .width("100%")
    .height("100%")
    .backgroundColor(0x1E90FF)
  }
}