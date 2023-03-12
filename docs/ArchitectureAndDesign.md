
## Architecture and Design

### Logical architecture
We decided to use the MVC (Model-View-Controller) architecture to organize and structure our project in a high-level logical way:

- *Model*: The models package contains the data structures and business logic of the application. It represents the state of the application and handles data manipulation and validation. The model interacts with the database or other external data sources to retrieve and persist data.

- *View*: The widgets package contains the user interface components of the application. It represents the views of the application and displays the data to the user. Widgets interact with the user and allow the user to interact with the application. They provide a visual representation of the data and facilitate user input.

- *Controller*: The screens package contains the controllers of the application. It mediates between the models and the widgets, handling user input and updating the view accordingly. The screen receives input from the user, updates the model accordingly, and then updates the view to reflect the changes. It also handles any business logic related to the user input.

In summary, the models package contains the data and business logic, the widgets package contains the user interface components, and the screens package mediates between the two, handling user input and updating the view and model as needed.

![LogicalView](../images/logicalArchitecture.png)

### Physical architecture
Our physical architecture is very simple. We just have two main entities featured: the client with the Rate IT app installed, and the database hosted by a Firebase server, where the user can retrieve all his important data.

![DeploymentView](../images/physicalArchitecture.png)

Regarding technologies used, we programmed in Flutter along with Firebase to store data on reviews, companies, formations and events. We chose Firebase for our database server because it easily integrates with Flutter and is simple to set up.

### Vertical prototype
To help on validating all the architectural, design and technological decisions made, we usually implement a vertical prototype, a thin vertical slice of the system.

In this subsection please describe which feature you have implemented, and how, together with a snapshot of the user interface, if applicable.

At this phase, instead of a complete user story, you can simply implement a feature that demonstrates thay you can use the technology, for example, show a screen with the app credits (name and authors).

