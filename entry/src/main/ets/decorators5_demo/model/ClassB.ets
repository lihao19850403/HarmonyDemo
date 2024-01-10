import { ClassA } from './ClassA';

export class ClassB {
  public name: string;
  public a: ClassA;

  constructor(a: ClassA, name: string = "Mike") {
    this.a = a;
    this.name = name;
  }
}