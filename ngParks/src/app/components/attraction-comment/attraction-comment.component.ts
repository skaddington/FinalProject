import { Component, Input, OnInit } from '@angular/core';
import { Attraction } from 'src/app/models/attraction';
import { AttractionComment } from 'src/app/models/attraction-comment';
import { User } from 'src/app/models/user';
import { AttractionCommentService } from 'src/app/services/attraction-comment.service';

@Component({
  selector: 'app-attraction-comment',
  templateUrl: './attraction-comment.component.html',
  styleUrls: ['./attraction-comment.component.css'],
})
export class AttractionCommentComponent implements OnInit {
  @Input() loggedInUser: User | null = null;
  @Input() selectedAttraction: Attraction | null = null;
  comment: AttractionComment = new AttractionComment();
  selectedComment: AttractionComment | null = null;
  attractionComments: AttractionComment[] = [];
  constructor(private attractionCommentService: AttractionCommentService) {}

  ngOnInit(): void {
    if (this.selectedAttraction) {
      this.loadAttractionComments(this.selectedAttraction.id);
    }
  }

  loadAttractionComments(attrId: number) {
    if (this.selectedAttraction) {
      this.attractionCommentService
        .showCommentByAttraction(this.selectedAttraction.id)
        .subscribe({
          next: (result) => {
            this.attractionComments = result;
          },
          error: (nothingChanged) => {
            console.error(
              'AttractionCommentComponent.loadAttractionComments(): error loading Comments:'
            );
            console.error(nothingChanged);
          },
        });
    }
  }

  addComment() {
    if (this.selectedAttraction && this.comment) {
      this.attractionCommentService
        .addComment(this.selectedAttraction, this.comment)
        .subscribe({
          next: (addedComment) => {
            if (this.selectedAttraction) {
              this.loadAttractionComments(this.selectedAttraction.id);
            }
            this.comment = new AttractionComment();
          },
          error: (nothingChanged) => {
            console.error(
              'AttractionCommentComponent.addComment(): error adding Comment:'
            );
            console.error(nothingChanged);
          },
        });
    }
  }

  addReplyComment() {
    if (this.selectedAttraction && this.comment && this.selectedComment) {
      this.attractionCommentService
        .addReply(
          this.selectedAttraction,
          this.selectedComment.id,
          this.comment
        )
        .subscribe({
          next: (addedComment) => {
            if (this.selectedAttraction) {
              this.loadAttractionComments(this.selectedAttraction.id);
            }
            this.comment = new AttractionComment();
          },
          error: (nothingChanged) => {
            console.error(
              'AttractionCommentComponent.addReplyComment(): error adding Comment:'
            );
            console.error(nothingChanged);
          },
        });
    }
  }

  deleteComment(commentId: number) {
    if (this.selectedAttraction) {
      this.attractionCommentService
        .deleteComment(this.selectedAttraction, commentId)
        .subscribe({
          next: (result) => {
            if (this.selectedAttraction) {
              this.loadAttractionComments(this.selectedAttraction.id);
            }
            this.selectedComment = null;
          },
          error: (nothingChanged) => {
            console.error(
              'AttractionCommentComponent.deleteComment(): error Deleting Comment:'
            );
            console.error(nothingChanged);
          },
        });
    }
  }
}
