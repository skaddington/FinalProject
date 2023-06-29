import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Park } from '../models/park';
import { Observable } from 'rxjs/internal/Observable';
import { catchError, throwError } from 'rxjs';
import { ParkPhoto } from '../models/park-photo';
import { environment } from 'src/environments/environment';

@Injectable({
  providedIn: 'root'
})
export class ParkPhotosService {

  private url = environment.baseUrl + 'api/parkPhotos';

  constructor(private http: HttpClient) { }

  getParkPhotos(state: string): Observable<any> {
    let photos = this.http.get(this.url + '/' + state).pipe();
    return photos;
    //return this.http.get(this.url + '/' + state);
  }

  show(stateName:string):Observable<ParkPhoto[]> {
    return this.http.get<ParkPhoto[]>(this.url + '/' + stateName)
      .pipe(
        catchError((err: any) => {
          console.error(err);
          return throwError(
            () => new Error('AttractionCommntService.update(): error adding AttractionComment: ' + err)
          );
        })
      );
  }
}
