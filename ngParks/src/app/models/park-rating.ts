import { Park } from './park';
import { User } from './user';

export class ParkRating {
  id: number;
  rating: number;
  ratingComment: string;
  ratingDate: Date | null;
  user: User;
  park: Park;

  constructor(
    id: number = 0,
    rating: number = 0,
    ratingComment: string = '',
    ratingDate: Date | null = null,
    user: User = new User(),
    park: Park = new Park()
  ) {
    this.id = id;
    this.rating = rating;
    this.ratingComment = ratingComment;
    this.ratingDate = ratingDate;
    this.user = user;
    this.park = park;
  }
}
