import { Component } from '@angular/core';
import { AuthService } from './services/auth.service';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
export class AppComponent {
  title = 'ngParks';

  constructor(
    private auth: AuthService //FIXME DELETE LATER

  ) {}

  ngOnInit() {
    this.tempTestDeleteMeLater(); // DELETE LATER!!!
  }

  tempTestDeleteMeLater() {
    this.auth.login('admin','test').subscribe({ // change username to match DB
      next: (data) => {
        console.log('Logged in:');
        console.log(data);
      },
      error: (fail) => {
        console.error('Error authenticating:')
        console.error(fail);
      }
    });
  }
}
