#!/usr/bin/perl 

# photo-scripts - Set of scripts to edit a collection of photos
# Copyright (C) 2009, Martin Engelmann <martin.engelmann@gmx.de>
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
# You should have received a copy of the GNU General Public License along
# with this program; if not, write to the Free Software Foundation, Inc.,
# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.

use strict;
use warnings;

use Getopt::Long;
use File::Basename;
use File::Copy;
use Photo;

my @photos = ();
my $outputDir = ".";
GetOptions(
	"output=s"		=> \$outputDir,
	"photos=s{1,}"	=> \@photos
	);


my %files;
foreach my $photo (@photos) {
	my $dt = getCreateDate($photo);
	$files{ $dt } = $photo;
}

my $index = 0;
foreach my $key (sort keys %files) {
	$index++;
	my ($file, $dir) = fileparse($files{$key});

	my $dst = sprintf "%.5d_%s", $index, $file;
	my $dstFile = $outputDir . "/" . $dst;
	copy $files{$key}, $dstFile  or 
		warn "Cant copy $files{$key} to $dstFile: $!\n";
}

