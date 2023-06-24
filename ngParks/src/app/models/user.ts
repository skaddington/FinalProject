import { Park } from "./park";

export class User {
  id: number;
  username: string;
  password: string;
  firstName: string;
  lastName: string;
  image: string;
  description: string;
  role: string;
  enabled: boolean;
  favoriteParks:Park[];

  constructor(
    id: number = 0,
    username: string = '',
    password: string = '',
    firstName: string = '',
    lastName: string = '',
    image: string = '',
    description: string = '',
    role: string = '',
    enabled: boolean = false,
    favoriteParks:Park[] =[]
  ) {
    this.id = id;
    this.username = username;
    this.password = password;
    this.firstName = firstName;
    this.lastName = lastName;
    this.image = image;
    this.description = description;
    this.role = role;
    this.enabled = enabled;
    this.favoriteParks=favoriteParks;
  }
}
