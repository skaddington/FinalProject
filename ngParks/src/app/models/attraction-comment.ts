import { Attraction } from './attraction';
import { User } from './user';

export class AttractionComment {
  id: number;
  content: string;
  createdAt: Date | null;
  enabled: boolean;
  user: User;
  attraction: Attraction;
  comment: AttractionComment | null;
  replies: AttractionComment[] | null;

  constructor(
    id: number = 0,
    content: string = '',
    createdAt: Date | null = null,
    enabled: boolean = true,
    user: User = new User(),
    attraction: Attraction = new Attraction(),
    comment: AttractionComment | null = null,
    replies: AttractionComment[] | null = null
  ) {
    this.id = id;
    this.content = content;
    this.createdAt = createdAt;
    this.enabled = enabled;
    this.user = user;
    this.attraction = attraction;
    this.comment = comment;
    this.replies = replies;
  }
}
