package Photo;
require Exporter;
our @ISA    = qw( Exporter );
our @EXPORT = qw( getCreateDate setCreateDate getDifference);
our $VERSION = 0.01;

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
use Image::ExifTool qw(:Public);
use DateTime::Format::Exif;
use DateTime::Format::ISO8601;

sub getCreateDate
{
	my $file = shift;
	die "$file is not readable" unless -r $file;

	my $exif = new Image::ExifTool;
	$exif->ExtractInfo($file);
	return 
		DateTime::Format::Exif->parse_datetime(
			$exif->GetValue('CreateDate')
		);
}


sub setCreateDate
{
	my ($file, $dt) = @_;
	die "No file specified." unless defined $file;
	die "$file is not writeable." unless -w $file;
	die "No date given." unless defined $dt;

	my $exif = new Image::ExifTool;
	$exif->SetNewValue('CreateDate', $dt);
	$exif->WriteInfo($file);
}


sub getDifference
{
	my ($file, $time) = @_;
	die "$file is not readable." unless -r $file;

	my $parser = DateTime::Format::ISO8601->new();
	my $reference = $parser->parse_datetime($time);

	return $reference - getCreateDate($file);
}


