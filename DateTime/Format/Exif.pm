package DateTime::Format::Exif;
our $VERSION = '0.01';

use DateTime::Format::Builder
(
	parsers => {
		parse_datetime => {
			params => [ qw( year month day hour minute second ) ],
			regex => qr/^(\d\d\d\d):(\d\d):(\d\d) (\d\d):(\d\d):(\d\d)$/,
		}
	}
);

sub format_datetime
{
	my ($self, $dt) = @_;
	return $dt->strftime("%Y:%m:%d %H:%M:%S");
}

1;
