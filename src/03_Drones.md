# Drones

## The attempt of a definition

The definition of a drone is ambiguous because it relies around the concept of being unmanned or autonomous. If the former criteria, being unmanned was enough, then any remote controlled object with movement abilities could be qualified as drone. However, toys RC car that children play with are not typically qualified as "drones". 

![A drone ?](images/rc-car.jpg){width="50%"} 

The second criteria, autonomy might help us to draw the line. In the rest of this work, we will consider drone any vehicles with both the ability to move itself in its surrounding environment and sufficient and reasonnable autonomy to keep its integrity without requiring external signals.

![A drone !](images/predator.jpg){width="50%"} 

The usage of drones have exponentially increased thanks to the recent improvements in battery capacities  and onboard computation power.

Drones come in many forms but in particular:

* UAV (unmanned aerial vehicles): Planes, helicopters (single rotor or multirotors), VTOL (vertical takeoff and landing), Missiles, etc ...
* UGV (unmanned ground vehicles): Mars rover, Cars, Tanks, etc ...
* USV (unmanned surface vehicles): Ships
* UUV (unmanned underwater vehicles): Submarines

The drones that are gonna be the focus of this work are multirotor helicopters. 

### Multirotor

Multirotors helicopters can hover and have more degree of freedom than any other aerial vehicles.
A quadcopter is non-holonomic. It can achieve 6 degrees of freedom (Three translational and three rotational), but only by planning maneuvers that make use of its 4 controllable degrees of freedom.

![Quadcopter 4 controllable  degrees of freedom](images/quad-dof.png){width="80%"} 

Leveraging these abilities, Multirotors have many potential applications such as:

* Search and rescue: Fast to deploy, insensitive to biological hazards, can use specific sensors to find humans to rescue
* Monitoring: helping farmers by flying over their fields and use specific imagery techniques to monitor their health
* Filming: track, follow and film athletes, amateurs or actors.
* Delivery: Deliver urgent and critical goods (medicaments) in remote areas  or conventional goods in less populated areas.
* Surveillance: Parking lots safety agents, border control, etc ...
* Military: The wars and conflict of tomorrow will be fought unmanned.
* Transport: The future car ?

However, in order to be really useful they will have to achieve a certain level of autonomy

## The quest for autonomy

Autonomy for a drone is achieved through fullfilling objectives without human intervention (expressible also as a cost to minimize). Ultimately, those objectives themselves, as abstract as they can be, are still defined by humans. 

Once the objectives have been defined, humans interventions are only required to define a change of objective or to take back manual control of the vehicle. One of the most important and known problem to solve is "autonomous driving". This problem is itself composed of trajectory planning and following. Trajectory following

### Embedded systems

### SLAM

SLAM stands for *Simultaneous localization and mapping*




