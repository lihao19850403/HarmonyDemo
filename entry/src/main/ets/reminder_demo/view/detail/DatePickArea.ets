import { CommonConstants } from '../../common/constants/CommonConstants'
import { DetailConstant } from '../../common/constants/DetailConstant'
import DimensionUtils from '../../common/utils/DimensionUtils'
import { DayDataItem } from '../../model/DayDataItem'

@Component
export struct DatePickArea {
  build() {
    Stack({
      alignContent: Alignment.Center
    }) {
      Row() {
        ForEach(DetailConstant.DAY_DATA,
          (item: DayDataItem) => {
            TextPicker({
              range: item.data,
              selected: item.delSelect
            })
              .layoutWeight(CommonConstants.DEFAULT_LAYOUT_WEIGHT)
              .backgroundColor($r('app.color.grey_light'))
              .onChange((value: string, index: number) => {
                item.delSelect = index;
              })
          },
          (item: DayDataItem, index?: number) => JSON.stringify(item) + index)
      }
    }
    .height(DimensionUtils.getVp($r('app.float.reminder_date_picker_height')))
    .padding({
      left: DimensionUtils.getVp($r('app.float.reminder_date_picker_padding_horizon')),
      right: DimensionUtils.getVp($r('app.float.reminder_date_picker_padding_horizon'))
    })
  }
}