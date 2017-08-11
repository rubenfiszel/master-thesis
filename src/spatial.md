# Spatial implementation of an asynchronous Rao-Blackwellized Particle Filter

A Rao-Blackwellized Particle Filter turned out to be an ambitious application, the most complex that was developed so far on Spatial. We gained some insights specific to the application and some others specific to the particularities of Spatial. At the time of the writing, some spatial bugs did not allow to synthesize fully the application but it ran correctly in the simulation mode and the area usage fitted on a Zynq board.




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



## Spatial syntax

	[A reference of the language is provided in the Annex](#spatial-syntax-1)

## Numeric types

Numbers can be represented in two ways: fixed-point and floating-point. In the fixed-point representation, some fixed number of bits I are attributed to the integer value and some other fixed number of bits D are attributed to the decimal value and 1 bit is added at the beginning to represent the sign if the representation is signed such that the number represented is:

Unsigned:
$$\sum^{i=0}_I 2^{I-i}*b_i + \sum^{i=D}_{I+D} 2^{-(i-D+1)}*b_i$$

Signed:
$$ -1^b_0 +  \sum^{i=1}_{I+1} 2^{I-i}*b_i + \sum^{i=D+1}_{I+D+1} 2^{-(i-D+1)}*b_i$$

I defines the range (the maximum number that can be represented) and D defines the precision. The range is centered on 0 if the representation is signed.

For software, the common available numeric types for integers are: 

- `Byte` (8-bits)
- `Short` (16-bits)
- `Int` (32-bits)
- `Long` (64-bits)

Integers are whole numbers or fixed-point numbers with the radix point fixed after the least-significant bit. T

and for reals:
- `Float` (32-bits) 
- `Double` (64-bits)

Reals 

In Hardware, different numeric types exists.


## A matrix library as stdlib

### Views

### Meta-Programming

Test

## Mini Particle Filter

A "mini" particle Filter has been developed at first. This version is a plain particle filter so it is not conditionned on a latent variable and there is no kalman filtering, and thus no matrix operations.
The full Mini Particle Filter source code application is contained in the [Appendix](#mini-particle-filter-1) and publicly available as a Spatial App on [github](https://github.com/stanford-ppl/spatial-apps/blob/develop/src/MiniParticleFilter.scala).

## Rao-Blackwellized Particle Filter

The full Rao-Blackwellized source code application is contained in the [Appendix](#rao-blackwellized-particle-filter-2) and publicly available as a Spatial App on [github](https://github.com/stanford-ppl/spatial-apps/blob/develop/src/RaoBlackParticleFilter.scala).

## Conclusion

The Rao-Blackwellized Particle Filter is a complex application. It might have been impractical, almost to the point of unfeasibility to attempt to write it and keep an almost optimal retiming of the hardware design, in a timely manner for a single person.

# Conclusion {-}

We have presented in this work a novel approach to POSE estimation, its mathematical modeling, its implementation in Software and Hardware, and developed spatial tools, including a standalone data-flow simulation tool, to ease the Hardware implementation development and at the same time, improve the whole Spatial ecosystem. 



