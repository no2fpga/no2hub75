Nitro HUB75 LED panel driver FPGA core
======================================

This core allows to drive LED panel chains using the 'classic' HUB75
protocol. The default top level contains a frame buffer but it's also
possible to re-use the lower level components to drive a display without
the need for a full frame buffer and just generate the pixel data
'just-in-time'.

The LEDS are modulated using Binary Coded Modulation which allow to
efficiently vary their intensity efficiently.
[This video](https://www.youtube.com/watch?v=Sq8SxVDO5wE) by Mike Harisson
explains the concept of BCM very well.

The geometry of the panel and various aspecs are fully configurable through
parameters given to the cores.

See the doc/ directory for more information about the internals of this
core.


Limitations
-----------

The current code in this repo targets the iCE40 only and uses some direct
`SB_IO` and `SB_RAM_4K` instances. I have run a modified version on ECP5 but
haven't yet merged the changes here. If you're interested in using this core
on another architecture, don't hesitate to contact me, the changes are fairly
minor.


License
-------

The cores in this repository are licensed under the
"CERN Open Hardware Licence Version 2 - Weakly Reciprocal" license.

See LICENSE file for full text.
