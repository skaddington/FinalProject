import { Park } from './park';

export class Activity {
  id: number;
  name: string;
  description: string;
  image: string;
  enabled: boolean;
  parks: Park[];

  constructor(
    id: number = 0,
    name: string = '',
    description: string = '',
    image: string = '',
    enabled: boolean = true,
    parks: Park[] = []
  ) {
    this.id = id;
    this.name = name;
    this.description = description;
    this.image = image;
    this.enabled = enabled;
    this.parks = parks;
  }
}
