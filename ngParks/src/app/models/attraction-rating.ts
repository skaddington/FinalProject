import { Attraction } from './attraction';
import { User } from './user';

export class AttractionRating {
  id: number;
  rating: number;
  ratingComment: string;
  ratingDate: Date | null;
  user: User;
  attraction: Attraction;

  constructor(
    id: number = 0,
    rating: number = 0,
    ratingComment: string = '',
    ratingDate: Date | null = null,
    user: User = new User(),
    attraction: Attraction = new Attraction()
  ) {
    this.id = id;
    this.rating = rating;
    this.ratingComment = ratingComment;
    this.ratingDate = ratingDate;
    this.user = user;
    this.attraction = attraction;
  }
}
