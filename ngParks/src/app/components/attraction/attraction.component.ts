import { Component, EventEmitter, Input, OnInit, Output } from '@angular/core';
import { Attraction } from 'src/app/models/attraction';
import { AttractionComment } from 'src/app/models/attraction-comment';
import { Park } from 'src/app/models/park';
import { User } from 'src/app/models/user';
import { AttractionCommentService } from 'src/app/services/attraction-comment.service';


@Component({
  selector: 'app-attraction',
  templateUrl: './attraction.component.html',
  styleUrls: ['./attraction.component.css'],
})
export class AttractionComponent implements OnInit {
  @Input() selectedAttraction: Attraction | null = null;
  @Input() loggedInUser: User | null = null;
  @Input() selectedPark: Park | null = null;
  comment: AttractionComment = new AttractionComment();
  selectedComment: AttractionComment | null = null;
  attractions: Attraction[] = [];

  constructor(private attractionCommentService: AttractionCommentService) {}

  ngOnInit(): void {
    if (this.selectedPark) {
      this.loadAllParkAttractions(this.selectedPark.id);
    }
  }

  loadAllParkAttractions(parkId: number) {
    if (this.selectedPark) {
      this.attractionCommentService.showByPark(this.selectedPark.id).subscribe({
        next: (result) => {
          this.attractions = result;
        },
        error: (noJoy) => {
          console.error(
            'AttractionComponent.loadAllParkAttractions(); error loading Attractions'
          );
          console.error(noJoy);
        },
      });
    }
  }

  reloadSelectedAttraction(id: number) {
    this.attractionCommentService.show(id).subscribe({
      next: (result) => {
        this.selectedAttraction = result;
      },
      error: (nothingChanged) => {
        console.error(
          'ParkCommentComponent.deleteComment(): error removing ParkComment:'
        );
        console.error(nothingChanged);
      },
    });
  }

  selectAttraction(attractionId: number) {
    this.attractionCommentService.show(attractionId).subscribe({
      next: (attraction) => {
        this.selectedAttraction = attraction;
      },
      error: (nothingChanged) => {
        console.error('ParkComponent.updatePark(): error updating Park:');
        console.error(nothingChanged);
      },
    });
  }

  displayAllAttractions() {
    this.selectedAttraction = null;
  }
}
