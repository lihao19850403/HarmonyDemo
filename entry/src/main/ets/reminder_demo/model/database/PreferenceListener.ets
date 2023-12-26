export interface PreferenceListener {
  onDataChanged: (key: string) => void;
}