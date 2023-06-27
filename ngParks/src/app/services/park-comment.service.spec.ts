import { TestBed } from '@angular/core/testing';

import { ParkCommentService } from './park-comment.service';

describe('ParkCommentService', () => {
  let service: ParkCommentService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(ParkCommentService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
