#!/usr/bin/env python3
#
# Computes gamma LUT
#
# Copyright (C) 2019-2020 Sylvain Munaut
# SPDX-License-Identifier: MIT
#

import math

GAMMA     =  2.0
WIDTH_IN  =  8
WIDTH_OUT = 16


for iv in range(1 << WIDTH_IN):
	ov = 1.0 * iv / ((1 << WIDTH_IN) - 1)
	ov = math.pow(ov, GAMMA)
	ov = ov * ((1 << WIDTH_OUT) - 1)
	ov = round(ov)
	print("%04x" % ov)
