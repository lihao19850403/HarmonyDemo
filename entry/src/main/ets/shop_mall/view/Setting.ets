import router from '@ohos.router';
import CommonConstants from '../common/constants/CommonConstants';
import { ItemData } from '../viewmodel/ItemData';
import { settingListData } from '../viewmodel/MainViewModel';

@Component
export struct Setting {

  build() {
    Scroll() {
      Column({
        space: CommonConstants.COMMON_SPACE
      }) {
        // 标题。
        Row() {
          Text($r("app.string.shop_mall_mainPage_tabTitles_mine"))
            .fontWeight(FontWeight.Medium)
            .fontSize($r("app.float.shop_mall_page_title_text_size"))
            .margin({
              top: $r("app.float.shop_mall_mainPage_tabTitles_margin")
            })
            .padding({
              left: $r("app.float.shop_mall_mainPage_tabTitles_padding")
            })
        }
        .width(CommonConstants.FULL_PARENT)
        .justifyContent(FlexAlign.Start)
        // 用户信息。
        Row() {
          Image($r("app.media.shop_mall_account"))
            .width($r('app.float.shop_mall_setting_account_size'))
            .height($r('app.float.shop_mall_setting_account_size'))
          Column() {
            Text($r('app.string.shop_mall_setting_account_name'))
              .fontSize($r('app.float.shop_mall_setting_account_fontSize'))
            Text($r('app.string.shop_mall_setting_account_email'))
              .fontSize($r('app.float.shop_mall_little_text_size'))
              .margin({
                top: $r('app.float.shop_mall_setting_name_margin')
              })
          }
          .alignItems(HorizontalAlign.Start)
          .margin({
            left: $r("app.float.shop_mall_setting_account_margin")
          })
        }
        .margin({
          top: $r("app.float.shop_mall_setting_account_margin")
        })
        .alignItems(VerticalAlign.Center)
        .width(CommonConstants.FULL_PARENT)
        .height($r("app.float.shop_mall_setting_account_height"))
        .backgroundColor(Color.White)
        .padding({
          left: $r("app.float.shop_mall_setting_account_padding")
        })
        .borderRadius($r("app.float.shop_mall_setting_account_borderRadius"))
        // 功能列表。
        List() {
          ForEach(settingListData,
            (item: ItemData, index?: number) => {
              ListItem() {
                this.SettingCell(item)
              }
              .height($r("app.float.shop_mall_setting_list_height"))
            },
            (item: ItemData, index?: number) => {
              return JSON.stringify(item);
            })
        }
        .backgroundColor(Color.White)
        .width(CommonConstants.FULL_PARENT)
        .height(CommonConstants.SET_LIST_WIDTH)
        .divider({
          color: Color.Grey,
          strokeWidth: $r("app.float.shop_mall_setting_list_strokeWidth"),
          startMargin: $r("app.float.shop_mall_setting_list_startMargin"),
          endMargin: $r("app.float.shop_mall_setting_list_endMargin")
        })
        .borderRadius($r("app.float.shop_mall_setting_list_borderRadius"))
        .padding({
          top: $r("app.float.shop_mall_setting_list_padding"),
          bottom: $r("app.float.shop_mall_setting_list_padding")
        })
        // 占位。
        Blank()
        // 底部按钮。
        Button($r("app.string.shop_mall_setting_button"), {
          type: ButtonType.Capsule
        })
          .width(CommonConstants.FULL_PARENT)
          .height($r("app.float.shop_mall_login_button_height"))
          .fontSize($r("app.float.shop_mall_normal_text_size"))
          .fontColor($r("app.color.shop_mall_setting_button_fontColor"))
          .fontWeight(FontWeight.Medium)
          .backgroundColor($r("app.color.shop_mall_setting_button_backgroundColor"))
          .margin({
            bottom: $r("app.float.shop_mall_setting_button_bottom")
          })
          .onClick(() => {
            // 此处进行页面退出操作，模拟logout。
            router.showAlertBeforeBackPage({
              message: "退出登录？"
            });
            router.back();
          })
      }
      .height(CommonConstants.FULL_PARENT)
    }
  }

  /* 生成设置项。 */
  @Builder SettingCell(item: ItemData) {
    Row() {
      // 左侧图标及提示。
      Row({
        space: CommonConstants.COMMON_SPACE
      }) {
        Image(item.img)
          .width($r("app.float.shop_mall_setting_size"))
          .height($r("app.float.shop_mall_setting_size"))
        Text(item.title)
          .fontSize($r("app.float.shop_mall_normal_text_size"))
      }
      // 右侧图标。
      if (item.others === undefined) { // 这里写null是无效的，符合要求的类型是undefined，或者裸写if条件：!item.others。
        Image($r("app.media.shop_mall_right_grey"))
          .width($r("app.float.shop_mall_setting_jump_width"))
          .height($r("app.float.shop_mall_setting_jump_height"))
      } else {
        Toggle({
          type: ToggleType.Switch,
          isOn: true
        })
      }
    }
    .justifyContent(FlexAlign.SpaceBetween)
    .width(CommonConstants.FULL_PARENT)
    .padding({
      left: $r('app.float.shop_mall_setting_settingCell_left'),
      right: $r('app.float.shop_mall_setting_settingCell_right')
    })
  }
}