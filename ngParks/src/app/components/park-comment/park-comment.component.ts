import { Component, EventEmitter, Input, OnInit, Output } from '@angular/core';
import { Park } from 'src/app/models/park';
import { ParkComment } from 'src/app/models/park-comment';
import { User } from 'src/app/models/user';
import { ParkCommentService } from 'src/app/services/park-comment.service';

@Component({
  selector: 'app-park-comment',
  templateUrl: './park-comment.component.html',
  styleUrls: ['./park-comment.component.css'],
})
export class ParkCommentComponent implements OnInit {
  @Input() loggedInUser: User | null = null;
  @Input() selectedPark: Park | null = null;
  comment: ParkComment = new ParkComment();
  selectedComment: ParkComment | null = null;
  @Output() reloadPark = new EventEmitter<number>();
  // comments:ParkComment[]=[]
  constructor(private parkCommentService: ParkCommentService) {}


  ngOnInit(): void {
    // if(this.comments && this.selectedPark) {
    // this.comments = this.selectedPark.parkComments;
    // }
  }

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
    if (this.selectedPark && this.comment && this.selectedComment) {
      this.parkCommentService
        .addReply(this.selectedPark, this.selectedComment.id, this.comment)
        .subscribe({
          next: (addedComment) => {
            this.selectedPark?.parkComments.push(addedComment);
            this.loggedInUser?.parkComments.push(addedComment);
            this.selectedComment?.replies.push(addedComment);
            this.comment = new ParkComment();
          },
          error: (nothingChanged) => {
            console.error('ParkCommentComponent.addReplyComment(): error adding replyParkcomment:');
            console.error(nothingChanged);
          },
        });
    }
  }

  deleteComment(commentId:number) {
    if (this.selectedPark) {
      this.parkCommentService
        .deleteComment(this.selectedPark.id, commentId)
        .subscribe({
          next: (result) => {
            if(this.selectedPark){
            this.reloadPark.emit(this.selectedPark.id);
            }
            this.selectedComment=null;
          },
          error: (nothingChanged) => {
            console.error('ParkCommentComponent.deleteComment(): error removing ParkComment:');
            console.error(nothingChanged);
          },
        });
    }
  }



}
