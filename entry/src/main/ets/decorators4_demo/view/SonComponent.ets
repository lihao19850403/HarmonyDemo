import { GrandsonComponent } from './GrandsonComponent';

@Component
export struct SonComponent {
  @Prop @Watch("watchThisValueChange") thisSonValue: number;
  @State @Watch("watchValueChange") sonValue: number = 0;
  @State info: string = "子组件的值：" + this.thisSonValue;

  build() {
    Column() {
      Text(this.info)
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
          .onClick((event: ClickEvent) => this.thisSonValue++)
        Button("-", {
          type: ButtonType.Normal
        })
          .borderRadius(8)
          .backgroundColor(0xFF69B4)
          .width(90)
          .onClick((event: ClickEvent) => this.thisSonValue--)
      }
      .margin({
        bottom: 40
      })
      GrandsonComponent({
        grandsonValue: $sonValue
      })
    }
    .width("80%")
    .height("60%")
    .backgroundColor(0x00BFFF)
  }

  watchThisValueChange() {
    this.info = "子组件的值：" + this.thisSonValue;
    this.sonValue = this.thisSonValue;
  }

  watchValueChange() {
    this.info = "子组件的值：" + this.sonValue;
  }
}