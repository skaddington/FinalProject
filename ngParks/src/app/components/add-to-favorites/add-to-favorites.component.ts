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
  @Input() loggedInUser: User | null = null;
  @Input() selectedPark:Park | null = null;

  constructor(private userService:UserService){
  }


 addParkToUserFavorites() {
  if(this.selectedPark && this.loggedInUser) {
    console.log(this.selectedPark.id)
  this.userService.addFavoritePark(this.loggedInUser ,this.selectedPark.id).subscribe({
    next: (result) => {
      if(this.selectedPark && this.loggedInUser){
          console.log( this.selectedPark.id + " selected park");
          console.log(this.loggedInUser.id + this.loggedInUser.firstName + "logged in user")
          console.log(this.loggedInUser.favoriteParks + "User parks");
        this.loggedInUser.favoriteParks.push(this.selectedPark);
        }
    },
    error: (nojoy) => {
      console.error('AddFavoritesComponent.addParkToUser(): error adding Park To User:');
      console.error(nojoy);
    },
  });
}}

}
