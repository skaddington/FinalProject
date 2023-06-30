import { HttpClient } from '@angular/common/http';
import { ParkService } from './../../services/park.service';
import { Component, Input, OnInit } from '@angular/core';
import { Park } from 'src/app/models/park';
import { ParkPhoto } from 'src/app/models/park-photo';
import { User } from 'src/app/models/user';
import { ParkPhotosService } from 'src/app/services/park-photos.service';
import { ActivatedRoute, Router } from '@angular/router';
import { StatePipe } from 'src/app/pipes/state.pipe';
import { AuthService } from 'src/app/services/auth.service';
import { StateService } from 'src/app/services/state.service';
import { UserService } from 'src/app/services/user.service';


@Component({
  selector: 'app-gallery',
  templateUrl: './gallery.component.html',
  styleUrls: ['./gallery.component.css'],
})
export class GalleryComponent implements OnInit {
  states: string[] = [
    'Alaska',
    'American Samoa',
    'Arizona',
    'Arkansas',
    'California',
    'Colorado',
    'Florida',
    'Hawaii',
    'Idaho',
    'Indiana',
    'Kentucky',
    'Maine',
    'Michigan',
    'Minnesota',
    'Montana',
    'Nevada',
    'New Mexico',
    'North Carolina',
    'North Dakota',
    'Ohio',
    'Oregon',
    'South Carolina',
    'Tennessee',
    'Texas',
    'South Dakota',
    'Utah',
    'Virginia',
    'Virgin Islands',
    'Washington',
    'West Virgina',
    'Wyoming',
  ];

  loggedInUser: User | null = null;
  parks: Park[] = [];
  selectedOption: string = '';
  parkPhotos: ParkPhoto[] = [];
  @Input() selectedPark: Park | null = null;
  selectedState: any;
  selectedPhoto: ParkPhoto | null = null;

  constructor(
    private parkService: ParkService,
    private parkPhotosService: ParkPhotosService,
    private route: ActivatedRoute,
    private router: Router,
    private authService: AuthService
  ) {}

  checkUser(): User | null {
    this.authService.getLoggedInUser().subscribe({
      next: (user) => {
        return (this.loggedInUser = user);
      },
      error: (problem) => {
        console.error('ParkComponent.reload(): error loading Parks');
        console.error(problem);
      },
    });
    if (this.loggedInUser) {
      return this.loggedInUser;
    }
    return null;
  }

  ngOnInit() {
    this.checkUser();
    let idString = this.route.snapshot.paramMap.get('id');
    if (!this.selectedPark && idString) {
      let parkId: number = Number.parseInt(idString);
      if (isNaN(parkId)) {
        this.router.navigateByUrl('loser');
      } else {
        this.showPark(parkId);
      }
    }
    this.reload();
  }

  reload(): void {
    this.parkService.index().subscribe({
      next: (parkList) => {
        this.parks = parkList;
      },
      error: (problem) => {
        console.error('ParkComponent.reload(): error loading Parks');
        console.error(problem);
      },
    });
  }

  displayParkPhoto(photo: ParkPhoto) {
    return (this.selectedPhoto = photo);
  }

  displayAllPhotos() {
    return (this.selectedPhoto = null);
  }

  displayParkDetails(park: Park) {
    this.router.navigateByUrl('parks/' + park.id);
  }

  showPark(parkId: number) {
    this.parkService.show(parkId).subscribe({
      next: (foundPark) => {
        this.selectedPark = foundPark;
        this.reload();
      },
      error: (somethingBlewUp) => {
        console.error('ParkComponent.showTodo(): error getting Park:');
        console.error(somethingBlewUp);
        this.router.navigateByUrl('still a loser');
      },
    });
  }

  refreshSelectedPark(parkId: number) {
    this.parkService.show(parkId).subscribe({
      next: (updatedPark) => {
        this.selectedPark = updatedPark;
      },
      error: (nothingChanged) => {
        console.error(
          'ParkComponent.RefreshSelectedPark(): error refreshing Park:'
        );
        console.error(nothingChanged);
      },
    });
  }

  getParkPicturesByState(state: string): void {
    this.parkPhotosService.show(state).subscribe((data: any) => {
      this.parkPhotos = data;
    });
  }

  getParkPhotos(stateName: string) {
    this.parkPhotosService.show(stateName).subscribe({
      next: (parkPhotoList) => {
        this.parkPhotos = parkPhotoList;
      },
      error: (problem) => {
        console.error('ParkComponent.reload(): error loading Parks');
        console.error(problem);
      },
    });
  }

  onStateChange(event: any) {
    // console.log(event);
    this.selectedOption = event.target.value;
    // console.log(event.target.value);
    this.getParkPhotos(this.selectedOption);
  }
}
