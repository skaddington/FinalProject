import { Park } from './park';
import { User } from './user';

export class ParkComment {
  id: number;
  content: string;
  createdAt: Date | null;
  enabled: boolean;
  user: User|null;
  park: Park|null;
  comment: ParkComment | null;
  replies: ParkComment[];

  constructor(
    id: number = 0,
    content: string = '',
    createdAt: Date | null = null,
    enabled: boolean = true,
    user: User = new User(),
    park: Park = new Park(),
    comment: ParkComment | null = null,
    replies: ParkComment[] = []
  ) {
    this.id = id;
    this.content = content;
    this.createdAt = createdAt;
    this.enabled = enabled;
    this.user = user;
    this.park = park;
    this.comment = comment;
    this.replies = replies;
  }
}
