import { Component, EventEmitter, Input, Output } from '@angular/core';
import { NonNullableFormBuilder } from '@angular/forms';
import { Attraction } from 'src/app/models/attraction';
import { User } from 'src/app/models/user';

@Component({
  selector: 'app-attraction',
  templateUrl: './attraction.component.html',
  styleUrls: ['./attraction.component.css']
})
export class AttractionComponent {
@Input() selectedAttraction:Attraction|null=null;




displayAllAttractions() {
  console.log(this.selectedAttraction?.attractionComments);
  this.selectedAttraction = null;
  this.handleDeselectAttraction(this.selectedAttraction);
}

  @Output() deselectAtraction: EventEmitter<null> = new EventEmitter<null>();
  handleDeselectAttraction(selectedAttraction: null) {
    this.deselectAtraction.emit(selectedAttraction);
  }


}
