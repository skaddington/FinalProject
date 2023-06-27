import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { Park } from 'src/app/models/park';
import { ParkService } from 'src/app/services/park.service';

@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.css'],
})
export class HomeComponent implements OnInit {
  parks: any[] = [];

  constructor(private parkService: ParkService,
    private router: Router) {}

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
    this.router.navigateByUrl("parks/" + park.id);
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
