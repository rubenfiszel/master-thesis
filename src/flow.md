# A simulation tool for data flows with spatial integration: scala-flow

## Purpose

Data flows are intuitive visual representation and abstraction of computations. As all forms of representations and abstractions, they help manage complexity, and let engineers reason on a higher level. They are common in the context of embedded systems, and most forms of data processing, in particular those related to the so called *big data*.

Spark and Simulink are popular libraries for data processing and embedded systems respectively. Spark grew popular as an alternative to Hadoop. The advantages of Spark over Hadoop was, among others, in-memory communication between nodes (as opposite of through file) and a functionnally inspired scala api that brought better abstractions and greatly reduced the number of line of code.

Simulink by MathWorks on the other hand, is a graphical programming environment for modeling, simulating and analyzing dynamic systems including potentially embedded systems. Its primary interface is a graphical block diagramming tool and a customizable set of block libraries.

![An example of the simulink interface](simulink.png)

scala-flow is inspired by both of these tools. It is general purpose in the sense that it can be used to represent any dynamic systems. Nevertheless, its primary intended usage is to develop, prototype, and debug embedded systems that use hardware reprogrammed by spatial. scala-flow has a functional/composable api, displays the constructed graph, provide block constructions. It provides some strong type safety: the type of the input and output of each node is checked at compilation to ensure the soundness of the resulting graph.

## Source, Sink and Transformations

Data is under the form of "packets" containing a value of arbitrary type, an emission timestamp and the delays the packet has encountered through the different node processing. 

`case class Timestamped[A](t: Time, v: A, dt: Time)`

(They are called Timestamped because they represent the value with timestamp informations.)

Data get emitted from sources (nodes with no input), processed and tranformed by other nodes until they reach sinks (nodes with no output). The nodes are connected between each other in many forms.

Nodes all mix-in the common trait `Node`. Every nodes also mix-in the trait `Source[A]` whose type parameter `A` indicates the type parameters of the packets emitted by this node. Indeed, nodes can only have one output. Every nodes also minx-in the trait `SourceX[A, B, ...]` where X is the arity  of the number of input for that nodes and replace by the actual arity (1, 2, 3, ...). This is similar to `FunctionX` which is the type of functions in scala.

- `Source0` indicates that the node takes exactly 0 input.
- `Source1[A]` indicates that the node has 1 input whose packets are of type A. 
- `Source2[A,B]` indicates that the nodes has 2 inputs whose packets are respectively of type `A` and `B`
- etc ...

Since all nodes mix-in a `SourceX`, the compiler can check that the inputs of each node are of the right type.

All `SourceX` must define `def listenI(x: A)` where I goes from 1 to X and A correspond to the corresponding type parameter of `SourceX`. `def listenI(x: A)` defines the action to take whenever a packet is received from the input I. In most cases, it is a transformation of `x` followed by a broadcasting (with the function `def broadcast(x: R)`) to the nodes that have for source this node.

There is a special case, `SourceN[A, R]` which represent nodes that have *-arity of type `A` and emit packets of type `R`. For instance, the `Plot` nodes take * number of sources and display them all on the same plot. The only constraint is that all the source nodes must emit the same kind of data of type A. Else it would not make sense to compare them. For plot specifically, `A` has also a view bound of `Data` which means that there exists a conversion from `A` to a `Seq[Float]`, to ensure that `A` is displayable in a multiplot as timeseries. The x-axis, the time, correspond to the timestamp of emission contained in the packet.

An intermediary node that applies a transformation mixs-in the trait `OpX[A, B, ..., R]` where `A, B` is the type of the input, and `R` is the type of the output. Indeed, 

`OpX[A, B, ..., R] extends SourceX[A, B, ...] with Source[R]`.

For instance `zip(sourceA, sourceB)` is an `Op[A, B, (A, B)]`

## Demo 

Below is the scala-flow code corresponding to a data-flow that enable to compare a particle filter, an extended kalman filter, and the true state of the underlying model. At each tick of the different clocks, a packet containing the time as value is sent to nodes representing sensors. Those sensors have access to the model that is not represented here (the trajectory of the drone) and transform the time into noisy sensor measurements and forward them to the two filters. The packets once processed by the filters are plotted by the Plot sink. The plot also take as input the true state as given by the "toPoints" transformation.

```scala

  //****** Model ******
  val dtIMU   = 0.01
  val dtVicon = (dtIMU * 5)

  val covAcc    = 1.0 
  val covGyro   = 1.0 
  val covViconP = 0.1 
  val covViconQ = 0.1

  val numberParticles = 1200

  val clockIMU   = new TrajectoryClock(dtIMU)
  val clockVicon = new TrajectoryClock(dtVicon)

  val imu   = clockIMU.map(IMU(eye(3) * covAcc, eye(3) * covGyro, dtIMU))
  val vicon = clockVicon.map(Vicon(eye(3) * covViconP, eye(3) * covViconQ))

  lazy val pfilter = 
      ParticleFilterVicon(
        imu,
        vicon,
        numberParticles,
        covAcc,
        covGyro,
        covViconP,
        covViconQ
      )

  lazy val ekfilter = 
      EKFVicon(
        imu,
        vicon,
        covAcc,
        covGyro,
        covViconP,
        covViconQ
      )

  val filters = List(ekfilter, pfilter)

  val points = clockIMU.map(LambdaWithModel(
	(t: Time, traj: Trajectory) => traj.getPoint(t)), "toPoints")

  val pqs =  points.map(x => (x.p, x.q), "toPandQ")

  Plot(pqs, filters:_*)
```

![scala-flow program](empty.jpg)

```{.text samepage=true}
         ┌────────────────────┐ ┌────────────────────┐
         │TrajectoryClock 0.01│ │TrajectoryClock 0.05│
         └─────┬────────────┬─┘ └────────┬───────────┘
               │            │            │            
               v            v            v            
           ┌───────┐   ┌────────┐   ┌─────────┐       
           │Map IMU│   │toPoints│   │Map Vicon│       
           └──┬──┬─┘   └────┬───┘   └───┬──┬──┘       
              │  │          │           │  │          
              │  │          │    ┌──────┘  │          
              │  └──────────┼────┼─────────┼┐         
              └───────────┐ │    │         ││         
             ┌────────────┼─┘    │         ││         
             │            │      │         ││         
             v            v      v         vv         
         ┌───────┐ ┌───────────────────┐ ┌────────┐   
         │toPandQ│ │     RBPFVicon     │ │EKFVicon│   
         └───┬───┘ └──────────┬────────┘ └────┬───┘   
             │                │               │       
             └──────────────┐ │ ┌─────────────┘       
                            │ │ │                     
                            v v v                     
                          ┌───────┐                   
                          │ Plot  │                   
                          └───────┘                  
```				  

![Graph representation of the data-flow](empty.jpg)

## Block

A block is a node that actually represents a group of node. That node can be summarized by its input and output such that from an outside perspective, it can be considered as a simple node. Similar to the way an interface or an API hide its implementation details, a block hides its inner workings to the rest of the data-flow as long as the block process and emit the right type of packet. This logic extend to the graphical representation. Blocks are represented as nodes in the high-level graph but expanded in an independent graph below.

Similar to `OpX[A, B, ..., R]` , there exists `BlockX[A, B, ..., R]` which all extend `Block[R]` and take X sources as input. All `Block[R]` must define an out method of the form: `def out: Source[R]`.

The filters are block with the following signatures:

```scala
case class RBPFVicon(rawSource1: Source[(Acceleration, Omega)],
                     rawSource2: Source[(Position, Attitude)],
                     N: Int,
                     covAcc: Real,
                     covGyro: Real,
                     covViconP: Real,
                     covViconQ: Real)	
	extends Block2[(Acceleration, Omega), (Position, Attitude), (Position, Attitude)] {
	
		def imu = source1
		def vicon = source2
		
		def out = ...
	}
```

![Signature of the block of the particle filter](empty.jpg)

and similar for EKFVicon. 

The observant reader might notice that the above block take as arguments `rawSource` and not `Source` directly. However, the packets are incoming from `Source` (`def imu = source1`). This is a consequence of intermediary `Source` potentially needing to be generated during the graph creation to synchronize multiple scheduler together. 


## Buffer and cycles

## Source API

Here is a simplified description of the API of each source. 

When relevant, the functions have an alternative `methodNameT` function that takes themselves function whose domain is `Timestamped[A]` instead of `A`.

For instance, there is a  

`def foreachT(f: Timestamped[A] => Unit): Source[A]`

that is equivalent to the `foreach` below except it can access the additional fields in `Timestamped`

```scala

trait Source[A] {

  /** return a new source that map every incoming packet by the function f 
    * such that new packets are Timestamped[B] 
    */
  def map[B](f: A => B): Source[B]

  /** return a filtered source that only broadcast
    *  the elements that satisfy the predicate b */
  def filter(b: A => Boolean): Source[A]

  /** return this source and apply the function f to each
    *  incoming packets as soon as they are received 
    */
  def foreach(f: A => Unit): Source[A]
  
  /** return a new source that broadcast elements
    * until the first time the predicate b is not satisfied
    */
  def takeWhile(b: A => Boolean): Source[A]  
  
  /** return a new source that accumulate As into a List[A]
    * then broadcast it when the next packet from the other 
    * source clock is received 
    */
  def accumulate(clock: Source[Time]): Source[ListT[A]]
    
  /** return a new source that broadcast all element inside the collection
    * returned by the application of f to all incoming packet
    */
  def flatMap[C](f: A => List[C]): Source[C]
 
  /** assumes that A is a List[Timestamped[B]]. 
    * returns a new source that apply the reduce function 
    * over the collection contained in every incoming packet */
  def reduce[B](default: B, f: (B, B) => B)
      (implicit ev: A <:< ListT[B]): Source[B]
	  
  /** return a new source that broadcast pair of the packet from this source 
    * and the source provided as argument. Wait until a packet is received 
    * from both source. Packets from both source are queued such 
    * that independant of the order, they are never discarded
    * A2 B1 A3 B2 B3 B4 B5 A4=> (A1, B1), (A2, B2), (A3, B3), (A4, B4),
	* [Queue[B5]]
    */
  def zip[B](s2: Source[B]): Source[Boolean]


  /** return a new source that broadcast pair of the packet from this source 
    * and the source provided as argument. Similar to zip except that 
	* if multiple packets from the source provided as argument is received
	* before, all except the last get discarded.
    * A2 B1 A3 B2 B3 B4 B5 A4=> (A1, B1), (A2, B2), (A3, B3), (A4, B4),
	* [Queue[B5]]
    */
  def zipLastRight[B](s2: Source[B])

  
  /** return a new source that broadcast pair of the packet from this source 
    * and the source provided as argument. Similar to zip except that all 
	* packet except the last get discarded when both source are not in sync.
    * A1 A2 B1 A3 B2 B3 A4=> (A1, B1), (A3, B2), (B3, A4)
    */  
  def zipLast[B](s2: Source[B])

  /** return a new source that combine this source and the provided source .
    * packets from this source are Left
    * packets from the other source are Right
    */
  def merge[B](s2: Source[B]): Source[Either[A, B]]
  
  /** return a new source that fuse this source and the provided source
    * as long they have the same type.
    * any outgoing packet is indistinguishable of origin
    */  
  def fusion(sources: Source[A]*): Source[A]	  

  /** "label" every packet by the group returned by f */  
  def groupBy[B](f: A => B): Source[(B, A)]

  /** print every incoming packet */
  def debug(): Source[A]

  /** return a new source that buffer 1 element and 
    * broadcast the buffered element with the time of the incoming A 
    */
  def bufferWithTime(init: A): Source[A] 
  
  /** return a new source that do NOT broadcast any element */
  def muted: Source[A]

  /** return a new source that broadcast one incoming packet every 
    * n incoming packet.
    * The first broadcasted packet is the nth received one
    */
  def divider(n: Int): Source[A]

  /** return a pair of source from a source of pair */
  def unzip2[B, C](implicit ev: A <:< (B, C)): (Source[B], Source[C])
  
  /** return a new source whose every outgoing packet have an added dt
    * in their delay component
    */
  def latency(dt: Time): Source[A]

  /** return a new source whose broadcasted packets contain the time of 
    * emission
    */
  def toTime: Source[Time]

  /** return a new source that do NOT broadcast the first n packets */
  def drop(n: Int): Source[A]
}


implicit class TimeSource(source: Source[Time]) {

  /** stop the broadcasting after the timeframe tf has elapsed */
  def stop(tf: Timeframe): Source[Time]

  /** add a random delay following a gaussian with corresponding 
    * mean and variance */
  def latencyVariance(mean: Real, variance: Real): Source[Time]

  /** add a delay of dt */
  def latency(dt: Time): Source[Time]

  /** return a new source of the difference of time between 
    * the two last emitted packets */
  def deltaTime(init: Time = 0.0): Source[Time]
  
}

```

![API of the Sources](empty.jpg)

The real API includes also a `name` and `silent` parameter. Both are only relevant for the graphical representation. The name of the block will be overriden by name if present and the node will be skipped in the graphical representation if silent is present.

## Batch

A batch is a node that process its input in "batch" mode. All the other nodes process their input in "stream" mode. By "stream" mode, we mean that the node is able to process the input one-by-one, as soon as it arrives. The "batch" mode means that the node can only process i


## Scheduling

Scheduling is the core mechanism of scala-flow. Scheduling ensure that packets gets emitted by the sending nodes and received by the recipient nodes at the "right time". Since scala-flow is a simulation tool, the "scala-flow time" does not correspond at all to the real time. Scheduling emits the packets as fast as it can. Therefore, since time is an arbitrary component of the packet, the only constraint that scheduling must satisfy is emitting the packets from all nodes in the right order.

Scheduling is achieved by one or many Schedulers. Schedulers are essentially queue of actions. The actions are side-effect functions that emit packets to the right node by the intermediary of channels. In the trivial case where there is no Batch, only one scheduler is needed. 


## Replay

## Graph construction

### InitHook

### ModelHook

### NodeHook

To gather the nodes and their connection between each other, a `NodeHook` is used. Every node must have access to a `NodeHook` to add itself to the registry. For the nodes that take no input, the `Source0`, the `NodeHook` is passed as an implicit parameter. For the following nodes, the `NodeHook` is propagated since all others nodes use as `NodeHook` the one from their `source1`. This is similar to the way `Scheduler` are propagated through the graph.

### Graphical representation

The graphical representation is in the `ASCII` format. The library [ascii-graphs](https://github.com/mdr/ascii-graphs) is used to generate the output in `ASCII` from sets of vertices and edges.  The set of vertices and edges is retrieved from the set of nodes contained in `NodeHook`.

### FlowApp

A `FlowApp[A, B]` is an extension of the scala `App`. Its type parameters correspond to the type parameter of the `InitHook` and `ModelHook`

### Channel

A single FlowApp can be run multiple times

## Spatial integration

## Conclusion

**TODO**



