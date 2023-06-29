import { Park } from './park';
import { User } from './user';

export class ParkPhoto {
  id: number;
  image: string;
  imageDate: Date | null;
  park: Park;
  user: User;

  constructor(
    id: number = 0,
    image: string = '',
    imageDate: Date | null = null,
    park: Park = new Park(),
    user: User = new User()
  ) {
    this.id = id;
    this.image = image;
    this.imageDate = imageDate;
    this.park = park;
    this.user = user;
  }
}
