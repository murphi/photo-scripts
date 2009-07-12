#!/usr/bin/perl -w
#use strict;

use Photo;
use Image::ExifTool qw(:Public);
use Date::Parse;
use DateTime::Format::Exif;
use DateTime::Format::ISO8601;
use DateTime::Format::Duration;

my $formatDuration = DateTime::Format::Duration->new(pattern => "%r");
my ($refFile, $refDate, @files) = @ARGV;

my $createDate = getCreateDate( $refFile );
my $diff = getDifference($refFile, $refDate);

print "$refFile created $createDate, diff = " . 
	$formatDuration->format_duration($diff) . "\n";

for my $file (@files) {
	my $orig = getCreateDate($file);
	my $adjusted = $orig + $diff;
	print "Adjusting $file:  $orig -> $adjusted\n";
}



