import dataPreferences from '@ohos.data.preferences';

/* 用于存储键值对信息的工具类。 */
export class PreferenceUtils {

  private readonly PREFERENCES_NAME = 'myPreferences';
  private readonly KEY_APP_FONT_SIZE = 'appFontSize';

  private getFontPreference: () => Promise<dataPreferences.Preferences>;

  /*
   创建数据存储单元。（先调用这个方法进行初始化。）
   @param context: 建议传递全局上下文。
   */
  createFontPreference(context: Context) {
    this.getFontPreference = () => {
      let preference: Promise<dataPreferences.Preferences> = dataPreferences.getPreferences(context, this.PREFERENCES_NAME);
      return preference;
    };
  }

  /* 存储默认的字号信息。（只调用一次。） */
  saveDefaultFontSize(fontSize: number) {
    if (!this.getFontPreference) {
      return;
    }
    this.getFontPreference()
      .then((preference: dataPreferences.Preferences) => {
        preference.has(this.KEY_APP_FONT_SIZE)
          .then(async (isExist: boolean) => {
            if (!isExist) {
              await preference.put(this.KEY_APP_FONT_SIZE, fontSize);
              preference.flush();
            }
          })
          .catch((error) => console.log('Get the preferences failed, err: ' + error));
      })
      .catch((error) => console.log('Get the preferences failed, err: ' + error));
  }

  /* 字号信息变化的时候调用这个方法存储。 */
  saveChangedFontSize(fontSize: number) {
    if (!this.getFontPreference) {
      return;
    }
    this.getFontPreference()
      .then(async (preference: dataPreferences.Preferences) => {
        await preference.put(this.KEY_APP_FONT_SIZE, fontSize);
        preference.flush();
      })
      .catch((error) => console.log('put the preferences failed, err: ' + error));
  }

  /* 获取当前字号信息。 */
  async getChangedFontSize(): Promise<number> {
    if (!this.getFontPreference) {
      return 0;
    }
    let preference: dataPreferences.Preferences = await this.getFontPreference();
    let fontSize: number = (await preference.get(this.KEY_APP_FONT_SIZE, 0)) as number;
    return fontSize;
  }

  /* 删除字号信息。 */
  async deleteChangedFontSize() {
    if (!this.getFontPreference) {
      return;
    }
    let preference: dataPreferences.Preferences = await this.getFontPreference();
    preference.delete(this.KEY_APP_FONT_SIZE)
      .then(() => console.log('Succeeded in deleting the key appFontSize.'))
      .catch((error) => console.log('Failed to delete the key appFontSize. Cause: ' + error));
  }
}

export default new PreferenceUtils();