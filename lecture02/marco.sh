#!/bin/usr/env bash
marco () {
	cur=$(pwd)
	export cur
}

polo () {
	cd $cur
}
