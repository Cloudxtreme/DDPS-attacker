#!/usr/bin/perl -w
#
# $Header$
#

#
# Requirements
#
use English;
use FileHandle;
use Getopt::Long;
use Digest::MD5;
use sigtrap qw(die normal-signals);

#
# Global vars
#
my $usage = "
	$0	-number_of_files|n number	\\
		-min_size|m number kb		\\
		-maxsize|x number kb		\\
		-min_filename_length|b number	\\
		-max_filename_length|e number
\n";

#
# Subs
#

# purpose     :
# arguments   :
# return value:
# see also    :

################################################################################
# MAIN
################################################################################
#
# Parse and process options
#
if (!GetOptions('number_of_files|n=s'		=> \$number_of_files,
		'min_size|m=s'			=> \$min_size,
		'maxsize|x=s'			=> \$maxsize,
		'min_filename_length|b=s'	=> \$min_filename_length,
		'max_filename_length|e=s'	=> \$max_filename_length
	)) {
	die "$usage";
}

#
# Check arguments
#
foreach ($number_of_files, $min_size, $maxsize, $min_filename_length, $max_filename_length) {
	die "! $usage" if (! defined ($_) );
}


exit 0;

#
# Documentation and  standard disclaimar
#
# Copyright (C) 2001 Niels Thomas Haugård
# UNI-C
# http://www.uni-c.dk/
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the 
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License 
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
#
#++
# NAME
#	template.pl 1
# SUMMARY
#	Short description
# PACKAGE
#	file archive exercicer
# SYNOPSIS
#	template.pl options
# DESCRIPTION
#	\fItemplate.pl\fR is used for ...
#	Bla bla.
#	More bla bla.
# OPTIONS
# .IP o
#	I'm a bullet.
# .IP o
#	So am I.
# COMMANDS
#	
# SEE ALSO
#	
# DIAGNOSTICS
#	Whatever.
# BUGS
#	Probably. Please report them to the call-desk or the author.
# VERSION
#      $Date$
# .br
#      $Revision$
# .br
#      $Source$
# .br
#      $State$
# HISTORY
#	$Log$
# AUTHOR(S)
#	Niels Thomas Haugård
# .br
#	E-mail: thomas@haugaard.net
# .br
#	UNI-C
# .br
#	DTU, Building 304
# .br
#	DK-2800 Kgs. Lyngby
# .br
#	Denmark
#--
