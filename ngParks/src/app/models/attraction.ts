export class Attraction {
  id: number;
  name: string;
  description: string;
  createdAt: Date | null;
  updatedAt: Date | null;
  image: string;
  website: string;
  enabled: boolean;

  constructor(
    id: number = 0,
    name: string = '',
    description: string = '',
    createdAt: Date | null = null,
    updatedAt: Date | null = null,
    image: string = '',
    website: string = '',
    enabled: boolean = true
  ) {
    this.id = id;
    this.name = name;
    this.description = description;
    this.createdAt = createdAt;
    this.updatedAt = updatedAt;
    this.image = image;
    this.website = website;
    this.enabled = enabled;
  }
}
