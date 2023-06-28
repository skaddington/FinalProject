import { HttpClient } from '@angular/common/http';
import { ParkService } from './../../services/park.service';
import { Component, OnInit } from '@angular/core';
import { Park } from 'src/app/models/park';
import { ParkPhoto } from 'src/app/models/park-photo';
import { User } from 'src/app/models/user';
import { ParkPhotosService } from 'src/app/services/park-photos.service';
import { state } from '@angular/animations';


@Component({
  selector: 'app-gallery',
  templateUrl: './gallery.component.html',
  styleUrls: ['./gallery.component.css']
})
export class GalleryComponent implements OnInit {

  loggedInUser: User | null = null;
  parks: Park[] = [];
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
  selectedOption: string = '';
  parkPhotos: ParkPhoto[] = [];


  constructor(
    private parkService: ParkService,
    private parkPhotosService: ParkPhotosService,
    private http: HttpClient
  ) {}

  ngOnInit() {
    this.reload();
  }

  reload():void {
  }

  // getParkPicturesByState(state: string): void {
  //   this.parkPhotosService.show(state).subscribe((data: any) => {
  //     this.parkPhoto = data;
  //   })
  // }

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
    this.selectedOption = event.target.value;
    this.getParkPhotos(this.selectedOption);
  }

}
