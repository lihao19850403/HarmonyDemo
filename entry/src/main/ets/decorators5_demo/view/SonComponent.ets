import { ClassA } from '../model/ClassA';

@Component
export struct SonComponent {
  @ObjectLink sonValue: ClassA;

  build() {
    Column() {
      Text("子组件的ID值：" + this.sonValue.id)
        .fontSize(25)
        .fontWeight(700)
        .fontColor(Color.White)
        .margin({
          top: 20,
          bottom: 20
        })
      Row() {
        Button("+", {
          type: ButtonType.Normal
        })
          .borderRadius(8)
          .backgroundColor(0xFF69B4)
          .width(90)
          .margin({
            right: 40
          })
          .onClick((event: ClickEvent) => this.sonValue.id++)
        Button("reset", {
          type: ButtonType.Normal
        })
          .borderRadius(8)
          .backgroundColor(0xFF69B4)
          .width(90)
          // 直接改变@ObjectLink变量会报错：Error message: Cannot set property when setter is undefined
          // .onClick((event: ClickEvent) => this.sonValue = new ClassA(100))
      }
      .margin({
        bottom: 40
      })
    }
    .width("80%")
    .height("60%")
    .backgroundColor(0x00BFFF)
  }
}