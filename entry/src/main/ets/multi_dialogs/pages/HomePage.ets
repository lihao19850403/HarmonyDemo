import prompt from '@ohos.promptAction';
import CommonConstants from '../common/constants/CommonConstants';
import CommonUtils from '../common/utils/CommonUtils';
import { CustomDialogWidget } from '../view/CustomDialogWidget';
import Context from '@ohos.app.ability.common';
import { TextInputWidget } from '../view/TextInputWidget';
import { TextCommonWidget } from '../view/TextCommonWidget';

@Entry
@Component
struct HomePage {
  @State birthday: string = "";
  @State hobbies: string = "";
  @State sex: string = "";

  private sexArray: Resource = $r("app.strarray.multi_dialogs_sex_array");
  customDialogController: CustomDialogController = new CustomDialogController({
    builder: CustomDialogWidget({
      hobbies: $hobbies
    }),
    customStyle: true,
    alignment: DialogAlignment.Bottom,
    offset: {
      dx: 0,
      dy: CommonConstants.DY_OFFSET
    }
  });

  aboutToAppear() {
    // 获取生日。
    let date = new Date();
    let year = date.getFullYear();
    let month = date.getMonth() + CommonConstants.PLUS_ONE;
    let day = date.getDate();
    this.birthday = CommonUtils.getBirthdayValue(year, month, day);
    // 获取性别。
    let context = getContext(this);
    if (CommonUtils.isEmptyObj(context) || CommonUtils.isEmptyObj(context.resourceManager)) {
      return;
    }
    let manager = context.resourceManager;
    manager.getStringValue($r("app.string.multi_dialogs_default_sex").id,
      (error, sexValue) => {
        if (!CommonUtils.isEmptyObj(error)) {
          prompt.showToast({
            message: JSON.stringify(error),
            duration: 1000
          })
        } else {
          this.sex = sexValue;
        }
      });
  }

  build() {
    Column() {
      Image($r("app.media.multi_dialogs_ic_back"))
        .width($r("app.float.multi_dialogs_image_back_size"))
        .height($r("app.float.multi_dialogs_image_back_size"))
        .alignSelf(ItemAlign.Start)
        .margin({
          left: CommonConstants.BACK_MARGIN_LEFT,
          top: CommonConstants.BACK_MARGIN_TOP
        })
        .onClick(() => {
          let context = getContext(this) as Context.UIAbilityContext;
          CommonUtils.exitAPPbyAlertDialog(context);
        })
      Image($r('app.media.multi_dialogs_ic_avatar'))
        .width($r('app.float.multi_dialogs_avatar_size'))
        .height($r('app.float.multi_dialogs_avatar_size'))
        .alignSelf(ItemAlign.Center)
        .margin({
          top: CommonConstants.AVATAR_MARGIN_TOP
        })
      Text($r('app.string.multi_dialogs_text_personal_title'))
        .fontColor(Color.Black)
        .fontSize($r('app.float.multi_dialogs_personal_font_size'))
        .margin({
          top: CommonConstants.PERSONAL_MARGIN_TOP
        })
        .alignSelf(ItemAlign.Center)
      // 以下是各种信息登记条目。
      TextInputWidget({
        inputImage: $r('app.media.multi_dialogs_ic_nickname'),
        hintText: $r('app.string.multi_dialogs_text_input_hint')
      })
      TextCommonWidget({
        textImage: $r('app.media.multi_dialogs_ic_birthdate'),
        title: $r('app.string.multi_dialogs_title_birthdate'),
        content: $birthday,
        onItemClick: () => CommonUtils.datePickerDialog((birthValue: string) => this.birthday = birthValue)
      })
      TextCommonWidget({
        textImage: $r('app.media.multi_dialogs_ic_sex'),
        title: $r('app.string.multi_dialogs_title_sex'),
        content: $sex,
        onItemClick: () => CommonUtils.textPickerDialog(this.sexArray, (sexValue: string) => this.sex = sexValue)
      })
      TextInputWidget({
        inputImage: $r('app.media.multi_dialogs_ic_signature'),
        hintText: $r('app.string.multi_dialogs_text_input_signature')
      })
      TextCommonWidget({
        textImage: $r('app.media.multi_dialogs_ic_hobbies'),
        title: $r('app.string.multi_dialogs_title_hobbies'),
        content: $hobbies,
        onItemClick: () => this.customDialogController.open()
      })
    }
    .width(CommonConstants.FULL_WIDTH)
    .height(CommonConstants.FULL_HEIGHT)
    .backgroundColor($r("app.color.multi_dialogs_column_background_color"))
  }
}