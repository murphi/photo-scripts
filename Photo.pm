package Photo;
require Exporter;
our @ISA    = qw( Exporter );
our @EXPORT = qw( getCreateDate setCreateDate getDifference);
our $VERSION = 0.01;

use strict;
use warnings;
use Image::ExifTool qw(:Public);
use DateTime::Format::Exif;

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


