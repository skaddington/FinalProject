import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { AuthService } from './auth.service';
import { ParkComment } from '../models/park-comment';
import { environment } from 'src/environments/environment';
import { Observable, catchError, throwError } from 'rxjs';
import { Park } from '../models/park';

@Injectable({
  providedIn: 'root'
})
export class ParkCommentService {
  private url = environment.baseUrl + 'api/parks';
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

  addComment(park: Park, comment:ParkComment): Observable<ParkComment> {
    comment.user = null;
    comment.park = null;
    return this.http
      .post<ParkComment>(this.url + '/' + park.id + "/comments" , comment, this.getHttpOptions())
      .pipe(
        catchError((err: any) => {
          console.error(err);
          return throwError(
            () => new Error('ParkCommntService.update(): error adding ParkComment: ' + err)
          );
        })
      );
  }

  addReply(park: Park, cid:number, reply:ParkComment): Observable<ParkComment> {
    reply.user = null;
    reply.park = null;
    return this.http
      .post<ParkComment>(this.url + '/' + park.id + "/comments/"+ cid , reply, this.getHttpOptions())
      .pipe(
        catchError((err: any) => {
          console.error(err);
          return throwError(
            () => new Error('ParkCommntService.addReply(): error adding ReplyParkComment: ' + err)
          );
        })
      );
  }

  deleteComment(parkId: Number, cid:number): Observable<ParkComment> {
    return this.http
      .delete<ParkComment>(this.url + '/' + parkId + "/comments/"+ cid, this.getHttpOptions())
      .pipe(
        catchError((err: any) => {
          console.error(err);
          return throwError(
            () => new Error('ParkCommntService.delete(): error deleting ParkComment: ' + err)
          );
        })
      );

  }



}
