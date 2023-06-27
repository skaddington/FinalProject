import { Component, EventEmitter, Input, Output } from '@angular/core';
import { NonNullableFormBuilder } from '@angular/forms';
import { Attraction } from 'src/app/models/attraction';
import { AttractionComment } from 'src/app/models/attraction-comment';
import { User } from 'src/app/models/user';
import { AttractionCommentService } from 'src/app/services/attraction-comment.service';

@Component({
  selector: 'app-attraction',
  templateUrl: './attraction.component.html',
  styleUrls: ['./attraction.component.css']
})
export class AttractionComponent {
@Input() selectedAttraction:Attraction|null=null;
@Input() loggedInUser:User|null = null;
comment: AttractionComment = new AttractionComment();
replyToComment: AttractionComment | null = null;

constructor(private attractionCommentService:AttractionCommentService){}

addComment() {
  if (this.selectedAttraction && this.comment) {
    this.attractionCommentService
      .addComment(this.selectedAttraction, this.comment)
      .subscribe({
        next: (addedComment) => {
          this.selectedAttraction?.attractionComments.push(addedComment);
          this.loggedInUser?.attractionComments.push(addedComment);
          this.comment = new AttractionComment();
        },
        error: (nothingChanged) => {
          console.error('ParkComponent.updatePark(): error updating Park:');
          console.error(nothingChanged);
        },
      });
  }
}

addReplyComment() {
  if (this.selectedAttraction && this.comment && this.replyToComment) {
    this.attractionCommentService
      .addReply(this.selectedAttraction, this.replyToComment.id, this.comment)
      .subscribe({
        next: (addedComment) => {
          this.selectedAttraction?.attractionComments.push(addedComment);
          this.loggedInUser?.attractionComments.push(addedComment);
          if(this.replyToComment?.replies) {
          this.replyToComment?.replies.push(addedComment);
          }
          this.comment = new AttractionComment();
        },
        error: (nothingChanged) => {
          console.error('ParkComponent.updatePark(): error updating Park:');
          console.error(nothingChanged);
        },
      });
  }
}

displayAllAttractions() {
  console.log(this.selectedAttraction?.attractionComments);
  this.selectedAttraction = null;
  this.handleDeselectAttraction(this.selectedAttraction);
}

  @Output() deselectAtraction: EventEmitter<null> = new EventEmitter<null>();
  handleDeselectAttraction(selectedAttraction: null) {
    this.deselectAtraction.emit(selectedAttraction);
  }


}
