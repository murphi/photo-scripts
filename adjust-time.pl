#!/usr/bin/perl -w

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

use Photo;
use Image::ExifTool qw(:Public);
use Date::Parse;
use DateTime::Format::Exif;
use DateTime::Format::Duration;

my $formatDuration = DateTime::Format::Duration->new(pattern => "%r");
my ($refFile, $refDate, @files) = @ARGV;

my $refCreateDate = getCreateDate( $refFile );
if (not defined $refDate) {
	print "$refFile created $refCreateDate\n";
	exit 0;
}

my $diff = getDifference($refFile, $refDate);

print "$refFile created $refCreateDate, diff = " . 
	$formatDuration->format_duration($diff) . "\n";

for my $file (@files) {
	my $orig = getCreateDate($file);
	my $adjusted = $orig + $diff;
	print "Adjusting $file:  $orig -> $adjusted\n";
	setCreateDate($file, $adjusted);
}



