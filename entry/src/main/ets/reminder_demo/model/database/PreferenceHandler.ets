import preferences from '@ohos.data.preferences';
import { CommonConstants } from '../../common/constants/CommonConstants';
import { PreferenceListener } from './PreferenceListener';

export class PreferenceHandler {
  private static instance: PreferenceHandler;
  private listeners: PreferenceListener[];
  private preference: preferences.Preferences | null = null;
  private defaultValue = "";

  private constructor() {
    this.listeners = new Array<PreferenceListener>();
  }

  public static getInstance(): PreferenceHandler {
    if (!PreferenceHandler.instance) {
      PreferenceHandler.instance = new PreferenceHandler();
    }
    return PreferenceHandler.instance;
  }

  public async configure(context: Context) {
    this.preference = await preferences.getPreferences(context, CommonConstants.PREFERENCE_ID);
    this.preference.on("change", (data: Record<string, Object>) => {
      for (let preferenceListener of this.listeners) {
        preferenceListener.onDataChanged(data.key as string);
      }
    });
  }

  public async set(key: string, value: string) {
    if (this.preference) {
      await this.preference.put(key, value);
      await this.preference.flush();
    }
  }

  public async get(key: string) {
    let data: string = "";
    if (this.preference) {
      data = await this.preference.get(key, this.defaultValue) as string;
    }
    return data;
  }

  public clear() {
    if (this.preference) {
      this.preference.clear();
    }
  }

  public addPreferenceListener(listener: PreferenceListener) {
    this.listeners.push(listener);
  }
}