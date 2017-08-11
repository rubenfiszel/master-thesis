---
title: "[thesis IV] The spatial implementation of a Rao-Blackwellized Particle Filter"
author: Ruben Fiszel
affiliation: Stanford University
email: ruben.fiszel@epfl.ch
date: June 2017
link-citations: true
---

### About

This post is the part IV out of IV of my [master thesis](assets/thesis.png) at the [DAWN lab](http://dawn.cs.stanford.edu/), Stanford, under [Prof. Kunle](http://arsenalfc.stanford.edu/kunle) and [Prof. Odersky](http://lampwww.epfl.ch/~odersky/) supervision. The central themes of this thesis are sensor fusion and spatial, an hardware description language (Verilog is also one, but tedious). 

This part is about the spatial implementation of the asynchronous Rao-Blackwellized Particle filter presented in part I.

# Spatial implementation of an asynchronous Rao-Blackwellized Particle Filter

A Rao-Blackwellized Particle Filter turned out to be an ambitious application, the most complex that was developed so far on Spatial. We gained some insights specific to the application and some others specific to the particularities of Spatial. At the time of the writing, some spatial bugs did not allow to synthesize fully the application but it ran correctly in the simulation mode and the area usage fitted on a Zynq board.

## Language primitives

+-----------------------------------------+--------------------------------------------+
|                   Syntax                |                                            |
|                                         |                                            |
+=========================================+============================================+
|`min until max [by stride]`$~~~~~~~~~~~$ |Declares a counter                          |
|$~~~~~~~$`[par factor]`                  |                                            |
| **or** `min::max [par factor]`          |                                            |
|$~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~$|                                            |
+-----------------------------------------+--------------------------------------------+
|`FSM(init)(continue)`$~~~~~~~~~~~~~~~~~$ |Declares an FSM whose init state is `init`, |
|$~~~~~~~$`{action}{next}`                |transifit                                   |
|$~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~$|                                            |
+-----------------------------------------+--------------------------------------------+
|`Foreach(counter+){body}`                |                                            |
|$~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~$|                                            |
+-----------------------------------------+--------------------------------------------+
|`Reduce(accum)(counter+)`$~~~~~~~~~~~~~~$|                                            |
|$~~~~~~~$`{func}{reduce}`                |                                            |
|$~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~$|                                            |
+-----------------------------------------+--------------------------------------------+
|`MemReduce(accum)(counter+)`$~~~~~~~~~~~$|aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa          |
|$~~~~~~~$`{func}{reduce}`                |                                            |
|$~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~$|                                            |
+-----------------------------------------+--------------------------------------------+
|`Stream(*){body}`                        |                                            |
|$~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~$|                                            |
+-----------------------------------------+--------------------------------------------+
|`Parallel{body}`                         |                                            |
|$~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~$|                                            |
+-----------------------------------------+--------------------------------------------+
|`Pipe{body}`                             |                                            |
|$~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~$|                                            |
+-----------------------------------------+--------------------------------------------+
|`if (cond) {body}`$~~~~~~~~~~~~~~        |                                            |
|`[else if(cond) {body}`                  |                                            |
|`[else {body}]`                          |                                            |
+-----------------------------------------+--------------------------------------------+




## Parallel patterns

Parallel patterns [@prabhakar_generating_2016,]



## Controls flows 

Control flows (or flow of control) is the order in which individual statements, instructions or function calls of an imperative program are executed or evaluated.
Sequential
Parallel
Pipeline:
	Inner Pipe: Basic form of pipelining; Pipelining of primitive instructions.
	Coarse-Grain: Pipelining of parralel patterns
	Stream Pipe: ASAP with FIFOs stack or Streams: Stream(*)
	
**TODO**	



## Memories

### On-Chip

+-----------------------------------------+--------------------------------------------+
|                   Syntax                |                                            |
|                                         |                                            |
+=========================================+============================================+
|`FIFO[T](depth)`                             |                                            |
+-----------------------------------------+--------------------------------------------+
|                                         |                                            |
+-----------------------------------------+--------------------------------------------+
|                                         |                                            |
+-----------------------------------------+--------------------------------------------+
|                                         |                                            |
+-----------------------------------------+--------------------------------------------+
|                                         |                                            |
+-----------------------------------------+--------------------------------------------+
|                                         |                                            |
+-----------------------------------------+--------------------------------------------+


### Off-Chip

+-----------------------------------------+--------------------------------------------+
|                   Syntax                |                                            |
|                                         |                                            |
+=========================================+============================================+
|`FIFO[T](depth)`                             |                                            |
+-----------------------------------------+--------------------------------------------+
|                                         |                                            |
+-----------------------------------------+--------------------------------------------+
|                                         |                                            |
+-----------------------------------------+--------------------------------------------+
|                                         |                                            |
+-----------------------------------------+--------------------------------------------+
|                                         |                                            |
+-----------------------------------------+--------------------------------------------+
|                                         |                                            |
+-----------------------------------------+--------------------------------------------+

## Numeric types

FixPt vs FltPt 

## A matrix library as stdlib

### Views

### Meta-Programming

## Mini Particle Filter

The full Mini Particle Filter source code application is contained in the Appendix and publicly available as a Spatial App on [github](https://github.com/stanford-ppl/spatial-apps/blob/develop/src/MiniParticleFilter.scala).

## Rao-Blackwellized Particle Filter

The full Rao-Blackwellized source code application is contained in the [Appendix](#rao_blackwellized-particle-filter-3) and publicly available as a Spatial App on [github](https://github.com/stanford-ppl/spatial-apps/blob/develop/src/RaoBlackParticleFilter.scala).

## Conclusion

# Conclusion {-}





## References

