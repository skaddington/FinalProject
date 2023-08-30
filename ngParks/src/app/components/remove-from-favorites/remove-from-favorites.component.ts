import { Component, EventEmitter, Input, Output } from '@angular/core';
import { Router } from '@angular/router';
import { Park } from 'src/app/models/park';
import { User } from 'src/app/models/user';
import { UserService } from 'src/app/services/user.service';

@Component({
  selector: 'app-remove-from-favorites',
  templateUrl: './remove-from-favorites.component.html',
  styleUrls: ['./remove-from-favorites.component.css'],
})
export class RemoveFromFavoritesComponent {
  @Input() loggedInUser: User | null = null;
  @Input() selectedPark: Park | null = null;
  @Output() removalSuccess: EventEmitter<User> = new EventEmitter<User>();

  constructor(private userService: UserService, private router: Router) {}

  removeParkFromFavorites() {
    if (this.selectedPark && this.loggedInUser) {
      this.userService
        .removeFavoritePark(this.loggedInUser, this.selectedPark.id)
        .subscribe({
          next: (result) => {
            this.handleRemovalSuccess(result);
          },
          error: (nojoy) => {
            console.error(
              'reniveFromFavoritesComponent.removeParkFromFavorites(): error Removing Park From User:'
            );
            console.error(nojoy);
          },
        });
    }
  }

  handleRemovalSuccess(loggedInUser: User) {
    this.removalSuccess.emit(loggedInUser);
  }
}
