import { Component } from '@angular/core';
import { Router } from '@angular/router';
import { User } from 'src/app/models/user';
import { AuthService } from 'src/app/services/auth.service';

@Component({
  selector: 'app-register',
  templateUrl: './register.component.html',
  styleUrls: ['./register.component.css']
})
export class RegisterComponent {

  newUser: User = new User();

  constructor(
     private auth: AuthService,
     private router: Router
     ) {}

  register(user: User): void {
    //  console.log(user);
     this.auth.register(user).subscribe({
        next: (registeredUser) => {
           this.auth.login(user.username, user.password).subscribe({
              next: (loggedInUser) => {
                 this.router.navigateByUrl('');
              },
              error: (issue) => {
                 console.error('RegisterComponent.register(): error logging in new user');
                 console.error(issue);
              },
           });
        },
        error: (problem) => {
           console.error('RegisterComponent.register(): error registering user');
           console.error(problem);
        },
     });
  }

}
