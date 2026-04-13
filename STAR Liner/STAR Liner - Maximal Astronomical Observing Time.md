---
date: 2025-12-28
author: Sparrow
tags:
  - StarLiner
  - Blog
  - Astronomy
---

Welcome aboard the [[STAR Liner/STAR Liner - Welcome Briefing|Sparrow STAR Liner]]! A blog where we take a trackless voyage across Space, Technology, Aviation, and other Randomness. Stops are scattered, and we do not have many stations, but we hope you enjoy where you disembark.

___
# Maximal Astronomical Observing Time

When observing specific astronomical objects, knowing the total time which it will be available to observe is helpful. In general, observing an astronomical object is limited to some maximum time because of the rotation of the Earth and one's position on the Earth because it would otherwise be too far at or below the horizon. We present the derivation for the maximum time (and other related parameters) to observe an astronomical object provided some base assumptions,

The maximum time $t$ that one can observe an astronomical object (with a right ascension of $\alpha$ and declination $\delta$) at a local latitude of $\phi$ is: (Where the angle $a_\pm$ is the lowest point in the sky, measured from the horizon, that is considered "observable" by sky standards as personally defined.)
$$
t = \frac{12 \text{ hr}}{\pi} t_\angle = \frac{12}{\pi} \left[ 2 \arccos\left(\frac{\sin a_\pm - \sin\phi\sin\delta}{\cos\phi\cos\delta}\right) \right] \text{ hr}
$$

## Spherical Geometry

The total time that an object in the astronomical sky is observable depends mostly on the relational orientation of the equatorial coordinate system (relating to the astronomical object) and the horizontal coordinate system (relating to the local observer).

In general, there exists the transformation equations between both the equatorial coordinate system and the horizontal coordinate system: (See [Astrophysical Formulae Kenneth R. Lang 1974](https://archive.org/download/AstrophysicalFormulae/Lang-AstrophysicalFormulae.pdf) page 504 equation 5-45.)
$$
\begin{aligned}
\cos a \sin A &= -\cos\delta \cos h \\
\cos a \cos A &= \sin\delta \cos\phi - \cos\delta \cos h \sin\phi \\
\sin a &= \sin\delta \sin\phi + \cos\delta \cos h \cos\phi \\
\cos\delta \cos h &= \sin a \cos\phi - \cos a \cos A \sin\phi \\
\sin\delta &= \sin a \sin\phi + \cos a \cos A \cos\phi
\end{aligned}
$$

(Where $h = \text{LST} + \alpha$ for the hour angle $h$, the local sidereal time $\text{LST}$, and  the right ascension $\alpha$. Where $a$ is the local altitude and $A$ is the azimuth of the target measured from North positive towards the East along the horizon. Where $\phi$ is the observer's latitude.)

Of which, only the following is relevant for this derivation:
$$
\sin a = \sin\delta \sin\phi + \cos\delta \cos h \cos\phi
$$

The hour angle $h$ of a celestial object is defined as the angle (or time in some sense) that an object is from the local meridian. Or, more specifically, the angle between the hour circle passing through the astronomical object and the local meridian circle.

As such, if an object is at the minimum observable altitude $a_-$ at the earliest time in the night, it will have an hour angle $h_-$. The case for the maximum observable altitude $a_+$ and the latest time in the night are both provided.
$$
\begin{aligned}
a_- &= \arcsin(\sin\phi \sin\delta + \cos\phi \cos\delta \cos h_-) \quad \text{earliest} \\
a_+ &= \arcsin(\sin\phi \sin\delta + \cos\phi \cos\delta \cos h_+) \quad \text{latest}
\end{aligned}
$$

In the case of both the minimum observable altitude being the same at both the earliest rising angle and the latest setting angle; that is where $a_- = a_+ = a_\pm$. In circumstances where this is not true, both cases will need to be handled separately.
$$
a_\pm = \arcsin(\sin\phi \sin\delta + \cos\phi \cos\delta \cos h_\pm)
$$

Converting this into a equation of the form $h = f(a)$,
$$
h_\pm = \arccos\left( \frac{\sin(a_\pm) - \sin\phi \sin\delta}{\cos\phi \cos\delta} \right)
$$

For the astronomical object, traveling across the sky from the altitude of $a_-$ to $a_+$ throughout the night means that the object's hour angle will have also gone from $h_-$ to $h_+$. By the definition of the hour angle, to cross an angle $h_\angle$ across the sky, it takes $h_t$ time (in angular time, the conversion $1 \text{ hr} \stackrel{\scriptscriptstyle\wedge}{=} \frac{\pi}{12} \text{ rad} \stackrel{\scriptscriptstyle\wedge}{=} 15^\circ$ is applied to convert from angular time to temporal time).

Thus, the total hour angle traversed $h_T = h_- + h_+$ by an object from the altitude of $a_-$ to $a_+$ across the sky, as a function of both $a_-$ and $a_+$ is given by:
$$
h_T = \arccos\left( \frac{\sin(a_-) - \sin\phi \sin\delta}{\cos\phi \cos\delta} \right) + \arccos\left( \frac{\sin(a_+) - \sin\phi \sin\delta}{\cos\phi \cos\delta} \right)
$$

And, in the more applicable case that the limiting angles are the same, $a_- = a_+ = a_\pm$:
$$
\begin{aligned}
h_T &= \arccos\left( \frac{\sin(a_\pm) - \sin\phi \sin\delta}{\cos\phi \cos\delta} \right) + \arccos\left( \frac{\sin(a_\pm) - \sin\phi \sin\delta}{\cos\phi \cos\delta} \right) \\
h_T &= 2 \arccos\left( \frac{\sin(a_\pm) - \sin\phi \sin\delta}{\cos\phi \cos\delta} \right)
\end{aligned}
$$

### Final Equations

Finally, in the notation from the abstract, the total angular time $t_\angle$ is equivalent to the total hour angle traversed; $t_\angle \triangleq h_T$. And, the total angular time $t_\angle$ can be converted to temporal time $t$ via the conversions of $1 \text{ hr} \stackrel{\scriptscriptstyle\wedge}{=} \frac{\pi}{12} \text{ rad} \stackrel{\scriptscriptstyle\wedge}{=} 15^\circ$, leading to the final equations:

Total angular time $t_\angle$:
$$
t_\angle = 2 \arccos\left( \frac{\sin(a_\pm) - \sin\phi \sin\delta}{\cos\phi \cos\delta} \right)
$$

Total temporal time $t$:
$$
t = \frac{12}{\pi} \left[ 2 \arccos(\frac{\sin a_\pm - \sin\phi\sin\delta}{\cos\phi\cos\delta}) \right] \text{ hr}
$$

## Circumpolar and Unobserveable Modification
However, both the total angular time equation and total temporal time equation above cannot reasonably account for circumpolar astronomical targets, or targets that never rise above the minimum observing altitude $a_\pm$. In order to correct for this, a specialized $\arccos$ function is needed (namely, it needs to be able to handle domain values outside $-1 \leq x \leq 1$). This function, notated here as $\arccos_\text{ext}$ (extended $\arccos$ function), is given as:
$$
\arccos_\text{ext.}(x) \triangleq 
    \begin{cases}
        \pi & \text{ if } x < -1 \\ 
        \arccos(x) & \text{ if } -1 \leq x \leq 1 \\ 
        0 & \text{ if } 1 < x
    \end{cases}
$$

As such, using this new arccosine function:

For total angular time $t_\angle$:
$$
\begin{aligned}
t_\angle &= \arccos_\text{ext} \left( \frac{\sin(a_-) - \sin\phi \sin\delta}{\cos\phi \cos\delta} \right) + \arccos_\text{ext} \left( \frac{\sin(a_+) - \sin\phi \sin\delta}{\cos\phi \cos\delta} \right) \\ 
t_\angle &= 2 \arccos_\text{ext}\left( \frac{\sin(a_\pm) - \sin\phi \sin\delta}{\cos\phi \cos\delta} \right)
\end{aligned}
$$

For total temporal time $t$:
$$
\begin{aligned}
t &= \frac{12}{\pi} \left[ \arccos_\text{ext} \left( \frac{\sin(a_-) - \sin\phi \sin\delta}{\cos\phi \cos\delta} \right) + \arccos_\text{ext} \left( \frac{\sin(a_+) - \sin\phi \sin\delta}{\cos\phi \cos\delta} \right) \right] \text{ hr} \\ 
t &= \frac{12}{\pi} \left[ 2 \arccos_\text{ext} \left( \frac{\sin(a_\pm) - \sin\phi \sin\delta}{\cos\phi \cos\delta} \right) \right] \text{ hr}
\end{aligned}
$$

___
Created: 2025-12-28
Last Updated: 2025-12-28