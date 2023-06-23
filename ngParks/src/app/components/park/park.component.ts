import { DatePipe } from '@angular/common';
import { HttpClient } from '@angular/common/http';
import { Component } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { Observable, catchError, throwError } from 'rxjs';
import { Park } from 'src/app/models/park';
import { AuthService } from 'src/app/services/auth.service';
import { ParkService } from 'src/app/services/park.service';
import { environment } from 'src/environments/environment';

@Component({
  selector: 'app-park',
  templateUrl: './park.component.html',
  styleUrls: ['./park.component.css'],
})
export class ParkComponent {
  parks: Park[] = [];

  newPark: Park = new Park();
  editPark: Park | null = null;
  selectedPark: Park | null = null;
  // showComplete: boolean = false;

  selectedState: string = 'all';
  states = [
    'ALABAMA',
    'ALASKA',
    'ARIZONA',
    'ARKANSAS',
    'CALIFORNIA',
    'COLORADO',
    'CONNECTICUT',
    'DELAWARE',
    'FLORIDA',
    'GEORGIA',
    'HAWAII',
    'IDAHO',
    'ILLINOIS',
    'INDIANA',
    'IOWA',
    'KANSAS',
    'KENTUCKY',
    'LOUISIANA',
    'MAINE',
    'MARYLAND',
    'MASSACHUSETTS',
    'MICHIGAN',
    'MINNESOTA',
    'MISSISSIPPI',
    'MISSOURI',
    'MONTANA',
    'NEBRASKA',
    'NEVADA',
    'NEW HAMPSHIRE',
    'NEW JERSEY',
    'NEW MEXICO',
    'NEW YORK',
    'NORTH CAROLINA',
    'NORTH DAKOTA',
    'OHIO',
    'OKLAHOMA',
    'OREGON',
    'PENNSYLVANIA',
    'RHODE ISLAND',
    'SOUTH CAROLINA',
    'SOUTH DAKOTA',
    'TENNESSEE',
    'TEXAS',
    'UTAH',
    'VERMONT',
    'VIRGINIA',
    'WASHINGTON',
    'WEST VIRGINIA',
    'WISCONSIN',
    'WYOMING',
  ];

  constructor(
    private parkService: ParkService,
    // private incompletePipe: IncompletePipe,
    private route: ActivatedRoute,
    private router: Router
  ) {}

  ngOnInit() {
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
