import { Component, EventEmitter, Input, Output } from '@angular/core';
import { Router } from '@angular/router';
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

  constructor(private userService:UserService, private router:Router){}

removeParkFromFavorites() {
  if(this.selectedPark && this.loggedInUser) {
  this.userService.removeFavoritePark(this.loggedInUser, this.selectedPark.id).subscribe({
    next: (result) => {
      if (this.loggedInUser?.favoriteParks && this.selectedPark) {
        let index = this.loggedInUser.favoriteParks.indexOf(this.selectedPark);
        if (index !== -1) {
          this.loggedInUser.favoriteParks = this.loggedInUser.favoriteParks.filter(park => park.id !== this.selectedPark?.id);
          this.router.navigateByUrl("/users/" + this.loggedInUser.id);



        }
      }
    },
    error: (nojoy) => {
      console.error('CardLisComponent.addCardToUser(): error adding Card To User:');
      console.error(nojoy);
    },
  });
}
}

@Output() removalSuccess: EventEmitter<User> = new EventEmitter<User>();
handleRemovalSuccess(loggedInUser: User) {
  this.removalSuccess.emit(loggedInUser);
 }
}

}



