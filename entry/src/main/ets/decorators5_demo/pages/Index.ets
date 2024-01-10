import { ClassA } from '../model/ClassA';
import { ClassB } from '../model/ClassB';
import { SonComponent } from '../view/SonComponent';

@Entry
@Component
struct Index {
  @State fatherValue: ClassB = new ClassB(new ClassA(10));

  build() {
    Column() {
      Text("@Observed与@ObjectLink")
        .fontSize(20)
        .fontWeight(700)
        .fontColor(Color.White)
        .margin({
          top: 5,
          bottom: 10
        })
      Text("父组件的ID值：" + this.fatherValue.a.id)
        .fontSize(30)
        .fontWeight(700)
        .fontColor(Color.White)
        .margin({
          top: 10,
          bottom: 20
        })
      Row({
        space: FlexAlign.SpaceAround
      }) {
        Button("+", {
          type: ButtonType.Normal
        })
          .borderRadius(8)
          .backgroundColor(0xFF1493)
          .width(90)
          .onClick((event: ClickEvent) => this.fatherValue.a.id++)
        Button("重置方式1", {
          type: ButtonType.Normal
        })
          .borderRadius(8)
          .backgroundColor(0xFF1493)
          .width(90)
          // 不论ClassA是否有@Observed修饰器，这里依然会引起页面刷新。
          .onClick((event: ClickEvent) => this.fatherValue.a = new ClassA(20))
        Button("重置方式2", {
          type: ButtonType.Normal
        })
          .borderRadius(8)
          .backgroundColor(0xFF1493)
          .width(90)
          .onClick((event: ClickEvent) => this.fatherValue = new ClassB(new ClassA(30)))
      }
      .margin({
        bottom: 20
      })
      SonComponent({
        sonValue: this.fatherValue.a
      })
    }
    .width("100%")
    .height("100%")
    .backgroundColor(0x1E90FF)
  }
}