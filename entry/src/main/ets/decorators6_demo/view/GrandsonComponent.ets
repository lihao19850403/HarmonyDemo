@Component
export struct GrandsonComponent {
  @Consume("reviewVote") grandsonValue: number;

  build() {
    Column() {
      Text("孙组件的值：" + this.grandsonValue)
        .fontSize(20)
        .fontWeight(700)
        .fontColor(Color.White)
        .margin({
          top: 40,
          bottom: 40
        })
      Row() {
        Button("+", {
          type: ButtonType.Normal
        })
          .borderRadius(8)
          .backgroundColor(0xFFC0CB)
          .width(90)
          .margin({
            right: 30
          })
          .onClick((event: ClickEvent) => this.grandsonValue++)
        Button("-", {
          type: ButtonType.Normal
        })
          .borderRadius(8)
          .backgroundColor(0xFFC0CB)
          .width(90)
          .onClick((event: ClickEvent) => this.grandsonValue--)
      }
    }
    .width("80%")
    .height("45%")
    .backgroundColor(0x87CEFA)
  }
}