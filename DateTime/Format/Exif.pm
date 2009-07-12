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

1;
