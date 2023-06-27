import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';

@Injectable({
  providedIn: 'root'
})
export class ParkPhotosService {

  constructor(private http: HttpClient) { }

  getParkPhotos() {
    return this.http.get<string[]>('api/gallery');
  }
}
