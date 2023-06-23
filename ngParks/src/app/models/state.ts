import { Park } from "./park";

export class State {
  id: number;
  abbriviation: string;
  name: string;
  parks: Park[] | null;

  constructor(
    id: number = 0,
    abbriviation: string = '',
    name: string = '',
    parks: Park[] | null = null
  ) {
    this.id = id;
    this.abbriviation = abbriviation;
    this.name = name;
    this.parks = parks;
  }
}
