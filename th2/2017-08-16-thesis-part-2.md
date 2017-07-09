---
title: "Master thesis Pt II: A simulation tool for scala with spatial integration: scala-flow"
author: Ruben Fiszel
affiliation: Stanford University
email: ruben.fiszel@epfl.ch
date: August 2017
link-citations: true
---

This post is the part II out of III of my master thesis at the [DAWN lab](http://dawn.cs.stanford.edu/), Stanford. This part is about scala-flow, a simulation library with a spatial-lang integration written to ease the prototyping, development and testing of applications that can be represented as data flows with some subpart going through spatial written accelerators.

# Pt II: A simulation tool for scala with spatial integration: scala-flow

## Purpose

## Source, Sink and Transformations

## Flow graphical representation

## Buffer and cycles

## Data

## Source API

### FP

Here is a simplified description of the API of each source.

```scala

trait Source[A] {

	def foreach(f: A => Unit): Source[A]
	def foreachT(f: Timestamped[A] => Unit): Source[A]
	
	def filter(b: A => Boolean): Source[A]
	def filterT(b: Timestamped[Boolean]): Source[A]	
	
	def takeWhile(b: A => Boolean): Source[A]
	def takeWhileT(b: Timestamped[A] => Boolean): Source[A] 
	
	def drop(n: Int): Source[A]		
	
	def muted: Source[A]	
	
	def accumulate(clock: Source[Time]): Source[ListT[A]]
	
	def reduce[B](default: B, f: (B, B) => B)
		(implicit ev: A <:< ListT[B]): Source[B]
	def reduceT[B](default: B,
		          f: (Timestamped[B], Timestamped[B]) => Timestamped[B])
		(implicit ev: A <:< List[Timestamped[B]]): Source[B]

	def groupBy[B](f: A => B): Source[(B, A)]
    def groupByT[B](f: Timestamped[A] => B): Source[(B, A)]	
  
	def debug(): Source[A]

	//USE ONLY WHEN THERE IS NO LOOP INVOLVED
	def buffer(init: A): Buffer[A]

	//Get old A but with the time of the new A
	def bufferWithTime(init: A): Buffer[A]

	def map[B](f: A => B): Source[B]
	def mapT[B](f: Timestamped[A] => B): Source[B]

	def flatMap[C](f: A => List[C]): Source[C]
	def flatMapT[C](f: Timestamped[A] => List[Timestamped[C]]): Source[C]	

	//Divide the frequency of the stream by n
	def divider(n: Int)

	//Zip everthing
	// A1 A2 B1 A3 B2 B3 B4 B5 A4
	// => (A1, B1), (A2, B2), (A3, B3), (A4, B4), [Queue[B5]]
	def zip[B](s2: Source[B])	
	def zipT[B](s2: Source[B])

	def unzip2[B, C](implicit ev: A <:< (B, C)): (Source[B], Source[C]) 

	//Only zip the last of the right
	// A1 A2 B1 A3 B2 B3 B4 B5 A4=> (A1, B1), (A2, B2), (A3, B3), (A4, B5)
	def zipLastRight[B](s2: Source[B])
		: Source[(Timestamped[A], Timestamped[B])]	
	def zipLastRightT[B](s2: Source[B])
		: Source[(Timestamped[A], Timestamped[B])]	
	
	//Only zip the last pair
	// A1 A2 B1 A3 B2 B3 A4=> (A1, B1), (A3, B2), (B3, A4)
	def zipLast[B](s2: Source[B])
		: Source[(Timestamped[A], Timestamped[B])]	
	def zipLastT[B](s2: Source[B])
		: Source[(Timestamped[A], Timestamped[B])]	
  
	def merge[B](s2: Source[B]): Source[Either[A, B]]
	
	def fusion(sources: Source[A]*): Source[A]
	
	def latency(dt: Time): Source[A]
	
	def toTime: Source[Time]

}

class TimeSource(source: Source[Time]) {

  def stop(tf: Timeframe): Source[Time]

  def latencyVariance(mean: Real, std: Real): Source[Time]
  
  def latency(dt: Time): Source[Time] 
  
  def deltaTime(init: Time = 0.0): Source[Time]
  
}

class DataSource[A: Data](source: Source[A]) {

  def labelData(f: Time => A): Source[LabeledData[A]]
  
}
```

The real API includes also a name and silent parameter. Both are useful for the graphical representation. The name of the block will be overriden by name if present and it will be skipped if silent is present.

## Block

## Scheduling

## Batch

## Replay

## Spatial integration

## Conclusion

**TODO**

## References



