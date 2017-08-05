# An interpreter for spatial

## Spatial: An Hardware Description Language

Building applications is only made possible thanks to the many layers of abstractions that start fundamentally at the level of electrons. It is easy to forget how much of an exceptional feat of engineering.

![An Hardware vs Software abstraction layers overview](hwsfoverview.pdf)

An Hardware Description Language (HDL) is used to describe the circuits on which applications runs on. A Software programming language is used to describe the applications themselves. Fundamentally, their purpose is different. But with a sufficient level of abstraction, they share many similarities. 

`c := a + b` would translate in software by an instruction to store in the memory (stack or heap) the sum of `a` and `b` stored themselves somewhere in memory. In hardware, depending on whether `c` represents a wire, a register, a memory location in SRAM or DRAM, the circuit is changed. However, from the user perspective, the source code is the same. One could think that it would be possible to write Hardware the same way than Software, but it is delusional. Some concepts are tied to the intrinsic nature of Hardware and inexpressible in the world of Software. A DSL that would abstract away those differences would result in a great loss of control for the user. Nevertheless, with the right level of abstraction it is possible to at least bridge the gap to a level satisfying for both the Software and Hardware engineers. This is the motivation behind Spatial.

Spatial is an (HDL) born out of the difficulties and complexity of doing Hardware. An HDL compiles to RTL which is equivalent to assembly in the software world and then the RTL is synthesized as Hardware (either as ASIC or as a bitstream reconfiguration data). The current alternatives available are Verilog, VHDL, Chisel and many others. What set apart Spatial from the crowd is that Spatial has a higher level of abstraction by leveraging parallel patterns and abstracting control flows as language constructs. Parallel patterns and control flows are detailed in Part IV.

## Argon

Spatial is built on top of Argon, a fork of Lightweight Modular Staging (LMS). Argon and LMS are scala libraries that enable staged programming (or also called staged meta-programming). Argon lets user write meta-programs that are programs generators: programs that generate other programs. 

Using Argon, language designer can specify a domain specific language and write their custom compiler for it.
- **two-staged**: 
- **heterogenous**: The 

**TODO**

## Simulation in Spatial

## Benefits of the interpreter

Building an interpreter for Spatial was a requirement for having a spatial integration in scala-flow. But it also benefits the whole spatial ecosystem. Indeed, an interpreter encourage the user to have more interactions with the language.

## Interpreter
