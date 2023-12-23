import { ALL_PERCENT, LIST, MARGIN_FONT_SIZE } from '../common/constants/CommonConstants'
import { IndexHeaderSwiper } from '../view/IndexHeaderSwiper'
import { IndexModule } from '../view/IndexModule'

@Entry
@Component
struct SimpleVideoIndex {
  build() {
    Column({
      space: MARGIN_FONT_SIZE.FOURTH_MARGIN
    }) {
      IndexHeaderSwiper()
      List() {
        ForEach(LIST,
          (item: string, index?: number) => {
            ListItem() {
              IndexModule({
                moduleName: item
              })
                .margin({
                  top: MARGIN_FONT_SIZE.FIRST_MARGIN
                })
            }
          },
          (item: string, index?: number) => {
            return JSON.stringify(item) + index;
          });
      }
      .listDirection(Axis.Vertical)
      .margin({
        top:MARGIN_FONT_SIZE.THIRD_MARGIN
      })
    }
    .width(ALL_PERCENT)
    .height(ALL_PERCENT)
    .backgroundColor($r("app.color.simple_video_index_backgroundColor"))
  }
}