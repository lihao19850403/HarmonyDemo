import { HorizontalVideoItem } from '../model/HorizontalVideoItem';
import { SwiperVideoItem } from '../model/SwiperVideoItem'

export const SWIPER_VIDEOS: SwiperVideoItem[] = [
  new SwiperVideoItem($r("app.media.simple_video_banner1")),
  new SwiperVideoItem($r("app.media.simple_video_banner2")),
  new SwiperVideoItem($r("app.media.simple_video_banner3"))
];

export const HORIZONTAL_VIDEOS: HorizontalVideoItem[] = [
  new HorizontalVideoItem(1, $r("app.media.simple_video_list0"), "视频1"),
  new HorizontalVideoItem(2, $r("app.media.simple_video_list1"), "视频2"),
  new HorizontalVideoItem(3, $r("app.media.simple_video_list2"), "视频3")
];