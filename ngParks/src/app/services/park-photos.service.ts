import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Park } from '../models/park';

@Injectable({
  providedIn: 'root'
})
export class ParkPhotosService {

  constructor(private http: HttpClient) { }

  getParkPhotos() {
    return this.http.get<Park[]>('api/gallery');
  }
}
