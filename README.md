# Final Project - Full-Stack - National Parks Travel App

## Team Members
* Jennifer Kalkowski - Scrum Master
* Patrick Hansen - Database Administrator
* Samantha Addington - Repo Owner

## Objectives

* **What is the End Goal?**
<p>
We wanted to create an application that would allow a user to browse the national parks and their surrounding attractions.
This allows a user to determine if the trip is worth it and help in planning what else they'd like to do while in the area.

* **User Story 1 :**
<p>

	A User that is NOT logged in has the options to:
	 	* Create a new User Account
	 	* Login using an existing Account.
	 	* View National Parks stored in the MySQL Relational Database
	 	* View a carosel of pictures of Parks stored in the Database
	 	* View a gallery of User Submitted Pictures of Parks stored in the database.
	 	* Click the link to view details for existing Parks stored in the Database
	 	* View The About the Developers page

* **User Story 2 :** 
<p>

	A Logged in User can:
		* View their Account page
		* View Other Users Account Page
		* Update their Account page Details
		* View a carousel of pictures of Parks stored in the Database
	 	* Click the link to view details for existing Parks stored in the Database
	 	* Leave Comments or Reply to existing comments on the Park Details page
	 	* Disable Comments AND Replies they have left on the Park Details page
	 	* Provide a Rating for Parks
	 	* Add Parks from the database to a list of Favorite Parks they enjoyed
	 	* Remove Parks from their Favorites List
	 	* Disable their Own Account
	 	* Logout


* **User Story 3 :** 
<p>
	
	A Logged in Admin can:
		* Perform ALL actions of a Logged in User EXCEPT disabling their own account
		* View all Users stored in the Database
		* Disable or Enable Users in the Database
		* View the Account page of All Users
		* Disable comments of other users

## Workflow

* **MySql Workbench -> Database Schema -> ER Diagram :**
	![](DB/parksdbSchema.png)

* **JPA & REST -> Paths :**
	| HTTP Verb | URI                  | Request Body | Response Body | Purpose |
	|-----------|----------------------|--------------|---------------|---------|
	| POST| `/api/register`      | Representation of New User resource   |Description of Operation Results | Representation of a new _User_ resource |
	| GET | `/api/authenticate` | Username and Password fields of _User_ resource | Representation of _User_ resource | Retrieve representation of _User_ resource|
	| GET | `/api/users` |  |Representation of all _User_ resources | **Retrieve** endpoint |
	| GET | `/api/users/1` |  | Representation of _User_ `1` | **Retrieve** endpoint |
	| PUT | `/api/users/2`   | Representation of a new version of _User_ `2` | | **Replace** endpoint |
	| DELETE | `/api/users/{UserId}` | | Description Of Results of Operation | **Delete** endpoint |
	| PUT | `/api/users/{ParkId}/parks` | | Representation of a new version of _User_ Resource | **Update** endpoint|
	| PUT | `/api/users/parks{ParkId}` | | Representation of a new version of _User_ Resource | **Update** endpoint |
	| GET | `/api/parks` | | Representation of All _Park_ Resources | **Retrieve** endpoint |
	| GET | `/api/parks/10`   || Representation of _Park_ `10` | **Retrieve** endpoint |
	| PUT | `/api/parks/{ParkId}` | Representation of new Version of _Park_ Resource | Representation of new Version of _Park_ Resource | **Update** endpoint |
	| GET | `api/parks/{parkId}/comments` | | Representation of _ParkComment_ resources related to _Park_ Resource | **Retrieve** endpoint |
	| POST | `/api/parks/parkId/comments` | Representation of a new _ParkComment_ resource | Description of the result of the operation | **Create** endpoint |
	| DELETE | `/api/parks/{parkId}/comments/{commentId}`| | Description of operation Results | **Delete** endpoint |
	| POST | `/api/parks/{parkId}/comments/{commentId}` | Representation of new _ParkComment_ resource | | **Create** endpoint |
	| POST | `/api/parks/{ParkId}/ratings` | Representation of new _ParkRating_ Resource | Representation of new _ParkRating_ Resource | **Create** endpoint |
	| GET | `/api/parkPhotos` | | Representation of All _Park_ Resources | **Retrieve** endpoint
	| GET | `/api/parkPhotos/{stateName}`|  | Representation of All _ParkPhoto_ resources in relation to _State_ resource | **Retrieve** endpoint |
	| GET | `/api/states` | | Representation of all _State_ Resources | **Retrieve** endpoint |
	| GET | `/api/attractions/{attrId}` | | Representation of _Attraction_ Resource | **Retrieve** endpoint |
	| GET | `/api/attractions/{attrId}` | | Representation of _AttractionComment_ Resources related to _Attraction_ Resource | **Retrieve** endpoint |
	| POST | `/api/attractions/{attrId}/comments` | Representation of new _AttractionComment_ Resource | | **Create** endpoint |
	| POST | `/api/attractions/{attrId}/comments/{commentId}` | representation of new _AttractionComment_ Resource | | **Create** endpoint |

* **Visual Studio Code -> Angular -> Front-End Development & Design:**
	![](ngParks/images/homePageScreenshot.png)

## Technologies Used
* Spring Tool Suite - Spring JPA, Spring Boot, Spring REST Framework, Spring Security
* MySQL, CRUD, MySQL Workbench
* Gradle, Dependencies
* HTML, JPA Repositories, POJO, Service, ServiceImpl, JUnit Tests
* Hibernate, Jackson, and other Annotations
* Visual Studio Code - Angular
* Angular - Components, Services, Models, Pipes
* Bootstrap, CSS, ngModel, ngIf, ngFor
* Github, EC2
* Google - Stack Overflow, MDN, MySQL Workbench Manuals, Angular, Spring
* TA help (Thank you!)

## Lessons Learned
* JPA Repositories, REST Controllers
* Spring Security
* Angular with Authentication
* MySQL Workbench
* Most Prominent BrainBlocks
<br>- Adding a park to a user's list of favorite parks: eventually we figured out that the Join Column and Inverse Join Column were backwards in the Many to Many annotations in the User Entity. This situation actually occured a few times throughout the project.
<br>- Determining whether to use JSON Ignore and JSON Ignore Properties in particular situations.
