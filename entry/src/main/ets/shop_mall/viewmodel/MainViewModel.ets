import { ItemData } from "./ItemData";

export { swiperImages, firstGridData, secondGridData, settingListData }

const swiperImages: Resource[] = [
$r('app.media.shop_mall_fig1'),
$r('app.media.shop_mall_fig2'),
$r('app.media.shop_mall_fig3'),
$r('app.media.shop_mall_fig4')
];

const firstGridData: ItemData[] = [
  new ItemData($r('app.string.shop_mall_my_love'), $r('app.media.shop_mall_love')),
  new ItemData($r('app.string.shop_mall_history_record'), $r('app.media.shop_mall_record')),
  new ItemData($r('app.string.shop_mall_message'), $r('app.media.shop_mall_message')),
  new ItemData($r('app.string.shop_mall_shopping_cart'), $r('app.media.shop_mall_shopping')),
  new ItemData($r('app.string.shop_mall_my_goal'), $r('app.media.shop_mall_target')),
  new ItemData($r('app.string.shop_mall_group'), $r('app.media.shop_mall_circle')),
  new ItemData($r('app.string.shop_mall_favorites'), $r('app.media.shop_mall_favorite')),
  new ItemData($r('app.string.shop_mall_recycle_bin'), $r('app.media.shop_mall_recycle'))
];

const secondGridData: ItemData[] = [
  new ItemData($r('app.string.shop_mall_mainPage_top'), $r('app.media.shop_mall_top'), $r('app.string.shop_mall_mainPage_text_top')),
  new ItemData($r('app.string.shop_mall_mainPage_new'), $r('app.media.shop_mall_new'), $r('app.string.shop_mall_mainPage_text_new')),
  new ItemData($r('app.string.shop_mall_mainPage_brand'), $r('app.media.shop_mall_brand'), $r('app.string.shop_mall_mainPage_text_brand')),
  new ItemData($r('app.string.shop_mall_mainPage_found'), $r('app.media.shop_mall_found'), $r('app.string.shop_mall_mainPage_text_found'))
];

const settingListData: ItemData[] = [
  new ItemData($r('app.string.shop_mall_setting_list_news'), $r('app.media.shop_mall_news'), $r("app.string.shop_mall_setting_toggle")),
  new ItemData($r('app.string.shop_mall_setting_list_data'), $r('app.media.shop_mall_data')),
  new ItemData($r('app.string.shop_mall_setting_list_menu'), $r('app.media.shop_mall_menu')),
  new ItemData($r('app.string.shop_mall_setting_list_about'), $r('app.media.shop_mall_about')),
  new ItemData($r('app.string.shop_mall_setting_list_storage'), $r('app.media.shop_mall_storage')),
  new ItemData($r('app.string.shop_mall_setting_list_privacy'), $r('app.media.shop_mall_privacy'))
];
