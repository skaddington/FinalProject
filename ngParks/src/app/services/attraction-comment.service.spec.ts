import { TestBed } from '@angular/core/testing';

import { AttractionCommentService } from './attraction-comment.service';

describe('AttractionCommentService', () => {
  let service: AttractionCommentService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(AttractionCommentService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
