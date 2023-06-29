import { TestBed } from '@angular/core/testing';

import { ParkPhotosService } from './park-photos.service';

describe('ParkPhotosService', () => {
  let service: ParkPhotosService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(ParkPhotosService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
