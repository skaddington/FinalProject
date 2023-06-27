import { HttpClient } from '@angular/common/http';
import { ParkService } from './../../services/park.service';
import { Component, OnInit } from '@angular/core';
import { Park } from 'src/app/models/park';
import { ParkPhoto } from 'src/app/models/park-photo';
import { User } from 'src/app/models/user';
import { ParkPhotosService } from 'src/app/services/park-photos.service';


@Component({
  selector: 'app-gallery',
  templateUrl: './gallery.component.html',
  styleUrls: ['./gallery.component.css']
})
export class GalleryComponent implements OnInit {

  loggedInUser: User | null = null;
  parks: Park[] = [];
  options: string[] = [];
  selectedOption: string = '';


  constructor(
    private parkService: ParkService,
    private parkPhotosService: ParkPhotosService,
    private http: HttpClient
  ) {}

  ngOnInit() {
    this.reload();
    this.fetchOptions();
  }

  reload():void {
    this.parkService.index().subscribe({
      next: (parkList) => {
        this.parks = parkList;
      },
      error: (boo) => {
        console.error('ParkPhotoComponent.reload(): error loading Park Photos');
        console.error(boo);
      }
    })
  }

  displayParkPhotos() {
    this.parkPhotosService.getParkPhotos().subscribe((data: Park[]) => {
      this.parks = data;
    })
  }

  fetchOptions(keyword?: string) {
    // const params = keyword ? { search: keyword} : {};

    // this.http.get<any>('gallery/{pid}', {params}).subscribe(response => {
    //   this.options = response.options;
    // });
  }

  onOptionSelected(event: any) {
    this.selectedOption = event.target.value;
  }

}
