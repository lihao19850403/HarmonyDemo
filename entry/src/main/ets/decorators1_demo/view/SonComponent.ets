import { GrandsonComponent } from './GrandsonComponent';

@Component
export struct SonComponent {
  @Prop sonValue: number;

  build() {
    Column() {
      Text("子组件的值：" + this.sonValue)
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
          .onClick((event: ClickEvent) => this.sonValue++)
        Button("-", {
          type: ButtonType.Normal
        })
          .borderRadius(8)
          .backgroundColor(0xFF69B4)
          .width(90)
          .onClick((event: ClickEvent) => this.sonValue--)
      }
      .margin({
        bottom: 40
      })
      GrandsonComponent({
        grandsonValue: this.sonValue
      })
    }
    .width("80%")
    .height("60%")
    .backgroundColor(0x00BFFF)
  }
}