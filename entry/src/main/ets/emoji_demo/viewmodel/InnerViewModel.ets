import { ButtonList } from '../model/ButtonList';

const BUTTON_LIST: ButtonList[] = [
  {
    title: '普通按钮',
    subtitle: '用于一般界面操作',
    backgroundImage: '',
    buttonText: '普通按钮',
    buttonShape: 'capsule',
    buttonType: '',
    stateEffect: true,
    fontColor: ''
  },
  {
    title: '强调按钮',
    subtitle: '在界面上很突出，用于强调当前操作',
    backgroundImage: '',
    buttonText: '强调按钮',
    buttonShape: 'capsule',
    buttonType: 'info',
    stateEffect: true,
    fontColor: '#409eff'
  },
  {
    title: '文本按钮',
    subtitle: '文本按钮为纯文本按钮，点击执行操作',
    backgroundImage: '',
    buttonText: '文本按钮',
    buttonShape: 'capsule',
    buttonType: 'none',
    stateEffect: true,
    fontColor: '#409eff'
  }
];

class InnerViewModel {

  getButtonListData(): ButtonList[] {
    return BUTTON_LIST;
  }
}

export default new InnerViewModel;