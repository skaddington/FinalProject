import { Park } from './park';
import { ParkRatingId } from './park-rating-id';
import { User } from './user';

export class ParkRating {
  id: ParkRatingId;
  rating: number;
  ratingComment: string;
  ratingDate: Date | null;
  user: User;
  park: Park;

  constructor(
    id: ParkRatingId = new ParkRatingId(),
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
