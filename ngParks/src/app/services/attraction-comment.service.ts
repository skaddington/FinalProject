import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable, catchError, throwError } from 'rxjs';
import { environment } from 'src/environments/environment';
import { Attraction } from '../models/attraction';
import { AttractionComment } from '../models/attraction-comment';
import { AuthService } from './auth.service';

@Injectable({
  providedIn: 'root'
})
export class AttractionCommentService {
  private url = environment.baseUrl + 'api/attractions';
  constructor(
    private http: HttpClient,
    private auth: AuthService
  ) { }

  getHttpOptions() {
    let options = {
      headers: {
        Authorization: 'Basic ' + this.auth.getCredentials(),
        'X-Requested-With': 'XMLHttpRequest',
      },
    };
    return options;
  }



  show(attractionId:number):Observable<Attraction> {
    return this.http
      .get<Attraction>(this.url + '/' + attractionId , this.getHttpOptions())
      .pipe(
        catchError((err: any) => {
          console.error(err);
          return throwError(
            () => new Error('AttractionCommntService.update(): error adding AttractionComment: ' + err)
          );
        })
      );
  }

  addComment(attraction: Attraction, comment:AttractionComment): Observable<AttractionComment> {
    return this.http
      .post<AttractionComment>(this.url + '/' + attraction.id + "/comments" , comment, this.getHttpOptions())
      .pipe(
        catchError((err: any) => {
          console.error(err);
          return throwError(
            () => new Error('AttractionCommntService.update(): error adding AttractionComment: ' + err)
          );
        })
      );
  }

  addReply(attraction: Attraction, cid:number, reply:AttractionComment): Observable<AttractionComment> {
    return this.http
      .post<AttractionComment>(this.url + '/' + attraction.id + "/comments/"+ cid , reply, this.getHttpOptions())
      .pipe(
        catchError((err: any) => {
          console.error(err);
          return throwError(
            () => new Error('ParkCommntService.update(): error adding ReplyParkComment: ' + err)
          );
        })
      );
  }

  deleteComment(attraction: Attraction, cid:number): Observable<AttractionComment> {
    return this.http
      .delete<AttractionComment>(this.url + '/' + attraction.id + "/comments/"+ cid , this.getHttpOptions())
      .pipe(
        catchError((err: any) => {
          console.error(err);
          return throwError(
            () => new Error('ParkCommntService.update(): error adding ReplyParkComment: ' + err)
          );
        })
      );
  }
}
