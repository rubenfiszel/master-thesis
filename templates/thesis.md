---
title: "Accelerated Sensor Fusion for Drones and a Simulation Framework for Spatial"
author: Ruben Fiszel
email: ruben.fiszel@epfl.ch
link-citations: true
abstract: "We present here a novel asynchronous Rao-Blackwellized Particle Filter for POSE estimation of drones and its implementation on hardware with the spatial language. We also present contributions to the spatial language under the form of development tools: scala-flow, a prototyping data-flow tool inspired by Simulink with a spatial integration. Finally, as a required component of scala-flow's spatial integration, an interpreter for the spatial language was also developed."
documentclass: report
toc-title: "Table of Contents"
pandoc-minted:
  language: scala
---


${rbpf}


${flow}


${interpreter}


${spatial}


# Acknowledgments {-}

Thank you to my parents for their continuous support, to Prof. Kunle and Prof. Odersky for supervising me and giving me the opportunity of doing this master thesis in their lab, to the entire lab of DAWN, in particular David Koeplinger, Raghu Prabhakar, Matt Feldman, Yaqi Zhang, Tian Zhao, Stefan Hadjis which accepted me as their peer for the length of my stay. I would also like to thank Nada Amin which supervised me in the semester project that led to this project and accepted to be an expert for the evaluation of the thesis. I am also grateful to the whole institution of EPFL for the education I have received those last 5 years and for which this thesis represents the culmination. Finally, to Stanford for having welcomed me for 6 months as a Visiting Researcher Student.

# Appendix {-}

## Mini Particle Filter

${minpf}

## Rao-Blackwellized Particle Filter

${rbpfc}

## Spatial syntax

${lang-ref}

# References {-}

