import { AuthService } from './../../services/auth.service';
import { DatePipe } from '@angular/common';
import { HttpClient } from '@angular/common/http';
import { Component } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { Observable, catchError, throwError } from 'rxjs';
import { Park } from 'src/app/models/park';
import { State } from 'src/app/models/state';
import { User } from 'src/app/models/user';
import { StatePipe } from 'src/app/pipes/state.pipe';
import { ParkService } from 'src/app/services/park.service';
import { UserService } from 'src/app/services/user.service';
import { environment } from 'src/environments/environment';

@Component({
  selector: 'app-park',
  templateUrl: './park.component.html',
  styleUrls: ['./park.component.css'],
})
export class ParkComponent {
  loggedInUser:User | null = null;
  parks: Park[] = [];

  newPark: Park = new Park();
  editPark: Park | null = null;
  selectedPark: Park | null = null;
  // showComplete: boolean = false;

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
  ]



  constructor(
    private parkService: ParkService,
    private statePipe: StatePipe,
    private route: ActivatedRoute,
    private router: Router,
    private authService:AuthService,
    private userService:UserService
  ) {}


  checkUser():User | null {
    this.authService.getLoggedInUser().subscribe({
      next: (user) => {
       return this.loggedInUser = user;
      },
      error: (problem) => {
        console.error('ParkComponent.reload(): error loading Parks');
        console.error(problem);
      },
    });
    if(this.loggedInUser) {
    return this.loggedInUser
    }
    return null;
  }

  addParkToUserFavorites() {
    if(this.selectedPark && this.loggedInUser) {
      console.log(this.selectedPark.id)
    this.userService.addFavoritePark(this.loggedInUser ,this.selectedPark.id).subscribe({
      next: (result) => {
        if(this.selectedPark && this.loggedInUser){
            console.log( this.selectedPark.id + " selected park");
            console.log(this.loggedInUser.id + this.loggedInUser.firstName + "logged in user")
            console.log(this.loggedInUser.favoriteParks + "User parks");
          this.loggedInUser.favoriteParks.push(this.selectedPark);
          }
      },
      error: (nojoy) => {
        console.error('AddFavoritesComponent.addParkToUser(): error adding Park To User:');
        console.error(nojoy);
      },
    });
  }}



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

  // getTodoCount(): number {
  //   return this.incompletePipe.transform(this.todos, false).length;
  // }

  // getIncompleteAnxietyLevel() {
  //   let numIncompleteTodos = this.getTodoCount();
  //   if (numIncompleteTodos >= 10) {
  //     return 'danger';
  //   } else if (numIncompleteTodos >= 5) {
  //     return 'warning';
  //   } else {
  //     return 'good';
  //   }
  // }

  displayParkDetails(park: Park) {
    return (this.selectedPark = park);
  }

  displayParkTable() {
    return (this.selectedPark = null);
  }

  // addTodo(newTodo: Todo) {
  //   this.todoService.create(newTodo).subscribe({
  //     next: (createdTodo) => {
  //       this.reload();
  //       this.selected = createdTodo;
  //       this.newTodo = new Todo();
  //     },
  //     error: (somethingBlewUp) => {
  //       console.error('TodoListComponent.addTodo(): error creating todo:');
  //       console.error(somethingBlewUp);
  //     },
  //   });
  // }

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

  // deletePark(parkId: number): void {
  //   this.parkService.destroy(parkId).subscribe({
  //     next: () => {
  //       this.reload();
  //       this.selectedPark = null;
  //     },
  //     error: (somethingWentWrong) => {
  //       console.error('ParkListComponent.deleteTodo(): error deleting Park:');
  //       console.error(somethingWentWrong);
  //     },
  //   });
  //   this.reload();
  // }
}
