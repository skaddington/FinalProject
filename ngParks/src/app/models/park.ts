import { Activity } from "./activity";
import { Attraction } from "./attraction";
import { ParkComment } from "./park-comment";
import { ParkPhoto } from "./park-photo";
import { ParkRating } from "./park-rating";
import { User } from "./user";

export class Park {
  id: number;
  name: string;
  dateEstablished: Date | undefined;
  description: string;
  image: string;
  website: string;
  street: string;
  city: string;
  state: string;
  zip: string;
  states: any[] | undefined;
  activities: Activity [];
  attractions: Attraction[];
  users: User [];
  parkPhotos: ParkPhoto[];
  parkComments: ParkComment [];
  parkRatings: ParkRating[];

  constructor(
    id: number = 0,
    name: string = '',
    dateEstablished: Date | undefined = undefined,
    description: string = '',
    image: string = '',
    website: string = '',
    street: string = '',
    city: string = '',
    state: string = '',
    zip: string = '',
    states: any[] | undefined = [],
    activities: Activity [] = [],
    attractions: Attraction[] = [],
    users: User [] = [],
    parkPhotos: ParkPhoto[] = [],
    parkComments: ParkComment [] = [],
    parkRatings: ParkRating[] = []
  ) {
    this.id = id;
    this.name = name;
    this.dateEstablished = dateEstablished;
    this.description = description;
    this.image = image;
    this.website = website;
    this.street = street;
    this.city = city;
    this.state = state;
    this.zip = zip;
    this.states = states;
    this.activities = activities;
    this.attractions = attractions;
    this.users = users;
    this.parkPhotos = parkPhotos;
    this.parkComments = parkComments;
    this.parkRatings = parkRatings;
  }
}
