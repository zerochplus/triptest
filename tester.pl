use utf8;
use strict;
use Encode;

require 'trip.cgi';
binmode(STDOUT);
binmode(STDIN);

my @decs = qw(cp932 sjis eucjp utf8 ascii latin1 hex);
my $dec = 'cp932';
print "dec=$dec\n";

my @encs = qw(cp932 sjis eucjp utf8 ascii latin1 auto);
my $enc = 'auto';
print "enc=$enc\n";

my @modes = qw(net sc open next strb vips 0chp bban machi patio 4chan ebbs atchs);
my $mode = 'sc';
print "mode=$mode\n";

while (1) {
	my $line = <STDIN>; $line =~ s/\r?\n\z//;
	if ($line =~ /^#/) {
		my $key = $';
		if ($dec eq 'hex') {
			if ($key =~ /[G-Zg-z]/) {
				print "!ignored\n";
				next;
			}
			my @hexs = ($key =~ /([0-9A-Fa-f]+)/g);
			$key = '';
			my $invalid = 0;
			foreach (@hexs) {
				if (length($_) % 2 == 1) {
					$invalid = 1;
					last;
				}
				$key .= $_;
			}
			if ($invalid) {
				print "!ignored\n";
				next;
			}
			$key = pack('H*', $key);
		} else {
			$key = decode($dec, $key);
			if ($enc ne 'auto') {
				$key = encode($enc, $key);
			}
		}
		my ($trip) = trip($key, $mode);
		if (defined $trip) {
			print "\x81\x9f$trip\n";
		} else {
			print "[no trip]\n";
		}
	} elsif ($line =~ /^mode=([0-9a-z]+)$/) {
		if (grep { $_ eq $1 } @modes) {
			$mode = $1;
		} else {
			print "!ignored\n";
		}
	} elsif ($line =~ /^dec=([0-9a-z]+)$/) {
		if (grep { $_ eq $1 } @decs) {
			$dec = $1;
		} else {
			print "!ignored\n";
		}
	} elsif ($line =~ /^enc=([0-9a-z]+)$/) {
		if (grep { $_ eq $1 } @encs) {
			$enc = $1;
		} else {
			print "!ignored\n";
		}
	} elsif ($line =~ /^(?:exit|quit|bye|end)$/) {
		last;
	} else {
		print "!ignored\n";
	}
}
