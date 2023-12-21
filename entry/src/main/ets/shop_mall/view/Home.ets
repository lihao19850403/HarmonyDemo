import CommonConstants from '../common/constants/CommonConstants';
import { ItemData } from '../viewmodel/ItemData';
import { swiperImages, firstGridData, secondGridData } from '../viewmodel/MainViewModel';

@Component
export struct Home {
  private swiperController: SwiperController = new SwiperController();

  build() {
    // 设置高度为全屏后即可滚动。
    Scroll() {
      Column({
        space: CommonConstants.COMMON_SPACE
      }) {
        // 标题。
        Row() {
          Text($r('app.string.shop_mall_mainPage_tabTitles_home'))
            .fontWeight(FontWeight.Medium)
            .fontSize($r('app.float.shop_mall_page_title_text_size'))
            .margin({ top: $r('app.float.shop_mall_mainPage_tabTitles_margin') })
            .padding({ left: $r('app.float.shop_mall_mainPage_tabTitles_padding') })
        }
        .width(CommonConstants.FULL_PARENT)
        .justifyContent(FlexAlign.Start)
        // banner。
        Swiper(this.swiperController) {
          ForEach(swiperImages,
            (img:Resource, index?: number) => {
              Image(img)
                .borderRadius($r('app.float.shop_mall_home_swiper_borderRadius'))
            },
            (img:Resource, index?: number) => {
              return JSON.stringify(img);
            })
        }.onChange((index: number) => {
          console.log("banner发生了切换：" + index);
        })
        // 第一个网格视图。
        Grid() {
          ForEach(firstGridData,
            (item: ItemData, index?: number) => {
              GridItem() {
                Column() {
                  Image(item.img)
                    .width($r('app.float.shop_mall_home_homeCell_size'))
                    .height($r('app.float.shop_mall_home_homeCell_size'))
                  Text(item.title)
                    .fontSize($r('app.float.shop_mall_little_text_size'))
                    .fontWeight(FontWeight.Medium)
                    .maxLines(1)
                    .textOverflow({
                      overflow: TextOverflow.Ellipsis
                    })
                    .margin({
                      top: $r('app.float.shop_mall_home_homeCell_margin')
                    })
                }
                .alignItems(HorizontalAlign.Center)
              }
              .width(CommonConstants.FULL_PARENT)
              .height(CommonConstants.FULL_PARENT)
            },
            (item: ItemData, index?: number) => {
              return JSON.stringify(item);
            })
        }
        .columnsTemplate("1fr 1fr 1fr 1fr")
        .rowsTemplate("1fr 1fr")
        .columnsGap($r("app.float.shop_mall_home_grid_columnsGap"))
        .rowsGap($r("app.float.shop_mall_home_grid_rowGap"))
        .padding({
          top: $r('app.float.shop_mall_home_grid_padding'),
          bottom: $r('app.float.shop_mall_home_grid_padding')
        })
        .height($r('app.float.shop_mall_home_grid_height'))
        .backgroundColor(Color.White)
        .borderRadius($r('app.float.shop_mall_home_grid_borderRadius'))
        // 文字提示。
        Text($r('app.string.shop_mall_home_list'))
          .fontSize($r('app.float.shop_mall_normal_text_size'))
          .fontWeight(FontWeight.Medium)
          .width(CommonConstants.FULL_PARENT)
          .margin({
            top: $r('app.float.shop_mall_home_text_margin')
          })
        // 第二个网格视图。
        Grid() {
          ForEach(secondGridData,
            (item: ItemData, index?: number) => {
              GridItem() {
                Column() {
                  Text(item.title)
                    .fontSize($r("app.float.shop_mall_normal_text_size"))
                    .fontWeight(FontWeight.Medium)
                  Text(item.others)
                    .margin({
                      top: $r("app.float.shop_mall_home_list_margin")
                    })
                    .fontSize($r("app.float.shop_mall_little_text_size"))
                    .fontColor($r("app.color.shop_mall_home_grid_fontColor"))
                }
                .alignItems(HorizontalAlign.Start)
              }
              .padding({
                top: $r("app.float.shop_mall_home_list_padding"),
                left: $r("app.float.shop_mall_home_list_padding")
              })
              .borderRadius($r("app.float.shop_mall_home_backgroundImage_borderRadius"))
              .align(Alignment.TopStart)
              .backgroundImage(item.img)
              .backgroundImageSize(ImageSize.Cover)
              .width(CommonConstants.FULL_PARENT)
              .height(CommonConstants.FULL_PARENT)
            },
            (item: ItemData, index?: number) => {
              return JSON.stringify(item);
            })
        }
        .width(CommonConstants.FULL_PARENT)
        .height($r("app.float.shop_mall_home_secondGrid_height"))
        .columnsTemplate("1fr 1fr")
        .rowsTemplate("1fr 1fr")
        .columnsGap($r("app.float.shop_mall_home_grid_columnsGap"))
        .rowsGap($r("app.float.shop_mall_home_grid_rowGap"))
        .margin({
          bottom: $r("app.float.shop_mall_setting_button_bottom")
        })
      }
    }
    .height(CommonConstants.FULL_PARENT)
  }
}