import display from '@ohos.display';
import { GlobalContext } from '../../../main_contents/common/utils/GlobalContext';

export class DimensionUtils {
  private context = getContext(this);
  private DESIGN_WIDTH = 360;
  private DESIGN_HEIGHT = 780;

  adaptDimension(value: number): number {
    let deviceDisplay: display.Display = GlobalContext.getInstance().getObject("display") as display.Display;
    let widthScale = deviceDisplay.width / this.DESIGN_WIDTH;
    let virtualHeight = widthScale * this.DESIGN_HEIGHT;
    let designDim = Math.sqrt(this.DESIGN_WIDTH * this.DESIGN_WIDTH + this.DESIGN_HEIGHT * this.DESIGN_HEIGHT);
    let virtualDim = Math.sqrt(deviceDisplay.width * deviceDisplay.height + virtualHeight * virtualHeight);
    return virtualDim * value / designDim;
  }

  getPx(value: Resource): number {
    let beforeVp = this.context.resourceManager.getNumber(value.id);
    return this.adaptDimension(beforeVp);
  }

  getVp(value: Resource): number {
    let beforeVp = this.context.resourceManager.getNumber(value.id);
    return px2vp(this.adaptDimension(beforeVp));
  }

  getFp(value: Resource): number {
    let beforeFp = this.context.resourceManager.getNumber(value.id);
    return px2fp(this.adaptDimension(beforeFp));
  }
}

export default new DimensionUtils();