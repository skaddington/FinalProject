import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { BehaviorSubject, Observable, catchError, throwError } from 'rxjs';
import { environment } from 'src/environments/environment';
import { Park } from '../models/park';
import { AuthService } from './auth.service';
import { ParkRating } from '../models/park-rating';
import { Attraction } from '../models/attraction';

@Injectable({
  providedIn: 'root',
})
export class ParkService {
  private url = environment.baseUrl + 'api/parks';
  private selectedParkSubject: BehaviorSubject<Park | null> = new BehaviorSubject<Park | null>(null);
  private selectedAttractionSubject: BehaviorSubject<Attraction | null> = new BehaviorSubject<Attraction | null>(null);

  constructor(
    private http: HttpClient,
    private auth: AuthService
  ) {}

  getHttpOptions() {
    let options = {
      headers: {
        Authorization: 'Basic ' + this.auth.getCredentials(),
        'X-Requested-With': 'XMLHttpRequest',
      },
    };
    return options;
  }

  index(): Observable<Park[]> {
    return this.http.get<Park[]>(this.url).pipe(
        catchError((err: any) => {
          console.log(err);
          return throwError(
            () =>
              new Error('ParkService.index(): error retrieving Parks: ' + err)
          );
        })
      );
  }


  show(parkId: number): Observable<Park> {
    return this.http
      .get<Park>(this.url + '/' + parkId)
      .pipe(
        catchError((err: any) => {
          console.log(err);
          return throwError(
            () =>
              new Error('ParkService.index(): error retrieving Park: ' + err)
          );
        })
      );
  }

  update(park: Park): Observable<Park> {
    return this.http
      .put<Park>(this.url + '/' + park.id, park, this.getHttpOptions())
      .pipe(
        catchError((err: any) => {
          console.error(err);
          return throwError(
            () => new Error('ParkService.update(): error updating Park: ' + err)
          );
        })
      );
  }

  addParkRating(rating: ParkRating, parkId:number): Observable<ParkRating> {
    return this.http
      .post<ParkRating>(
        this.url + '/' + parkId + '/ratings',
        rating,
        this.getHttpOptions()
      )
      .pipe(
        catchError((err: any) => {
          console.error(err);
          return throwError(
            () => new Error('ParkService.addParkRating(): error adding Park Rating: ' + err)
          );
        })
      );
  }

  setSelectedPark(park: Park | null) {
    this.selectedParkSubject.next(park);
  }

  getSelectedPark(): Observable<Park | null> {
    return this.selectedParkSubject.asObservable();
  }

  setSelectedAttraction(attraction: Attraction | null) {
    this.selectedAttractionSubject.next(attraction);
  }

  getSelectedAttraction(): Observable<Attraction | null> {
    return this.selectedAttractionSubject.asObservable();
  }

}
