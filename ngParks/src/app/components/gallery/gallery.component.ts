import { ParkService } from './../../services/park.service';
import { Component } from '@angular/core';
import { Router } from '@angular/router';
import { Park } from 'src/app/models/park';
import { ParkPhoto } from 'src/app/models/park-photo';
import { User } from 'src/app/models/user';
import { AuthService } from 'src/app/services/auth.service';
import { UserService } from 'src/app/services/user.service';

@Component({
  selector: 'app-gallery',
  templateUrl: './gallery.component.html',
  styleUrls: ['./gallery.component.css']
})
export class GalleryComponent {

  loggedInUser: User | null = null;
  parks: Park[] = [];


  constructor(
    private parkService: ParkService,
    private route: Router,
    private authService: AuthService,
    private userService: UserService
  ) {}

  ngOnInit() {
    this.reload();
  }

  reload():void {
    this.parkService.index().subscribe({
      next: (parkList) => {
        this.parks = parkList;
      },
      error: (boo) => {
        console.error('ParkPhotoComponent.reload(): error loading Park Photos');
        console.error(boo);
      }
    })
  }

  displayParkPhotos() {
    return (this.parks)
  }

}
