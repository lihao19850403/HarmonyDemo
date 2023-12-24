import CommonConstants from '../common/constants/CommonConstants';
import CommonUtils from '../common/utils/CommonUtils';
import HobbyItem from '../model/HobbyItem';
import Prompt from '@ohos.promptAction';

@Extend(Button)
function dialogButtonStyle() {
  .width(CommonConstants.FULL_WIDTH)
  .height($r('app.float.target_button_height'))
  .fontSize($r('app.float.multi_dialogs_button_text_size'))
  .fontColor($r('app.color.multi_dialogs_custom_button_color'))
  .layoutWeight(CommonConstants.WEIGHT_ONE)
  .backgroundColor(Color.White)
}

/* 自定义的对话框。 */
@CustomDialog
export struct CustomDialogWidget {
  private controller?: CustomDialogController;

  @State hobbyItems: HobbyItem[] = [];
  @Link hobbies: string;

  aboutToAppear() {
    let context: Context = getContext(this);
    if (CommonUtils.isEmptyObj(context) || CommonUtils.isEmptyObj(context.resourceManager)) {
      return;
    }
    let manager = context.resourceManager;
    manager.getStringArrayValue($r("app.strarray.multi_dialogs_hobbies_data").id,
      (error, hobbyArray) => {
        if (!CommonUtils.isEmptyObj(error)) {
          Prompt.showToast({
            message: JSON.stringify(error),
            duration: 1000
          });
        } else {
          hobbyArray.forEach((hobby: string) => {
            let hobbyItem = new HobbyItem();
            hobbyItem.label = hobby;
            hobbyItem.isChecked = false;
            this.hobbyItems.push(hobbyItem);
          });
        }
      });
  }

  build() {
    Column() {
      // 标题。
      Text($r('app.string.multi_dialogs_text_title_hobbies'))
        .fontSize($r('app.float.multi_dialogs_title_hobbies_size'))
        .fontWeight(CommonConstants.BIGGER)
        .fontColor($r('app.color.multi_dialogs_custom_color'))
        .lineHeight($r('app.float.multi_dialogs_title_line_height'))
        .alignSelf(ItemAlign.Start)
        .margin({
          left: $r('app.float.multi_dialogs_title_left_distance')
        })
      // 列表项。
      List() {
        ForEach(this.hobbyItems,
          (item: HobbyItem, index?: number) => {
            ListItem() {
              Row() {
                Text(item.label)
                  .fontSize($r('app.float.multi_dialogs_label_size'))
                  .fontWeight(CommonConstants.BIGGER)
                  .fontColor($r('app.color.multi_dialogs_custom_color'))
                  .layoutWeight(CommonConstants.WEIGHT_ONE)
                  .textAlign(TextAlign.Start)
                  .margin({
                    left: $r('app.float.multi_dialogs_label_left_distance')
                  })
                Toggle({
                  type: ToggleType.Checkbox,
                  isOn: false
                })
                  .width($r("app.float.multi_dialogs_toggle_size"))
                  .height($r("app.float.multi_dialogs_toggle_size"))
                  .margin({
                    right: $r("app.float.multi_dialogs_toggle_right_distance")
                  })
                  .onChange((isCheck) => item.isChecked = isCheck)
              }
              .height($r("app.float.multi_dialogs_options_height"))
              .margin({
                top: $r("app.float.multi_dialogs_options_top_distance"),
                bottom: $r("app.float.multi_dialogs_options_bottom_distance")
              })
            }
          },
          (item: HobbyItem, index?: number) => {
            return JSON.stringify(item) + index;
          })
      }
      .width(CommonConstants.FULL_WIDTH)
      .height($r("app.float.multi_dialogs_options_list_height"))
      .margin({
        top: $r("app.float.multi_dialogs_list_top_distance"),
        bottom: $r("app.float.multi_dialogs_list_bottom_distance")
      })
      .divider({
        strokeWidth: $r("app.float.multi_dialogs_divider_height"),
        color: $r("app.color.multi_dialogs_divider_color")
      })
      .listDirection(Axis.Vertical)
      .edgeEffect(EdgeEffect.None)
      // 确认操作区域。
      Row() {
        Button($r("app.string.multi_dialogs_cancel_button"))
          .dialogButtonStyle()
          .onClick(() => this.controller.close())
        Blank()
          .width($r('app.float.multi_dialogs_blank_width'))
          .height($r('app.float.multi_dialogs_blank_height'))
          .opacity($r('app.float.multi_dialogs_blank_opacity'))
          .backgroundColor($r('app.color.multi_dialogs_custom_blank_color'))
        Button($r("app.string.multi_dialogs_definite_button"))
          .dialogButtonStyle()
          .onClick(() => {
            this.setHobbiesValue(this.hobbyItems);
            this.controller.close();
          })
      }
    }
    .width(CommonConstants.COMMON_DIALOG_WIDTH)
    .padding({
      top: $r("app.float.multi_dialogs_top_distance"),
      bottom: $r("app.float.multi_dialogs_radius")
    })
    .borderRadius($r("app.float.multi_dialogs_radius"))
    .backgroundColor(Color.White)
  }
  
  /* 设置爱好信息。 */
  setHobbiesValue(hobbyItems: HobbyItem[]) {
    if (CommonUtils.isEmptyArr(hobbyItems)) {
      return;
    }
    // 拼接爱好信息。
    let hobbiesText: string = hobbyItems
      .filter((item: HobbyItem) => item?.isChecked)
      .map<string>((checkedHobby: HobbyItem) => checkedHobby.label!)
      .join(CommonConstants.COMMA);
    if (hobbiesText.length > 0) {
      this.hobbies = hobbiesText;
    }
  }
}