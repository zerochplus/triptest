use utf8;
use strict;

#use lib '.';
#use Crypt::UnixCrypt;

my @s = ('.', '/', '0'..'9', 'A'..'Z', 'a'..'z');
my @c = ("\x00", '&', '#', ';', '0'..'9', 'a'..'z', 'A'..'Z',
		 ' ', '!', '"', '$', '%', "'", '(', ')', '*', '+', ',', '-', '.', '/',
		 ':', ';', '<', '=', '>', '?', '@', '[', '\\', ']', '^', '_', '`', '{', '|', '}', '~',
		 (map { chr } (0x01..0x1f)), "\x7f");

print 'replace str> ';
my $str = <STDIN>; chomp($str);

my $rep = '';
A: for my $l (7, 6, 5, 4, 3, 2, 1, 0, -1) {
	if ($l == -1) {
		print "! too long.\n";
		last A;
	}
	my $key = ('.'x$l);
	print "test the key #$key$str\n";
	print '  result trip> ';
	my $trip = <STDIN>; chomp($trip);
	foreach my $c (@c) {
		my $k = "$key$rep$c";
		my $salt = substr("${k}H.G", 1, 2);
		$salt =~ s/[^\x2e-\x7a]/\./go;
		$salt =~ tr/\x3a-\x40\x5b-\x60/A-Ga-f/;
		my $t = substr(crypt($k, $salt), -10);
		if ($t eq $trip) {
			if ($c eq "\x00") {
				print "  the key was #$key$rep\n";
				print "BINGO! $str => $rep\n";
				last A;
			}
			$rep .= $c;
			print "  the key was #$k\n";
			next A;
		}
	}
	print "  !force search...\n";
	foreach my $c (@c) {
		my $k = "$key$rep$c";
		foreach my $i (@s) {
			foreach my $j (@s) {
				my $salt = "$i$j";
				my $t = substr(crypt($k, $salt), -10);
				if ($t eq $trip) {
					if ($c eq "\x00") {
						print "  the key was #$key$rep\n";
						print "BINGO! $str => $rep\n";
						last A;
					}
					$rep .= $c;
					print "  the key was #$k\n";
					next A;
				}
			}
		}
	}
	print "not found.\n";
	last A;
}
