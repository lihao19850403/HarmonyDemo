import Context from "@ohos.app.ability.common";
import CommonConstants from '../constants/CommonConstants';

export class CommonUtils {

  /* 退出APP。 */
  exitAPPbyAlertDialog(context: Context.UIAbilityContext) {
    AlertDialog.show({
      message: $r("app.string.multi_dialogs_alert_dialog_message"),
      alignment: DialogAlignment.Bottom,
      offset: {
        dx: 0,
        dy: CommonConstants.DY_OFFSET
      },
      primaryButton: {
        value: $r("app.string.multi_dialogs_cancel_button"),
        action: () => {

        }
      },
      secondaryButton: {
        value: $r("app.string.multi_dialogs_definite_button"),
        action: () => context.terminateSelf()
      }
    });
  }

  /* 选择日期。 */
  datePickerDialog(dateCallback: Function) {
    DatePickerDialog.show({
      start: new Date(CommonConstants.START_TIME),
      end: new Date(),
      selected: new Date(CommonConstants.SELECT_TIME),
      lunar: false,
      onAccept: (value: DatePickerResult) => {
        let year = Number(value.year);
        let month = Number(value.month); // 注意：月份从0开始。
        let day = Number(value.day);
        let birthday: string = this.getBirthdayValue(year, month, day);
        dateCallback(birthday);
      }
    });
  }

  /* 拼接生日信息。 */
  getBirthdayValue(year: number, month: number, day: number): string {
    let yearStr = `${year}${CommonConstants.DATE_YEAR}`;
    let monthStr = `${Math.max(1, month)}${CommonConstants.DATE_MONTH}`;
    let dayStr = `${day}${CommonConstants.DATE_DAY}`;
    return `${yearStr}${monthStr}${dayStr}`;
  }

  /* 选择文本。 */
  textPickerDialog(infoArr: Resource, callback: Function) {
    if (this.isEmptyObj(infoArr)) {
      return;
    }
    TextPickerDialog.show({
      range: infoArr,
      selected: 0,
      onAccept: (result: TextPickerResult) => callback(result.value),
      onCancel: () => {}
    });
  }

  /* 判断对象是否为空。 */
  isEmptyObj(obj: string | object): boolean {
    return obj === undefined || obj === null || obj === "";
  }

  /* 判断数组是否为空。 */
  isEmptyArr(arr: Array<any>): boolean {
    return arr === undefined || arr === null || arr.length === 0;
  }
}

export default new CommonUtils();