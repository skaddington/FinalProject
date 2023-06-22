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

  constructor(
    id: number = 0,
    username: string = '',
    password: string = '',
    firstName: string = '',
    lastName: string = '',
    image: string = '',
    description: string = '',
    role: string = '',
    enabled: boolean = false
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
  }
}
