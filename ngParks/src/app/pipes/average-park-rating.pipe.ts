import { Pipe, PipeTransform } from '@angular/core';
import { ParkRating } from '../models/park-rating';

@Pipe({
  name: 'averageParkRating'
})
export class AverageParkRatingPipe implements PipeTransform {

  transform(ratings: ParkRating[]): number | string {
    console.log(ratings)
    if (ratings.length < 1){
      return "Park not yet Rated";
    }


    let averageRating: number = 0;
    let count: number = 0;
    ratings.forEach(parkRating => {
      averageRating += parkRating.rating;
      count++;
    });
    return averageRating/count;
  }

}
