import { Component, Input } from '@angular/core';
import { Park } from 'src/app/models/park';
import { User } from 'src/app/models/user';
import { UserService } from 'src/app/services/user.service';


@Component({
  selector: 'app-remove-from-favorites',
  templateUrl: './remove-from-favorites.component.html',
  styleUrls: ['./remove-from-favorites.component.css']
})
export class RemoveFromFavoritesComponent {

 @Input() loggedInUser:User|null = null;
 @Input() selectedPark:Park|null = null;

  constructor(private userService:UserService){}

removeParkFromFavorites() {
  if(this.selectedPark && this.loggedInUser) {
  this.userService.removeFavoritePark(this.loggedInUser, this.selectedPark.id).subscribe({
    next: (result) => {
      if (this.loggedInUser?.favoriteParks && this.selectedPark) {
        let index = this.loggedInUser.favoriteParks.indexOf(this.selectedPark);
        if (index !== -1) {
          this.loggedInUser.favoriteParks.splice(index, 1);

        }
      }
    },
    error: (nojoy) => {
      console.error('CardLisComponent.addCardToUser(): error adding Card To User:');
      console.error(nojoy);
    },
  });
}
}}



