# Spatial implementation of an asynchronous Rao-Blackwellized Particle Filter

A Rao-Blackwellized Particle Filter turned out to be an ambitious application, the most complex that was developed so far with Spatial. It is an embarrassingly parallel algorithm and hence can leverage the parallelizable benefits of an application-specific hardware design. Developping this, We gained some insights specific about the hardware implementation of such application and some others specific to the particularities of Spatial. At the time of the writing, some spatial incomplete codegen did not allow to synthesize fully the application but it ran correctly in the simulation mode and the area usage estimation fitted on a Zynq board.


## Area

The capacity of an FPGA is defined by the synthetizable area. **TODO**

## Parallel patterns

Parallel patterns [@prabhakar_generating_2016] **TO



## Controls flows 

Control flows (or flow of control) is the order in which individual statements, instructions or function calls of an imperative program are executed or evaluated.
Sequential
Parallel
Pipeline:
	Inner Pipe: Basic form of pipelining; Pipelining of primitive instructions.
	Coarse-Grain: Pipelining of parralel patterns
	Stream Pipe: ASAP with FIFOs stack or Streams: Stream(*)
	
**TODO**	

${lang-ref}

## Numeric types

Numbers can be represented in two ways: 

- **fixed-point**: In the fixed-point representation, an arbitrary number of bits I represent the integer value, an arbitrary number of bits D represent the decimal value. If the representation is signed, negative numbers are represented using 2's complement.

I defines the range (the maximum number that can be represented) and D defines the precision. The range is centered on 0 if the representation is signed.

In Spatial, the fixed-point type is declared by `FixPt[S: _BOOL, I: _INT, D: _INT]`.  
`_BOOL` is the typeclass of the types that represents a boolean. true and false types are `_TRUE` and `_FALSE`.   
Likewise for`_INT`,the typeclass of types that represent a literal integer. The integers from 0 to 64 have the corresponding types `_0`, `_1`, ..., `_64`.

- **floating-point**: In the floating-point representation, one bit represents the sign, an arbitrary number of bits E represent the exponent and an arbitrary number of bitsS represent the significand part.

In Spatial, the floating-point type is declared by `FltPt[S: _INT, E: _INT]`.  

By comparison, in the software world, the common available numeric types for integers are fixed points: `Byte` (8-bits), `Short` (16-bits), `Int` (32-bits), `Long` (64-bits)
and for real floating-point: `Float` (32-bits), `Double` (64-bits). 

The floating-point representation is required for some applications because its precision increase as we get closer to 0: the space between all representable numbers around 0 diminish whereas it is uniform over the whole domain for the fixed point representation. This can be extremely important to store probabilities (since joint probability when not normalized can be infinitesimally small), or to store the result of exponentiation of negative numbers (a small difference in value might represent a big difference pre-exponentiation), or to store the values of square (we need more precision the closest we are from 0 because the line of the real squared is more "dense" the closer we are from 0). However, floating-point operations utilize more ALU than fixed-point (an increase by an order of magnitude of around 2)

![Representable Real line and its corresponding floating-point representation](fltpt.jpg)

Fortunately, it is easy to define a type Alias to gather all the values that should share the same representation and then switch from floating-point to the fixed-point representation and tune the allocated number of bits by editing solely the type alias.

```scala
//only this line need to be edited to change the representation
type SmallReal = FixPt[_TRUE, _4, _16]

val a: SmallReal = ...
val b: SmallReal = ...
```

## vector and matrix module as stdlib

The state and uncertainty of a particle are a vector and a matrix (the matrix of covariance). All the operations involving the state and uncertainty, in particular Kalman prediction and Kalman update are matrix and vector operations. Kalman instance for instance, when written in the matrix form is reasonably compact in the matrix form but actually represent a significant amount of compute and operations. For the sake of code clarity, it is crucial to be able to keep being able to write matrix operations in a succinct syntax. Furthermore, matrix and vector operations are common need and it would be beneficial to write a reusable set of operations to Spatial. This is why a vector and matrix module was developed and added to the standard library of Spatial. It is the first module of the standard library whose purpose is to include all the common set of operations that are not part of the API of the primitives of the language.

### Views

### Meta-Programming

Test

## Mini Particle Filter

A "mini" particle Filter has been developed at first. This version is a plain particle filter so it is not conditionned on a latent variable and there is no kalman filtering, and thus no matrix operations. **TODO**
The full Mini Particle Filter source code application is contained in the [Appendix](#mini-particle-filter-1) and publicly available as a Spatial App on [github](https://github.com/stanford-ppl/spatial-apps/blob/develop/src/MiniParticleFilter.scala).

## Rao-Blackwellized Particle Filter

The full Rao-Blackwellized source code application is contained in the [Appendix](#rao-blackwellized-particle-filter-2) and publicly available as a Spatial App on [github](https://github.com/stanford-ppl/spatial-apps/blob/develop/src/RaoBlackParticleFilter.scala).
**TODO** explain the FSM queue

## Insights

- Changing the numeric type matter
- Doing in-place operation break pipelining
- Reducing the number of operation between first read and write is crucial 

## Conclusion

The Rao-Blackwellized Particle Filter is a complex application. It might have been impractical, almost to the point of unfeasibility to attempt to write it and keep an almost optimal retiming of the hardware design, in a timely manner for a single person.

# Conclusion {-}

We have presented in this work a novel approach to POSE estimation, its mathematical modeling, its implementation in Software and Hardware, and developed spatial tools, including a standalone data-flow simulation tool, to ease the Hardware implementation development and at the same time, improve the whole Spatial ecosystem. 



