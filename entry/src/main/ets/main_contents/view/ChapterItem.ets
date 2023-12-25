import router from '@ohos.router';
import { ChapterData } from '../model/ChapterData'

@Component
export default struct ChapterItem {
  private chapter: ChapterData;

  build() {
    Row() {
      // 文字提示。
      Text(this.chapter.id + ". " + this.chapter.name)
        .width("100%")
        .fontSize("17fp")
        .fontWeight(400)
        .maxLines(2)
        .textOverflow({
          overflow: TextOverflow.Ellipsis
        })
        .margin({
          left: 20,
          right: 20
        })
    }
    .borderRadius(20)
    .backgroundColor($r("app.color.white"))
    .width("93.3%")
    .height("64vp")
    .onClick(() => {
      router.pushUrl({
        url: this.chapter.url
      })
    })
  }
}