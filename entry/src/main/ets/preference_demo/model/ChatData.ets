import { ItemDirection } from './ItemDirection'

export class ChatData {
  itemDirection: ItemDirection = ItemDirection.LEFT;
  content: Resource = $r("app.string.preference_empty")
}