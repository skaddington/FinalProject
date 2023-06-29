import { Component } from '@angular/core';
import { User } from 'src/app/models/user';
import { AuthService } from 'src/app/services/auth.service';
import { ParkService } from 'src/app/services/park.service';
import { UserService } from 'src/app/services/user.service';

@Component({
  selector: 'app-navbar',
  templateUrl: './navbar.component.html',
  styleUrls: ['./navbar.component.css']
})
export class NavbarComponent {
loggedInUser:User|null=null;

  constructor(
    private auth: AuthService,
    private parkService: ParkService,
    private userService:UserService
  ) {}

  checkLoginStatus(): boolean {
    return this.auth.checkLogin();
  }

  handleLoginSuccess(user: User) {
    this.loggedInUser = user;
  }

  clearSelectedPark() {
    this.parkService.setSelectedAttraction(null);
    this.parkService.setSelectedPark(null);
}

clearSelectedUser() {
  this.userService.setSelectedUser(null);
}
}
