import { ParkRating } from './../../models/park-rating';
import { Component, Input } from '@angular/core';
import { Park } from 'src/app/models/park';

@Component({
  selector: 'app-park-rating',
  templateUrl: './park-rating.component.html',
  styleUrls: ['./park-rating.component.css'],
})
export class ParkRatingComponent {
  @Input() selectedPark: Park | null = null;
  parkRatings: number[] = [];
  averageParkRating: number | undefined = undefined;

  // getParkRatings(): void(
  //   if(selectedPark){
  //     for(let rating of this.selectedPark.parkRatings){

  //     }
  //   }
  // )

}
