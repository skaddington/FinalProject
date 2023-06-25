import { Component } from '@angular/core';
import { User } from 'src/app/models/user';
import { AuthService } from 'src/app/services/auth.service';

@Component({
  selector: 'app-navbar',
  templateUrl: './navbar.component.html',
  styleUrls: ['./navbar.component.css']
})
export class NavbarComponent {
loggedInUser:User|null=null;

  constructor(
    private auth: AuthService
  ) {}

  checkLoginStatus(): boolean {
    return this.auth.checkLogin();
  }

  handleLoginSuccess(user: User) {
    this.loggedInUser = user;
  }
}
