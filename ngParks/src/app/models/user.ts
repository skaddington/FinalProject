import { Attraction } from "./attraction";
import { AttractionComment } from "./attraction-comment";
import { Park } from "./park";
import { ParkComment } from "./park-comment";
import { ParkPhoto } from "./park-photo";
import { ParkRating } from "./park-rating";

export class User {
  id: number;
  username: string;
  password: string;
  firstName: string;
  lastName: string;
  image: string;
  description: string;
  role: string;
  enabled: boolean;
  favoriteParks: Park[];
  attractions: Attraction[];
  attractionComments:AttractionComment[];
  parkComments: ParkComment[];
  parkRatings: ParkRating[];
  parkPhotos: ParkPhoto[];

  constructor(
    id: number = 0,
    username: string = '',
    password: string = '',
    firstName: string = '',
    lastName: string = '',
    image: string = '',
    description: string = '',
    role: string = '',
    enabled: boolean = false,
    favoriteParks: Park[] = [],
    attractions: Attraction[] = [],
    attractionComments:AttractionComment[]=[],
    parkComments: ParkComment[] = [],
    parkRatings: ParkRating[] = [],
    parkPhotos: ParkPhoto[] = []
  ) {
    this.id = id;
    this.username = username;
    this.password = password;
    this.firstName = firstName;
    this.lastName = lastName;
    this.image = image;
    this.description = description;
    this.role = role;
    this.enabled = enabled;
    this.favoriteParks = favoriteParks;
    this.attractions = attractions;
    this.attractionComments = attractionComments;
    this.parkComments = parkComments;
    this.parkRatings = parkRatings;
    this.parkPhotos = parkPhotos;
  }
}
