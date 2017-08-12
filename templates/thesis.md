---
title: "Accelerated Sensor Fusion for Drones and a Simulation Framework for Spatial"
author: Ruben Fiszel
email: ruben.fiszel@epfl.ch
link-citations: true
abstract: "Drones POSE (position and orientation) estimation on drones rely on sensor fusion of its different sensors. The complexity of this task is to provide a good estimation in real-time. We have developped a novel application of an asynchronous Rao-Blackwellized Particle Filter and its implementation on hardware with the Spatial language. We have also build a new development tool: scala-flow, a data-flow simulation tool inspired by Simulink with a Spatial integration. Finally, we have build an interpreter for the Spatial language which made possible the integration of Spatial in scala-flow."
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

Thank you to my parents for their continuous support, to Prof. Kunle and Prof. Odersky for supervising me and giving me the opportunity of doing this master thesis in their lab, to the entire lab of DAWN, in particular David Koeplinger, Raghu Prabhakar, Matt Feldman, Yaqi Zhang, Tian Zhao, Stefan Hadjis which accepted me as their peer for the length of my stay. I would also like to thank Nada Amin which supervised me for the semester project that led to this project and accepted to be an expert for the evaluation of the thesis. I am also grateful to the whole institution of EPFL for the education I have received those last 5 years and for which this thesis represents the culmination. Finally, to Stanford for having welcomed me for 6 months as a Visiting Researcher Student.

# Appendix {-}

## Mini Particle Filter

${minpf}

## Rao-Blackwellized Particle Filter

${rbpfc}

# References {-}

