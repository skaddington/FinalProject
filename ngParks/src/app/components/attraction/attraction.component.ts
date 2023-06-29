import { Component, EventEmitter, Input, Output } from '@angular/core';
import { NonNullableFormBuilder } from '@angular/forms';
import { Attraction } from 'src/app/models/attraction';
import { AttractionComment } from 'src/app/models/attraction-comment';
import { Park } from 'src/app/models/park';
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
@Input() selectedPark:Park|null = null
comment: AttractionComment = new AttractionComment();
selectedComment: AttractionComment | null = null;
@Output() reloadPark = new EventEmitter<number>();
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
  if (this.selectedAttraction && this.comment && this.selectedComment) {
    this.attractionCommentService
      .addReply(this.selectedAttraction, this.selectedComment.id, this.comment)
      .subscribe({
        next: (addedComment) => {
          this.selectedAttraction?.attractionComments.push(addedComment);
          this.loggedInUser?.attractionComments.push(addedComment);
          if(this.selectedComment?.replies) {
          this.selectedComment?.replies.push(addedComment);
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

deleteComment(commentId:number) {
  if (this.selectedAttraction) {
    this.attractionCommentService
      .deleteComment(this.selectedAttraction, commentId)
      .subscribe({
        next: (result) => {
          if(this.selectedAttraction && this.selectedPark){
          this.reloadPark.emit(this.selectedPark.id);
          this.reloadSelectedAttraction(this.selectedAttraction.id);
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

reloadSelectedAttraction(id:number) {
  this.attractionCommentService.show(id).subscribe({
    next: (result) => {
    this.selectedAttraction = result;
    },
    error: (nothingChanged) => {
      console.error('ParkCommentComponent.deleteComment(): error removing ParkComment:');
      console.error(nothingChanged);
    },
  });
}



displayAllAttractions() {
  // console.log(this.selectedAttraction?.attractionComments);
  this.selectedAttraction = null;
  this.handleDeselectAttraction(this.selectedAttraction);
}

  @Output() deselectAtraction: EventEmitter<null> = new EventEmitter<null>();
  handleDeselectAttraction(selectedAttraction: null) {
    this.deselectAtraction.emit(selectedAttraction);
  }


}
