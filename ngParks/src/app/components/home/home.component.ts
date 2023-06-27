import { Component, OnInit } from '@angular/core';
import { Park } from 'src/app/models/park';
import { ParkService } from 'src/app/services/park.service';

@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.css'],
})
export class HomeComponent implements OnInit {
  parks: any[] = [];
  selectedPark: Park | null = null;

  constructor(private parkService: ParkService) {}

  ngOnInit(): void {
    this.reloadCarousel();
  }

  reloadCarousel(): void {
    this.parkService.index().subscribe({
      next: (parkList) => {
        this.parks = this.chunks(parkList, 3);
        // this.parks = parkList;
        console.log(this.parks);
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

  chunks(array: Park[], size: number) {
    let results = [];
    results = [];
    while (array.length) {
      results.push(array.splice(0, size));
    }
    return results;
  }

  prevBtnClick() {
    let carouselObj = (document.querySelector('.carousel') as any)
      .ej2_instances[0];
    carouselObj.prev();
  }

  nextBtnClick() {
    console.log('click');
    let carouselObj = (document.querySelector('.carousel') as any)
      .ej2_instances[0];
    carouselObj.next();
  }
}
