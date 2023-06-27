import { Component, Input } from '@angular/core';
import { Park } from 'src/app/models/park';

@Component({
  selector: 'app-park-comment',
  templateUrl: './park-comment.component.html',
  styleUrls: ['./park-comment.component.css']
})
export class ParkCommentComponent {

  @Input() selectedPark: Park | null = null;

}
