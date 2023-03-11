
## Architecture and Design
The architecture of a software system encompasses the set of key decisions about its overall organization. 

A well written architecture document is brief but reduces the amount of time it takes new programmers to a project to understand the code to feel able to make modifications and enhancements.

To document the architecture requires describing the decomposition of the system in their parts (high-level components) and the key behaviors and collaborations between them. 

In this section you should start by briefly describing the overall components of the project and their interrelations. You should also describe how you solved typical problems you may have encountered, pointing to well-known architectural and design patterns, if applicable.

### Logical architecture
We decided to use the MVC (Model-View-Controller) architecture to organize and structure our project in a high-level logical way:

- *Model*: The models package contains the data structures and business logic of the application. It represents the state of the application and handles data manipulation and validation. The model interacts with the database or other external data sources to retrieve and persist data.

- *View*: The widgets package contains the user interface components of the application. It represents the views of the application and displays the data to the user. Widgets interact with the user and allow the user to interact with the application. They provide a visual representation of the data and facilitate user input.

- *Controller*: The screens package contains the controllers of the application. It mediates between the models and the widgets, handling user input and updating the view accordingly. The screen receives input from the user, updates the model accordingly, and then updates the view to reflect the changes. It also handles any business logic related to the user input.

In summary, the models package contains the data and business logic, the widgets package contains the user interface components, and the screens package mediates between the two, handling user input and updating the view and model as needed.

![LogicalView](../images/logicalArchitecture.png)

### Physical architecture
The goal of this subsection is to document the high-level physical structure of the software system (machines, connections, software components installed, and their dependencies) using UML deployment diagrams (Deployment View) or component diagrams (Implementation View), separate or integrated, showing the physical structure of the system.

It should describe also the technologies considered and justify the selections made. Examples of technologies relevant for uni4all are, for example, frameworks for mobile applications (such as Flutter).

Example of _UML deployment diagram_ showing a _deployment view_ of the Eletronic Ticketing System (please notice that, instead of software components, one should represent their physical/executable manifestations for deployment, called artifacts in UML; the diagram should be accompanied by a short description of each node and artifact):

![DeploymentView](../images/physicalArchitecture.png)



### Vertical prototype
To help on validating all the architectural, design and technological decisions made, we usually implement a vertical prototype, a thin vertical slice of the system.

In this subsection please describe which feature you have implemented, and how, together with a snapshot of the user interface, if applicable.

At this phase, instead of a complete user story, you can simply implement a feature that demonstrates thay you can use the technology, for example, show a screen with the app credits (name and authors).

