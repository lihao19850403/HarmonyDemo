/* 在首页会设置AppStorage.SetOrCreate("PropA", 47); */

let storage = new LocalStorage();
storage.setOrCreate("PropA", 47);

@Styles
function textStyle() {
  .width("80%")
  .height(50)
  .align(Alignment.Center)
  .borderColor(Color.Black)
}

@Entry
@Component
struct Index {
  @StorageLink("PropA") storageLink: number = 1;
  @LocalStorageLink("PropA") localStorageLink: number = 1;

  @StorageProp("PropA") storageProp: number = 10;
  @LocalStorageProp("PropA") localStorageProp: number = 10;

  @StorageLink("aPropA") persistent: number = 9;

  build() {
    Column({
      space: 20
    }) {
      Text("全局存储Link：" + this.storageLink)
        .onClick(() => this.storageLink++)
        .textStyle()
      Text("局部存储（页面级）Link：" + this.localStorageLink)
        .onClick(() => this.localStorageLink++)
        .textStyle()
      Text("全局存储Prop：" + this.storageProp)
        .onClick(() => this.storageProp++)
        .textStyle()
      Text("局部存储（页面级）Prop：" + this.localStorageProp)
        .onClick(() => this.localStorageProp++)
        .textStyle()
      Text("已持久化的全局属性Link：" + this.persistent)
        .onClick(() => this.persistent++)
        .textStyle()
    }
    .width("100%")
    .alignItems(HorizontalAlign.Center)
  }
}