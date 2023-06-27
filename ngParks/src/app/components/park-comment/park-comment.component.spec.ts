import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ParkCommentComponent } from './park-comment.component';

describe('ParkCommentComponent', () => {
  let component: ParkCommentComponent;
  let fixture: ComponentFixture<ParkCommentComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [ParkCommentComponent]
    });
    fixture = TestBed.createComponent(ParkCommentComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
