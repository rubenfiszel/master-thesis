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

### Parallel patterns

Parallel patterns ....

**TODO**

### Controls flows 

Control flows (or flow of control) is the order in which individual statements, instructions or function calls of an imperative program are executed or evaluated.
Sequential
Parallel
Pipeline:
	Inner Pipe: Basic form of pipelining; Pipelining of primitive instructions.
	Coarse-Grain: Pipelining of parralel patterns
	Stream Pipe: ASAP with FIFOs stack or Streams: Stream(*)
	
**TODO**	

## Memories


+-------+-----------------+-----+
|On-Chip|`FIFO[T](depth)`     |     |
+-------+-----------------+-----+
|On-Chip|                 |     |
+-------+-----------------+-----+
|On-Chip|                 |     |
+-------+-----------------+-----+
|On-Chip|                 |     |
+-------+-----------------+-----+
|       |                 |     |
+-------+-----------------+-----+
|       |                 |     |
+-------+-----------------+-----+
|       |                 |     |
+-------+-----------------+-----+
|       |                 |     |
+-------+-----------------+-----+
|       |                 |     |
+-------+-----------------+-----+
|       |                 |     |
+-------+-----------------+-----+
|       |                 |     |
+-------+-----------------+-----+
|       |                 |     |
+-------+-----------------+-----+
|       |                 |     |
+-------+-----------------+-----+
|       |                 |     |
+-------+-----------------+-----+


## Numeric types

## A matrix library as stdlib


## Mini Particle Filter


## Rao Blackwellized Particle Filter


# Conclusion {-}

alea jacta est



## References

