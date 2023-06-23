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
    states: any[] | undefined = []
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
  }
}
