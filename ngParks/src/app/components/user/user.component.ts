import { Component } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { User } from 'src/app/models/user';
import { AuthService } from 'src/app/services/auth.service';
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
  ) {
    this.userService.getSelectedUser().subscribe(selectedUser => {
      this.selectedUser = selectedUser;
    });
  }

  ngOnInit() {
    let idString = this.route.snapshot.paramMap.get('id');
    if (!this.selectedUser && idString) {
      // console.log(idString);
      let userId: number = Number.parseInt(idString);
      // console.log(userId);
      if (isNaN(userId)) {
        this.router.navigateByUrl('loser');
      } else {
        this.showUser(userId);
      }
    }
    this.reload();
    this.checkUser();
  }

  checkUser(): User | null {
    this.authService.getLoggedInUser().subscribe({
      next: (user) => {
        return (this.loggedInUser = user);
      },
      error: (problem) => {
        console.error('UserComponent.checkUser(): error loading Users');
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

  displayUserDetails(user: User) {
    this.selectedUser = user;
    // console.log(this.selectedUser.username)
    // console.log(this.loggedInUser?.username);
    return this.selectedUser;
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

disableUser(user: User){
  this.userService.toggle(user)
  .subscribe({
    next: (result) => {
      this.reload();
    },
    error: (nothingChanged) => {
      console.error('ParkCommentComponent.disableUser(): error disabling User:');
      console.error(nothingChanged);
    },
  });
}

enableUser(user: User){
  user.enabled = true;
  this.updateUser(user, false);
}

  handleRemovalSuccess(loggedInUser:User) {
    this.loggedInUser = loggedInUser;
    this.selectedUser = this.loggedInUser;
    this.reload();
    this.showUser(loggedInUser.id);
  }
}
