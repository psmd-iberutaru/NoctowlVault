---
date: 2025-12-28
author: Sparrow
tags:
  - StarLiner
  - Blog
  - Aviation
---

Welcome aboard the [[STAR Liner/STAR Liner - Welcome Briefing|Sparrow STAR Liner]]! A blog where we take a trackless voyage across Space, Technology, Aviation, and other Randomness. Stops are scattered, and we do not have many stations, but we hope you enjoy where you disembark.

___
# Aviation Wind Triangle Derivation

The wind triangle in aviation and nautical navigation is an important part of determining the correct heading provided a wind, or heading corrections; thus an important step for the relations course and heading. Generally speaking, people solve the wind triangle using calculators (both electric or analog, like an [E6B](https://en.wikipedia.org/wiki/E6B). Here, as an exercise, we derive the governing equations which said calculators use.

The wind triangle can be solved via permutations of the two governing geometric relationships derived from the Law of Sines and Law of Cosines (notation is explained in later):
$$
\frac{G}{\sin(\Phi - \Psi)} = \frac{V}{\sin(\Theta - \Psi)} = \frac{W}{\sin(\Theta - \Phi)}
$$
$$
G^2 = V^2 + W^2 - 2 V W \cos(\Phi - \Psi)
$$

These equations hold for the domain of angles between $0^\circ \leq \angle \leq 360^\circ$. These equations assume that the wind speed are approximately less than $20\%$ of the true air speed. They work at higher ratios with one caveat.

# Overview

The wind triangle is generally used to solve 1 of 3 different problems, two of which is considered the "direct" problem and the last being the "inverse" problem. [Nihad E. Daidzic 2016](https://www.researchgate.net/publication/316142356_General_solution_of_the_wind_triangle_problem_and_the_critical_tailwind_angle)

- **Direct Problems**:
	- The airspeed, heading, wind direction, and wind speed are known; the ground speed, drift angle, and the true course are calculated. (This problem shall be called the secondary direct problem.)
	- The airspeed, true course, wind direction, and wind speed are known; the ground speed, wind correction angle, and required heading are calculated. (This problem shall be called the primary direct problem.)
- **Inverse Problem**:
	- The airspeed, ground speed, heading, and course are known. The wind direction and wind speed are calculated. (This problem shall be called the primary inverse problem.)
  
The solutions to these problems in generalized mathematical form are provided.

# Notation and Primary Diagram

We will use the following wind triangle as a visual and notional reference along with the following notation: (For the sake of the equations often found on a E6B, $\Phi = \Theta ^{+\text{R}}_{-\text{L}} \nabla$, the drift angle is $\Delta$ and the wind correction angle is $\nabla$.) 

(Only the physically important angles are listed.)

![[STAR Liner/Media/wind_triangle_labels.svg]]

Notation:

| Notation | Quantity                                     |
|----------|----------------------------------------------|
| V        | Aircraft airspeed                            |
| G        | Aircraft groundspeed                         |
| W        | Wind speed                                   |
| $\Phi$   | Aircraft heading                             |
| $\Theta$ | Aircraft course or track                     |
| $\Psi$   | Wind direction                               |
| $\Delta$ | Drift angle (Wind correction angle $\nabla$) |

# Geometric and Trigonometric Identities

Three separate geometric and trigonometric identities are needed. Consider a triangle with the following general dimensions:

![[STAR Liner/Media/general_triangle_labels.svg]]

Euclidean triangles such as these follow these properties:

- [**Triangle Postulate**](https://en.wikipedia.org/wiki/Sum_of_angles_of_a_triangle) The sum of all angles of the triangle is equal to two right angles. Thus:
$$
a + b + c = 2 \left(\frac{\pi}{2} \text{ rad} \right) = \pi \text{ rad} = 180^\circ
$$
- [**Law of Sines**](https://en.wikipedia.org/wiki/Law_of_sines) The ratio of sides and the sines of their opposite angles are equal. Thus:
$$
\frac{A}{\sin a} = \frac{B}{\sin b} = \frac{C}{\sin c}
$$
- [**Law of Cosines**](https://en.wikipedia.org/wiki/Law_of_cosines) The Pythagorean theorem extended for any triangle that is not a right triangle. Thus:
$$
C^2 = A^2 + B^2 - 2 A B \cos c
$$

Two other miscellaneous geometric properties are needed.

- [**Supplementary Angles**](https://en.wikipedia.org/wiki/Angle\#complementary_angle) A linear pair of angles (two angles which share only one side and their non-shared sides are the same line) sum to a straight angle $\angle = 180^\circ = \pi \text{ rad}$.
- [**Conjugate Angles**](https://en.wikipedia.org/wiki/Angle\#complementary_angle) A pair of non-congruent angles which share the same sides sum to a complete angle $\angle = 360^\circ = 2\pi \text{ rad}$.

# Simple Angle Relationships

There exists many simple angle relationships.

## Supplementary and Conjugate Angles

The angles $\gamma$ and $\alpha$ and supplementary to each other, as such:
$$
\gamma + \alpha = \pi
$$

The angles $\xi$ and $\Psi$ are conjugate angles. (Notice that both $\xi$ angles opposite to each other, these angles are congruent.) As such,
$$
\xi + \Psi = 2\pi
$$

## Triangle Postulate Relationships

The angles $\alpha$, $\beta$, and $\Delta$ make up a single triangle, and, via the Triangle Postulate:
$$
\alpha + \beta + \Delta = \pi
$$

Similarly, the angles $\Phi$, $\xi$, and $\gamma$ make up a single triangle, and, via the Triangle Postulate:
$$
\Phi + \xi + \gamma = \pi
$$

Similarly, the angles $\xi$, $\Theta$, and $\beta$ make up a single triangle, and, via the Triangle Postulate:
$$
\xi + \Theta + \beta = \pi
$$

## Angle Addition Relationships
Angle addition also allows us to establish a relationship with $\Phi$, $\Theta$, and $\Delta$:
$$
\Theta = \Phi + \Delta
$$

## Trigonometric Relationships
Using the law of sines on the primary wind triangle:
$$
\frac{G}{\sin \alpha} = \frac{V}{\sin \beta} = \frac{W}{\sin \Delta}
$$

Using the law of cosines on the primary wind triangle:
$$
W^2 = V^2 + G^2 - 2 V G \cos\Delta
$$

## Aerodynamic Relationships
Often E6Bs are used for the quick slide-rule calculations of many of these values here. For these calculations, we use the drift angle $\Delta$ defined by: (For the course $\Theta$ and the heading $\Phi$.)
$$
\Delta = \Theta - \Phi
$$

But, E6Bs have the notation: (Here the wind correctional angle is given the notation $\nabla$.)
$$
\text{MH} = \text{MC} ^{+\text{R}}_{-\text{L}} \text{WCA} \longrightarrow \Phi = \Theta ^{+\text{R}}_{-\text{L}} \nabla = \Theta \pm \nabla
$$

Conventionally, it is assumed that $\Delta = - \nabla$. However, this is only the case for where wind speed to airspeed ratio $r \triangleq \frac{W}{V} \lessapprox 0.2$ (i.e. the wind speed is less than about 20% of your air speed), the deviation being on the order of $\angle \lesssim 1^\circ$ ([Alexander W S et. al. 1941](https://doi.org/10.2514/8.10761)). That is assumed here, as such:
$$
\nabla = - \Delta
$$

Should these equations be used in the domain of $r \triangleq \frac{W}{V} \approx 0.2$, corrections to the current course may need to be done more frequently to fix the small deviation.

# Governing Equations
Here, the equations governing the wind triangle quantities are derived. The primary means are formulations of the law of sines and law of cosines.

## Sines Equation

**For the $\alpha$ angle**: We have, $\xi + \Psi = 2\pi$, thus $\xi = 2\pi - \Psi$. Using the previous Triangle Postulate $\Phi + \xi + \gamma = \pi$:
$$
\begin{aligned}
\gamma &= \pi - \Phi - \xi = \pi - \Phi - \left(2\pi - \Psi\right) \\
\gamma &= \Psi - \Phi - \pi
\end{aligned}
$$

And, given that $\alpha + \gamma = \pi$:
$$
\begin{aligned}
\alpha &= \pi - \gamma = \pi - \left(\Psi - \Phi - \pi\right) \\
\alpha &= \Phi - \Psi + 2 \pi
\end{aligned}
$$

**For the $\beta$ angle**: We have $\xi + \Theta + \beta = \pi$ and $\xi = 2\pi - \Psi$, 
$$
\begin{aligned}
\beta &= \pi - \Theta - \xi = \pi - \Theta - \left(2\pi - \Psi \right) \\
\beta &= \Psi - \Theta - \pi
\end{aligned}
$$

**For the $\Delta$ angle**: We have $\alpha + \beta + \Delta = \pi$ and the previous relationships, so: (Of course, this should be consistent with $\Delta = \Theta - \Phi$ from Angle Addition,
$$
\begin{aligned}
\Delta &= \pi - \alpha - \beta = \pi - \left(\Phi - \Psi + 2 \pi\right) - \left(\Psi - \Theta - \pi\right) \\ 
\Delta &= \Theta - \Phi
\end{aligned}
$$

### Full Law of Sines
As such, the full Law of Sines can be as follows. The second conversion is because $\sin(x) = \sin(x + 2\pi)$ and $\sin(x + \pi) = \sin(-x)$.
$$
\begin{gather}
\frac{G}{\sin \alpha} = \frac{V}{\sin \beta} = \frac{W}{\sin \Delta} \\
\frac{G}{\sin(\Phi - \Psi + 2 \pi)} = \frac{V}{\sin(\Psi - \Theta - \pi)} = \frac{W}{\sin(\Theta - \Phi)} \\
\frac{G}{\sin(\Phi - \Psi)} = \frac{V}{\sin(\Theta - \Psi)} = \frac{W}{\sin(\Theta - \Phi)}
\end{gather}
$$

## Cosines Equation
**For the $\Delta$ Angle**: From Angle Addition:
$$
\Delta = \Theta - \Phi
$$

This value, $\Delta$, can be substituted into the Law of Cosines, $W^2 = V^2 + G^2 - 2 V G \cos\Delta$.

### Full Law of Cosines
Provided that $\Delta = \Theta - \Phi$, the full law of cosines is:
$$
\begin{gather}
W^2 = V^2 + G^2 - 2 V G \cos\Delta \\
W^2 = V^2 + G^2 - 2 V G \cos(\Theta - \Phi)
\end{gather}
$$

Two other equivalent law of cosines are:
$$
\begin{gather}
V^2 = W^2 + G^2 - 2 W G \cos\beta = W^2 + G^2 + 2 W G \cos(\Theta - \Psi) \\
G^2 = V^2 + W^2 - 2 V W \cos\alpha = V^2 + W^2 - 2 V W \cos(\Phi - \Psi)
\end{gather}
$$

# Solving the Wind Triangle
Here we present the general solutions to the different types of problems initially described, provided the governing equations found above.

Note, generally, the Law of Cosines is more numerically stable to rounding errors than the Law of Sines. It also does not suffer from the Law of Sines ambiguity.

## Primary Direct Problem
The following are **known** parameters:
- True airspeed $V$
- True/magnetic course $\Theta$
- True/magnetic wind direction $\Psi$
- Wind speed $W$

The following are **unknown** parameters and thus must be calculated:
- Ground speed $G$
- Wind correction angle $\nabla$
- True/magnetic heading $\Phi$

Via the Law of Sines from the governing equations, the wind correction angle $\nabla$ can be determined: 
$$
\begin{gather}
\frac{V}{\sin(\Theta - \Psi)} = \frac{W}{\sin \Delta} \\
\nabla = - \arcsin\left(\frac{W}{V} \sin(\Theta - \Psi)\right)
\end{gather}
$$

Via the Law of Sines from the governing equations, the heading $\Phi$ can be determined:
$$
\begin{gather}
\frac{V}{\sin(\Theta - \Psi)} = \frac{W}{\sin(\Theta - \Phi)} \\
\Phi = \Theta - \arcsin\left(\frac{W}{V}\sin(\Theta - \Psi)\right)
\end{gather}
$$

Via the Law of Cosines from the governing equations, the ground speed $G$ can be determined:
$$
\begin{aligned}
G^2 &= V^2 + W^2 - 2 V W \cos(\Phi - \Psi) \implies G = \sqrt{V^2 + W^2 - 2 V W \cos(\Theta - \Psi + \nabla )} \\
G &= \sqrt{V^2 + W^2 - 2 V W \cos\left(\Theta - \Psi - \arcsin\left(\frac{W}{V}\sin(\Theta - \Psi)\right) \right)}
\end{aligned}
$$

## Secondary Direct Problem
The following are **known** parameters:
- True airspeed $V$
- True/magnetic heading $\Phi$
- True/magnetic wind direction $\Psi$
- Wind speed $W$

The following are **unknown** parameters and thus must be calculated:
- Ground speed $G$
- Drift angle $\Delta$
- True/magnetic course $\Theta$

Via the Law of Cosines from the governing equations, the ground speed $G$ can be determined:
$$
\begin{aligned}
G^2 &= V^2 + W^2 - 2 V W \cos(\Phi - \Psi) \\
&G = \sqrt{V^2 + W^2 - 2 V W \cos(\Phi - \Psi)}
\end{aligned}
$$

Via the Law of Sines from the governing equations, the course $\Theta$ can be determined:
$$
\begin{aligned}
\frac{G}{\sin(\Phi - \Psi)} &= \frac{V}{\sin(\Theta - \Psi)} \implies \Theta = \Psi + \arcsin\left(\frac{V}{G}\sin(\Phi - \Psi)\right) \\
\Theta &= \Psi + \arcsin\left(\frac{ V\sin(\Phi - \Psi)}{\sqrt{V^2 + W^2 - 2 V W \cos(\Phi - \Psi)}}\right)
\end{aligned}
$$

Via the Law of Sines from the governing equations, the drift angle  $\Delta$ can be determined: 
$$
\begin{aligned}
\frac{G}{\sin(\Phi - \Psi)} &= \frac{W}{\sin \Delta} \implies \Delta = \arcsin\left(\frac{W}{G} \sin(\Phi - \Psi)\right) \\
\Delta &= \arcsin\left(\frac{W \sin(\Phi - \Psi)}{\sqrt{V^2 + W^2 - 2 V W \cos(\Phi - \Psi)}} \right)
\end{aligned}
$$

## Primary Inverse Problem
The following are **known** parameters:
- True airspeed $V$
- Ground speed $G$
- Heading $\Phi$
- Course $\Theta$

The following are **unknown** parameters and thus must be calculated:
- Wind direction $\Psi$
- Wind speed $W$

Via the Law of Cosines from the governing equation, the wind speed $W$ can be determined:
$$
\begin{aligned}
W^2 &= V^2 + G^2 - 2 V G \cos(\Theta - \Phi)  \\
W &= \sqrt{V^2 + G^2 - 2 V G \cos(\Theta - \Phi)}
\end{aligned}
$$

Via the Law of Sines from the governing equation, the wind direction $\Psi$ can be determined:
$$
\begin{aligned}
\frac{V}{\sin(\Theta - \Psi)} &= \frac{W}{\sin(\Theta - \Phi)} \implies \Psi = \Theta - \arcsin\left(\frac{V}{W} \sin(\Theta - \Phi)\right) \\
\Psi &= \Theta - \arcsin\left(\frac{V  \sin(\Theta - \Phi)}{\sqrt{V^2 + G^2 - 2 V G \cos(\Theta - \Phi)}}\right)
\end{aligned}
$$


___
Created: 2025-12-28
Last Updated: 2025-12-28