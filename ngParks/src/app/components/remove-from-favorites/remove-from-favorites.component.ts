import { Component } from '@angular/core';
import { Park } from 'src/app/models/park';
import { User } from 'src/app/models/user';


@Component({
  selector: 'app-remove-from-favorites',
  templateUrl: './remove-from-favorites.component.html',
  styleUrls: ['./remove-from-favorites.component.css']
})
export class RemoveFromFavoritesComponent {

  loggedInUser:User|null = null;
  selectedPark:Park|null = null;

  constructor(){}



}
