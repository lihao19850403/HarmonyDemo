import { COMMON_NUM_DOUBLE, COMMON_NUM_MINUTE, SPLIT, ZERO_STR } from '../constants/CommonConstants'

/*
将给定的秒转换为mm:ss的格式。
@param value 秒。
 */
export function changeSliderTime(value: number): string {
  let second: number = value % COMMON_NUM_MINUTE;
  let min: number = Number.parseInt(String(value / COMMON_NUM_MINUTE));
  let minStr: string = addZeroHeader(min);
  let secondStr: string = addZeroHeader(second);
  let result: string = `${minStr}${SPLIT}${secondStr}`;
  return result;
}

function addZeroHeader(value: number): string {
  return value < COMMON_NUM_DOUBLE ? `${ZERO_STR}${value}` : String(value);
}