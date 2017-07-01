# Spatial

## Exponential growth of performance is slowing down

Continuous exponential growth of processor performances have paved the way for the era of information we are living in. The next iteration of hardware would enable new applications and new transformations of society with them. Unfortunately, the Moore's law is slowly fading away to soon become a relic of the past (Scaling is predicted to become flat in 2020). For instance, the new generation (2017) of Intel i7 processor is only roughly 10% more efficient than the last.

## Reprogrammable Hardware to the rescue

This quest for efficiency through specialized hardware has gained important interest  as the 

Spatial is a compiler framework to generate hardware description code from a high-level DSL embedded in Scala ("The Spatial language") for reprogrammable hardware like FPGA or CGRA in order to make them run arbitrary user applications. In the hardware world, there is a tradeoff between performance [^Performance here designates performance by watt. Performance by watt is a good unit of measure to benchmark and compare vastly different architectures because it is one of the closest indicator of efficiency in its physical sense (the ratio energy in/energy out).] and flexibility. 

Prior to Spatial, the PPL lab was working on a project called Delite. Delite is an effort to write a compiler framework that leverage "parralel patterns". By parralel patterns, we mean that it is wishable for the programmer to let the compiler apply transformation to the source program to parralelize and optimize as much part as possible (a prime example is MapReduce).

Delite includes a compiler framework. Delite generate efficient code from high-level code with "parralel patterns" annotations written in DSL embedded in Scala. Delite generated code in Scala, C++, CUDA and also included a runtime under the form of a Delite Execution Graph (DEG) that acted as a "supervisor" for the heterogenous runtimes of the different generated languages (JVM, CUDA, x86) and hardware architectures. 

# Argon

Argon is a fork of LMS made by David Koeplinger for the specific needs of the PPL lab. 

One of the major complaint with the Delite project was the long compilation time
