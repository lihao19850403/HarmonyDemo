@Observed
export class ClassA {
  public id: number;
  public name: string;

  constructor(id: number, name: string = "OK") {
    this.id = id;
    this.name = name;
  }
}