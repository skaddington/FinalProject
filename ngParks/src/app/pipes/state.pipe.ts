import { Pipe, PipeTransform } from '@angular/core';
import { Park } from '../models/park';

@Pipe({
  name: 'state'
})
export class StatePipe implements PipeTransform {

  transform(parks: Park[], stateName: string): Park [] {
    if (stateName === 'all'){
      return parks;
    }

    const results: Park[] = [];
    parks.forEach((park) => {
      if (park.states) {
        park.states.forEach((state) => {
          if (state.name === stateName) {
            results.push(park);
          }
        });
      }
    });
    return results;
  }

}
