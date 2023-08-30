import { ParkRating } from './../../models/park-rating';
import { Component, EventEmitter, Input, Output } from '@angular/core';
import { Park } from 'src/app/models/park';
import { User } from 'src/app/models/user';
import { ParkService } from 'src/app/services/park.service';

@Component({
  selector: 'app-park-rating',
  templateUrl: './park-rating.component.html',
  styleUrls: ['./park-rating.component.css'],
})
export class ParkRatingComponent {
  @Input() loggedInUser: User | null = null;
  @Input() selectedPark: Park | null = null;
  parkRating: ParkRating = new ParkRating();

  @Output() reloadPark = new EventEmitter<number>();

  constructor(private parkService: ParkService) {}

  setRatingValue(value: number) {
    this.parkRating.rating = value;
    if (this.loggedInUser && this.selectedPark) {
      this.parkRating.user = this.loggedInUser;
      this.parkRating.park = this.selectedPark;
    }
    this.submitUserRating(this.parkRating);
  }

  submitUserRating(parkRating: ParkRating) {
    if (this.selectedPark) {
      this.parkService
        .addParkRating(this.parkRating, this.selectedPark.id)
        .subscribe({
          next: (addedRating) => {
            this.parkRating = addedRating;
            this.loggedInUser?.parkRatings.push(parkRating);
            this.selectedPark?.parkRatings.push(parkRating);
            this.reloadPark.emit(this.selectedPark?.id);
          },
          error: (problem) => {
            console.error(
              'ParkRatingComponent.submitUserRating(): error adding Park Rating'
            );
            console.error(problem);
          },
        });
    }
  }
}
