import { Component } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { Park } from 'src/app/models/park';
import { User } from 'src/app/models/user';
import { AuthService } from 'src/app/services/auth.service';
import { ParkService } from 'src/app/services/park.service';
import { UserService } from 'src/app/services/user.service';

@Component({
  selector: 'app-user',
  templateUrl: './user.component.html',
  styleUrls: ['./user.component.css'],
})
export class UserComponent {
  users: User[] = [];

  loggedInUser: User | null= null;
  editUser: User | null = null;
  selectedUser: User | null = null;

  constructor(
    private userService: UserService,
    private authService:AuthService,
    private route: ActivatedRoute,
    private router: Router
  ) {}

  ngOnInit() {
    let idString = this.route.snapshot.paramMap.get('id');
    if (!this.selectedUser && idString) {
      console.log(idString);
      let userId: number = Number.parseInt(idString);
      console.log(userId);
      if (isNaN(userId)) {
        this.router.navigateByUrl('loser');
      } else {
        this.showUser(userId);
      }
    }
    this.reload();
  }

  checkUser(): User | null {
    this.authService.getLoggedInUser().subscribe({
      next: (user) => {
        return (this.loggedInUser = user);
      },
      error: (problem) => {
        console.error('UserComponent.reload(): error loading Users');
        console.error(problem);
      },
    });
    if (this.loggedInUser) {
      return this.loggedInUser;
    }
    return null;
  }

  logoutUser(){
    this.loggedInUser = null;
  }

  reload(): void {
    this.userService.index().subscribe({
      next: (userList) => {
        this.users = userList;
      },
      error: (problem) => {
        console.error('UserComponent.reload(): error loading Users');
        console.error(problem);
      },
    });
  }

  // getActiveUsersCount(): number {
  //   return this.incompletePipe.transform(this.todos, false).length;
  // }

  displayUserDetails(user: User) {
    return (this.selectedUser = user);
  }

  displayUserTable() {
    return (this.selectedUser = null);
  }

  showUser(userId: number) {
    this.userService.show(userId).subscribe({
      next: (foundUser) => {
        this.selectedUser = foundUser;
        this.reload();
      },
      error: (somethingBlewUp) => {
        console.error('UserComponent.showTodo(): error getting User:');
        console.error(somethingBlewUp);
        this.router.navigateByUrl('still a loser');
      },
    });
  }

  setEditUser(): void {
    this.editUser = Object.assign({}, this.selectedUser);
  }

  updateUser(updateUser: User, goToDetails: boolean = true): void {
    this.userService.update(updateUser).subscribe({
      next: (updatedUser) => {
        if (goToDetails) {
          this.selectedUser = updatedUser;
        }
        this.editUser = null;
        this.reload();
      },
      error: (nothingChanged) => {
        console.error('UserComponent.updateUser(): error updating User:');
        console.error(nothingChanged);
      },
    });
  }

  removeParkFromFavorites() {}

  // deletePark(parkId: number): void {
  //   this.parkService.destroy(parkId).subscribe({
  //     next: () => {
  //       this.reload();
  //       this.selectedPark = null;
  //     },
  //     error: (somethingWentWrong) => {
  //       console.error('ParkListComponent.deleteTodo(): error deleting Park:');
  //       console.error(somethingWentWrong);
  //     },
  //   });
  //   this.reload();
  // }
}
