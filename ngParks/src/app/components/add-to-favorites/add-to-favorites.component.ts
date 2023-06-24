import { Component, Input } from '@angular/core';
import { Park } from 'src/app/models/park';
import { User } from 'src/app/models/user';
import { UserService } from 'src/app/services/user.service';

@Component({
  selector: 'app-add-to-favorites',
  templateUrl: './add-to-favorites.component.html',
  styleUrls: ['./add-to-favorites.component.css']
})
export class AddToFavoritesComponent {
  @Input() user: User | null = null;
  @Input() selectedPark:Park | null = null;

  constructor(private userService:UserService){
  }


// addParkToUserFavorites(selectedPark:Park|null) {
//   if(this.user && this.selectedPark) {
//   this.userService.addFavoritePark(this.user ,this.selectedPark.id).subscribe({
//     next: (result) => {
//       if(this.user && selectedPark) {
//         console.log(this.user, this.selectedPark, this.user.parks)
//         this.user.parks.push(selectedPark);
//       }
//     },
//     error: (nojoy) => {
//       console.error('AddFavoritesComponent.addParkToUser(): error adding Park To User:');
//       console.error(nojoy);
//     },
//   });
// }
// }

}
