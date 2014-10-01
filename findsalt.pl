use utf8;
use strict;

#use lib '.';
#use Crypt::UnixCrypt;

my @s = ('.', '/', '0'..'9', 'A'..'Z', 'a'..'z');

print 'key> #';
my $key = <STDIN>; chomp($key);
print 'trip> ';
my $trip = <STDIN>; chomp($trip);
foreach my $i (@s) {
	foreach my $j (@s) {
		my $salt = "$i$j";
		my $t = crypt($key, $salt);
		if ($t =~ /\Q$trip\E/) {
			print "$t : #$key : $salt\n";
		}
	}
}

