export class RankData {

  /* 商品ID。 */
  id: string;

  /* 商品名称。 */
  name: Resource;

  /* 商品得到的好评信息。 */
  vote: string;

  constructor(id: string, name: Resource, vote: string) {
    this.id = id;
    this.name = name;
    this.vote = vote;
  }
}