export class ParkRatingId {

  userId: number;
  parkId: number;

  constructor(
    userId: number = 0,
    parkId: number = 0
  ){
    this.userId=userId;
    this.parkId=parkId;
  }
}
