import { Attraction } from './../../models/attraction';
import { AuthService } from './../../services/auth.service';
import { DatePipe } from '@angular/common';
import { HttpClient } from '@angular/common/http';
import { Component, Input } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { Observable, catchError, throwError } from 'rxjs';
import { Park } from 'src/app/models/park';
import { State } from 'src/app/models/state';
import { User } from 'src/app/models/user';
import { StatePipe } from 'src/app/pipes/state.pipe';
import { ParkService } from 'src/app/services/park.service';
import { StateService } from 'src/app/services/state.service';
import { UserService } from 'src/app/services/user.service';
import { environment } from 'src/environments/environment';

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
  selectedAttraction: Attraction | null = null;
  selectedState: string = 'All';
  states = [
    'All',
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
    'Wyoming',
  ];

  constructor(
    private stateService:StateService,
    private parkService: ParkService,
    private statePipe: StatePipe,
    private route: ActivatedRoute,
    private router: Router,
    private authService: AuthService,
    private userService: UserService
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
      console.log(idString);
      let parkId: number = Number.parseInt(idString);
      console.log(parkId);
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

  selectAttraction(attraction: Attraction) {
    this.selectedAttraction = attraction;
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

  handleDeselectAttraction(selectedAttraction: null) {
    this.selectedAttraction = selectedAttraction;
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
