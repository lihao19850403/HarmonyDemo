@Entry
@Component
struct Index {
  @State message: string = 'Hello World'

  build() {
    Row() {
      Column() {
        Text(this.message)
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
        Button("测试")
          .onClick(() => test())
      }
      .width('100%')
    }
    .height('100%')
  }
}

function test(): void {
  console.log("测试函数输出");
}