#!/bin/bash

create:
	createdb dataproj

download:
	mkdir -p tmp

	# go find a cool data set...
	# https://duckduckgo.com/?q=open+data
	#
	# then put the URL and filename here:

	curl <URL> -o tmp/<filename>.csv
