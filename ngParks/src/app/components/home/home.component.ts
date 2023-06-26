import { Component, OnInit } from '@angular/core';
import { Park } from 'src/app/models/park';
import { ParkService } from 'src/app/services/park.service';

@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.css'],
})
export class HomeComponent implements OnInit {
  parks: Park[] = [];
  selectedPark: Park | null = null;

  constructor(private parkService: ParkService) {}

  ngOnInit(): void {
    this.reloadCarousel();
  }

  reloadCarousel(): void {
    this.parkService.index().subscribe({
      next: (parkList) => {
        this.parks = parkList;
      },
      error: (problem) => {
        console.error('HomeComponent.reloadCarousel(): error loading Parks');
        console.error(problem);
      },
    });
  }

  displayParkDetails(park: Park) {
    return (this.selectedPark = park);
  }
}
