import { CommonConstants } from '../common/constants/CommonConstants';
import lottie, { AnimationItem } from "@ohos/lottie";

@Component
export struct Outer {
  private renderingSettings: RenderingContextSettings = new RenderingContextSettings(true);
  private renderingContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.renderingSettings);
  private animateName: string = CommonConstants.ANIMATE_NAME;
  private animateItem: AnimationItem | null = null;

  @State canvasTitle: Resource | undefined = undefined;

  onPageShow(): void {
    lottie.play();
  }

  onPageHide(): void {
    lottie.pause();
  }

  aboutToDisappear(): void {
    lottie.destroy();
  }

  build() {
    Flex({
      direction: FlexDirection.Column,
      justifyContent: FlexAlign.SpaceBetween
    }) {
      // Canvas area
      Column() {
        Canvas(this.renderingContext)
          .width(CommonConstants.CONTAINER_WIDTH)
          .aspectRatio(CommonConstants.ASPECT_RATIO_176)
          .backgroundImage($r('app.media.emoji_canvas_bg'))
          .backgroundImageSize(ImageSize.Cover)
          .onDisAppear(() => {
            lottie.destroy(this.animateName);
          })
        Text(this.canvasTitle)
          .width(CommonConstants.CONTAINER_WIDTH)
          .fontSize($r('app.float.emoji_fontSize_14'))
          .textAlign(TextAlign.Center)
          .fontWeight(FontWeight.Bold)
          .fontColor($r('app.color.emoji_outer_canvas_title'))
          .margin({
            top: $r('app.float.emoji_default_12')
          })
          .opacity(CommonConstants.OPACITY_4)
      }
      .margin({
        top: $r('app.float.emoji_default_10'),
        left: $r('app.float.emoji_default_10'),
        right: $r('app.float.emoji_default_10')
      })

      // Buttons area
      Column({
        space: CommonConstants.SPACE_12
      }) {
        Button() {
          Text($r('app.string.emoji_outer_button_load'))
            .fontSize($r('app.float.emoji_fontSize_16'))
            .fontColor($r('app.color.emoji_outer_button_font'))
            .fontWeight(FontWeight.Bold)
        }
        .width(CommonConstants.CONTAINER_WIDTH)
        .height($r('app.float.emoji_default_40'))
        .backgroundColor($r('app.color.emoji_outer_button_bg'))
        .onClick(() => {
          if (this.animateItem !== null) {
            this.animateItem.destroy();
            this.animateItem = null;
          }
          this.canvasTitle = $r('app.string.emoji_outer_button_load');
          this.animateItem = lottie.loadAnimation({
            container: this.renderingContext,
            renderer: 'canvas',
            loop: 10,
            autoplay: true,
            name: this.animateName,
            path: 'emoji_demo/common/lottie/data.json'
          });
        })

        Button() {
          Text($r('app.string.emoji_outer_button_end'))
            .fontSize($r('app.float.emoji_fontSize_16'))
            .fontColor($r('app.color.emoji_outer_button_font'))
            .fontWeight(FontWeight.Bold)
        }
        .width(CommonConstants.CONTAINER_WIDTH)
        .height($r('app.float.emoji_default_40'))
        .backgroundColor($r('app.color.emoji_outer_button_bg'))
        .onClick(() => {
          if (this.animateItem === null) return;
          this.canvasTitle = $r('app.string.emoji_outer_button_end');
          this.animateItem.goToAndPlay(CommonConstants.ZERO_FRAME, true);
        })

        Flex({
          justifyContent: FlexAlign.SpaceBetween
        }) {
          Button() {
            Text($r('app.string.emoji_outer_button_start'))
              .fontSize($r('app.float.emoji_fontSize_16'))
              .fontColor($r('app.color.emoji_outer_button_font'))
              .fontWeight(FontWeight.Bold)
          }
          .width(CommonConstants.CONTAINER_HALF_WIDTH)
          .height($r('app.float.emoji_default_40'))
          .backgroundColor($r('app.color.emoji_outer_button_bg'))
          .onClick(() => {
            if (this.animateItem === null) return;
            this.canvasTitle = $r('app.string.emoji_outer_button_start');
            lottie.play();
          })

          Button() {
            Text($r('app.string.emoji_outer_button_pause'))
              .fontSize($r('app.float.emoji_fontSize_16'))
              .fontColor($r('app.color.emoji_outer_button_font'))
              .fontWeight(FontWeight.Bold)
          }
          .width(CommonConstants.CONTAINER_HALF_WIDTH)
          .height($r('app.float.emoji_default_40'))
          .backgroundColor($r('app.color.emoji_outer_button_bg'))
          .onClick(() => {
            if (this.animateItem === null) return;
            this.canvasTitle = $r('app.string.emoji_outer_button_pause');
            lottie.pause();
          })
        }
      }
      .padding({
        left: $r('app.float.emoji_default_23'),
        right: $r('app.float.emoji_default_23'),
        bottom: $r('app.float.emoji_default_41')
      })
    }
    .height(CommonConstants.CONTAINER_HEIGHT)
  }
}