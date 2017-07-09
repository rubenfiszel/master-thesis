---
title: "Master thesis Pt I: Accelerated optimal sensor fusion algorithm for POSE estimation of drones: Asynchronous Rao-Blackwellized Particle filter"
author: Ruben Fiszel
affiliation: Stanford University
email: ruben.fiszel@epfl.ch
date: June 2017
link-citations: true
---

# Context

This post is the part I out of III of my master thesis at the [DAWN lab](http://dawn.cs.stanford.edu/), Stanford. The central themes of this thesis are sensor fusion and spatial, an hardware accelerator language (Verilog is also one). This part is about an application of hardware acceleration, sensor fusion for drones. Part II will be about [scala-flow](https://github.com/rubenfiszel/scala-flow/), a library made during my thesis as a development tool for Spatial inspired by Simulink. This library eased the development of the filter but is also intended to be general purpose. Part III will be the development of an interpreter for spatial, and the spatial implementation of the RBPF presented in Part I. If you are only interested in the filter, you can skip the introduction.

${rbpf}
