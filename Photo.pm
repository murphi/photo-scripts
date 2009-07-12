package Photo;
require Exporter;
our @ISA    = qw( Exporter );
our @EXPORT = qw( getCreateDate );

use strict;
use warnings;
use Image::ExifTool qw(:Public);

sub getCreateDate
{
	my $file = shift;
	return undef unless -r $file;

	my $exif = new Image::ExifTool;
	$exif->ExtractInfo($file);
	return $exif->GetValue('CreateDate');
}



