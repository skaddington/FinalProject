import { Component, EventEmitter, Output } from '@angular/core';
import { Router } from '@angular/router';
import { User } from 'src/app/models/user';
import { AuthService } from 'src/app/services/auth.service';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css'],
})
export class LoginComponent {
  loginUser: User = new User();
  @Output() loginSuccess: EventEmitter<User> = new EventEmitter<User>();

  constructor(private auth: AuthService, private router: Router) {}

  login(loginUser: User): void {
    this.auth.login(loginUser.username, loginUser.password).subscribe({
      next: (loggedInUser) => {
        this.router.navigateByUrl('');
      },
      error: (problem) => {
        console.error('LoginComponent.login(): error logging in user');
        console.error(problem);
        this.router.navigateByUrl('login');
      },
    });
  }
  handleLoginSuccess(loggedInUser: User) {
    this.loginSuccess.emit(loggedInUser);
  }
}
