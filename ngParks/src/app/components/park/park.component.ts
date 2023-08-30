import { Attraction } from './../../models/attraction';
import { AuthService } from './../../services/auth.service';
import { Component, Input } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { Park } from 'src/app/models/park';
import { User } from 'src/app/models/user';
import { AttractionCommentService } from 'src/app/services/attraction-comment.service';
import { ParkService } from 'src/app/services/park.service';

@Component({
  selector: 'app-park',
  templateUrl: './park.component.html',
  styleUrls: ['./park.component.css'],
})
export class ParkComponent {
  loggedInUser: User | null = null;
  parks: Park[] = [];

  newPark: Park = new Park();
  editPark: Park | null = null;
  @Input() selectedPark: Park | null = null;
  selectedState: string = 'All';
  states = [
    'All',
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

  constructor(
    private parkService: ParkService,
    private route: ActivatedRoute,
    private router: Router,
    private authService: AuthService,
    private attractionCommentService: AttractionCommentService
  ) {
    this.parkService.getSelectedPark().subscribe((selectedPark) => {
      this.selectedPark = selectedPark;
    });
  }

  checkUser(): User | null {
    this.authService.getLoggedInUser().subscribe({
      next: (user) => {
        this.loggedInUser = user;
      },
      error: (problem) => {
        console.error('ParkComponent.reload(): error loading Parks');
        console.error('User is ' + problem);
      },
    });
    if (this.loggedInUser) {
      return this.loggedInUser;
    }
    return null;
  }

  ngOnInit() {
    this.checkUser();
    this.reload();
    this.route.paramMap.subscribe((params) => {
      let idString = params.get('id');
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
    });
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
    this.checkUserParkRatings(park);
    return (this.selectedPark = park);
  }

  displayParkTable() {
    return (this.selectedPark = null);
  }

  showPark(parkId: number) {
    this.parkService.show(parkId).subscribe({
      next: (foundPark) => {
        this.selectedPark = foundPark;
        this.authService.getLoggedInUser().subscribe({
          next: (user) => {
            this.loggedInUser = user;
            this.checkUserParkRatings(foundPark);
          },
          error: (problem) => {
            console.error('ParkComponent.reload(): error loading Parks');
            console.error('User is ' + problem);
          },
        });
        this.reload();
      },
      error: (somethingBlewUp) => {
        console.error('ParkComponent.showPark(): error getting Park:');
        console.error(somethingBlewUp);
        this.router.navigateByUrl('still a loser');
      },
    });
  }

  setEditPark(): void {
    this.editPark = Object.assign({}, this.selectedPark);
  }

  updatePark(updatePark: Park, goToDetails: boolean = true): void {
    this.parkService.update(updatePark).subscribe({
      next: (updatedPark) => {
        if (goToDetails) {
          this.selectedPark = updatedPark;
        }
        this.editPark = null;
        this.reload();
      },
      error: (nothingChanged) => {
        console.error('ParkComponent.updatePark(): error updating Park:');
        console.error(nothingChanged);
      },
    });
  }

  refreshSelectedPark(parkId: number) {
    this.parkService.show(parkId).subscribe({
      next: (updatedPark) => {
        this.selectedPark = updatedPark;
        this.checkUserParkRatings(this.selectedPark);
      },
      error: (nothingChanged) => {
        console.error(
          'ParkComponent.RefreshSelectedPark(): error refreshing Park:'
        );
        console.error(nothingChanged);
      },
    });
  }

  hadRatedPark: boolean | undefined = false;
  checkUserParkRatings(park: Park) {
    this.hadRatedPark = false;
    // console.log('beginning of rating check ' + this.hadRatedPark);
    // console.log(this.loggedInUser);
    if (this.loggedInUser && park) {
      for (let userParkRating of this.loggedInUser?.parkRatings) {
        // console.log('middle of rating check ' + userParkRating.park.id);
        if (userParkRating.park.id === park.id) {
          this.hadRatedPark = true;
          // console.log('end of rating check ' + this.hadRatedPark);
          break;
        }
      }
    }
  }
}
