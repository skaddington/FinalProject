import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ParkRatingComponent } from './park-rating.component';

describe('ParkRatingComponent', () => {
  let component: ParkRatingComponent;
  let fixture: ComponentFixture<ParkRatingComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [ParkRatingComponent]
    });
    fixture = TestBed.createComponent(ParkRatingComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
