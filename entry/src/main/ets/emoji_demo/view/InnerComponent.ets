import { CommonConstants } from '../common/constants/CommonConstants';
import { ButtonList } from '../model/ButtonList';
import InnerViewModel from "../viewmodel/InnerViewModel";
import { Buttons } from "@ohos/library";

@Component
export struct Inner {
  scroller: Scroller = new Scroller();
  @State buttonList: ButtonList[] = InnerViewModel.getButtonListData();

  build() {
    Scroll(this.scroller) {
      Column({
        space: CommonConstants.SPACE_12
      }) {
        ForEach(this.buttonList,
          (item: ButtonList, index?: number) => {
            Column() {
              Flex({
                direction: FlexDirection.Column,
                justifyContent: FlexAlign.SpaceBetween,
                alignItems: ItemAlign.Start
              }) {
                Column() {
                  Text(item.title)
                    .height($r('app.float.emoji_default_21'))
                    .fontSize($r('app.float.emoji_fontSize_16'))
                    .fontColor($r('app.color.emoji_common_color'))
                    .fontWeight(FontWeight.Bold)
                  Text(item.subtitle)
                    .height($r('app.float.emoji_default_16'))
                    .fontSize($r('app.float.emoji_fontSize_12'))
                    .fontColor($r('app.color.emoji_common_color'))
                    .fontWeight(CommonConstants.FONT_WEIGHT_400)
                    .margin({
                      top: $r('app.float.emoji_default_24')
                    })
                    .opacity(CommonConstants.OPACITY_6)
                }
                .alignItems(HorizontalAlign.Start)
                Column() {
                  Buttons({
                    buttonText: item.buttonText!,
                    buttonShape: item.buttonShape!,
                    buttonType: item.buttonType!,
                    stateEffect: item.stateEffect!,
                    fontColor: item.fontColor!
                  })
                    .alignSelf(ItemAlign.Center)
                    .margin({
                      bottom: $r('app.float.emoji_default_21')
                    })
                }
                .width($r('app.float.emoji_default_260'))
                .height($r('app.float.emoji_default_90'))
                .backgroundImage($r('app.media.emoji_mobile'))
                .backgroundImageSize(ImageSize.Contain)
                .justifyContent(FlexAlign.End)
                .alignSelf(ItemAlign.Center)
                .align(Alignment.End)
              }
              .padding({
                bottom: $r('app.float.emoji_default_24')
              })
              .width(CommonConstants.CONTAINER_WIDTH)
              .height(CommonConstants.CONTAINER_HEIGHT)
            }
            .width(CommonConstants.CONTAINER_WIDTH)
            .aspectRatio(CommonConstants.ASPECT_RATIO_176)
            .padding({
              top: $r('app.float.emoji_default_12'),
              left: $r('app.float.emoji_default_8')
            })
            .backgroundColor($r('app.color.white'))
            .borderRadius($r('app.float.emoji_default_24'))
          },
          (item: ButtonList, index?: number) => {
            return JSON.stringify(item) + index;
          })
      }
      .width(CommonConstants.CONTAINER_WIDTH)
      .padding({
        left: $r('app.float.emoji_default_12'),
        right: $r('app.float.emoji_default_12'),
        top: $r('app.float.emoji_default_12')
      })
    }
    .scrollable(ScrollDirection.Vertical)
    .scrollBar(BarState.Off)
    .margin({
      bottom: $r('app.float.emoji_default_24')
    })
  }
}