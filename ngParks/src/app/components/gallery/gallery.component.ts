import { HttpClient } from '@angular/common/http';
import { ParkService } from './../../services/park.service';
import { Component, Input, OnInit } from '@angular/core';
import { Park } from 'src/app/models/park';
import { ParkPhoto } from 'src/app/models/park-photo';
import { User } from 'src/app/models/user';
import { ParkPhotosService } from 'src/app/services/park-photos.service';
import { state } from '@angular/animations';
import { ActivatedRoute, Router } from '@angular/router';
import { Attraction } from 'src/app/models/attraction';
import { StatePipe } from 'src/app/pipes/state.pipe';
import { AuthService } from 'src/app/services/auth.service';
import { StateService } from 'src/app/services/state.service';
import { UserService } from 'src/app/services/user.service';
import { Observable } from 'rxjs';


@Component({
  selector: 'app-gallery',
  templateUrl: './gallery.component.html',
  styleUrls: ['./gallery.component.css']
})
export class GalleryComponent implements OnInit {

  states: string[] = [
  'Alabama',
  'Alaska',
  'Arizona',
  'Arkansas',
  'California',
  'Colorado',
  'Connecticut',
  'Delaware',
  'Florida',
  'Georgia',
  'Hawaii',
  'Idaho',
  'Illinois',
  'Indiana',
  'Iowa',
  'Kansas',
  'Kentucky',
  'Lousiana',
  'Maine',
  'Maryland',
  'Massachusetts',
  'Michigan',
  'Minnesota',
  'Mississippi',
  'Missouri',
  'Montana',
  'Nebraska',
  'Nevada',
  'New Hampshire',
  'New Jersey',
  'New Mexico',
  'New York',
  'North Carolina',
  'North Dakota',
  'Ohio',
  'Oklahoma',
  'Oregon',
  'Pennslyvania',
  'Rhode Island',
  'South Carolina',
  'Tennessee',
  'Texas',
  'South Dakota',
  'Utah',
  'Vermont',
  'Virginia',
  'Washington',
  'West Virgina',
  'Wisconsin',
  'Wyoming',];

  loggedInUser: User | null = null;
  parks: Park[] = [];
  selectedOption: string = '';
  parkPhotos: ParkPhoto[] = [];
  @Input() selectedPark: Park | null = null;
  selectedState: any;

  constructor(
    private parkService: ParkService,
    private parkPhotosService: ParkPhotosService,
    private http: HttpClient,
    private stateService: StateService,
    private statePipe: StatePipe,
    private route: ActivatedRoute,
    private router: Router,
    private authService: AuthService,
    private userService: UserService
  ) {}

  getParkPicturesByState(state: string): void {
    this.parkPhotosService.show(state).subscribe((data: any) => {
      this.parkPhotos = data;
    })
  }

  getParkPhotos(stateName:string) {
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
    console.log(event);
    this.selectedOption = event.target.value;
    console.log(event.target.value);
    this.getParkPhotos(this.selectedOption);
  }









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
      // console.log(idString);
      let parkId: number = Number.parseInt(idString);
      // console.log(parkId);
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

  displayParkDetails(park: Park) {
    return (this.selectedPark = park);
  }

  displayParkTable() {
    return (this.selectedPark = null);
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

  refreshSelectedPark(parkId:number) {
  this.parkService.show(parkId).subscribe({
    next: (updatedPark) => {
      this.selectedPark = updatedPark;
    },
    error: (nothingChanged) => {
      console.error('ParkComponent.RefreshSelectedPark(): error refreshing Park:');
      console.error(nothingChanged);
    },
  });


  }


}
