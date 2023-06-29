import { Component, Input } from '@angular/core';
import { Router } from '@angular/router';
import { User } from 'src/app/models/user';
import { AuthService } from 'src/app/services/auth.service';

@Component({
  selector: 'app-logout',
  templateUrl: './logout.component.html',
  styleUrls: ['./logout.component.css']
})
export class LogoutComponent {
  @Input() loggedInUser: User | null = null;
  constructor(
    private auth: AuthService,
    private router: Router
  ) {}

  logout():void {
    // console.log("Logging out ");
    this.loggedInUser = null;
    this.auth.logout();
    this.router.navigateByUrl('');
  }

}
