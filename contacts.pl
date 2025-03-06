use strict;
use 5.10.1;

while(<>){
	next unless /\w@\w/;
	chomp;
	s/\t([^\t]*)$/" <$1/;
	s/\s*$/>/;
	s/\tNA\b//g;
	s/\t/ /g;
	s/^/"/;
	say;
}
