#!/usr/bin/env bash

(rake plot pattern="$1" ; cat) | gnuplot

	 
