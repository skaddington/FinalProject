import { ComponentFixture, TestBed } from '@angular/core/testing';

import { AttractionCommentComponent } from './attraction-comment.component';

describe('AttractionCommentComponent', () => {
  let component: AttractionCommentComponent;
  let fixture: ComponentFixture<AttractionCommentComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [AttractionCommentComponent]
    });
    fixture = TestBed.createComponent(AttractionCommentComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
