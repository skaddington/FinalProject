import { Component, Input } from '@angular/core';
import { Park } from 'src/app/models/park';
import { ParkComment } from 'src/app/models/park-comment';
import { User } from 'src/app/models/user';
import { ParkCommentService } from 'src/app/services/park-comment.service';

@Component({
  selector: 'app-park-comment',
  templateUrl: './park-comment.component.html',
  styleUrls: ['./park-comment.component.css'],
})
export class ParkCommentComponent {
  @Input() loggedInUser: User | null = null;
  @Input() selectedPark: Park | null = null;
  comment: ParkComment = new ParkComment();
  replyToComment: ParkComment | null = null;
  constructor(private parkCommentService: ParkCommentService) {}

  addComment() {
    if (this.selectedPark && this.comment) {
      this.parkCommentService
        .addComment(this.selectedPark, this.comment)
        .subscribe({
          next: (addedComment) => {
            this.selectedPark?.parkComments.push(addedComment);
            this.loggedInUser?.parkComments.push(addedComment);
            this.comment = new ParkComment();
          },
          error: (nothingChanged) => {
            console.error('ParkComponent.updatePark(): error updating Park:');
            console.error(nothingChanged);
          },
        });
    }
  }

  addReplyComment() {
    if (this.selectedPark && this.comment && this.replyToComment) {
      this.parkCommentService
        .addReply(this.selectedPark, this.replyToComment.id, this.comment)
        .subscribe({
          next: (addedComment) => {
            this.selectedPark?.parkComments.push(addedComment);
            this.loggedInUser?.parkComments.push(addedComment);
            this.replyToComment?.replies.push(addedComment);
            this.comment = new ParkComment();
          },
          error: (nothingChanged) => {
            console.error('ParkComponent.updatePark(): error updating Park:');
            console.error(nothingChanged);
          },
        });
    }
  }
}
