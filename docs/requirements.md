
## Requirements

### Domain model

To better understand the context of the software system, it is very useful to have a simple UML class diagram with all the key concepts (names, attributes) and relationships involved of the problem domain addressed by your module. 
Also provide a short textual description of each class. 

- `Event`: Represents an event with a start and end date.
- `Company`: Represents an IT Formation.
- `Formation`: Represents the process of forming a company.
- `User`: Represents a user with email and password login information. Represents an individual user. A person user can review IT Entitys.
- `Profile`: Represents a user's profile information, including their profile picture, name, and nickname. All nicknames are unic
- `Review`: Represents a user's review of an IT Entity, including a comment. Other users can upvote or downvote the review.
- `ITEntity`: Represents an IT entity, such as a software or hardware company, including its name, logo, description, and location.


![Domain model](../images/domainModel.png)
