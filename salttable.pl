use utf8;
use strict;

#use lib '.';
#use Crypt::UnixCrypt;

my @s = ('.', '/', '0'..'9', 'A'..'Z', 'a'..'z');

my %t2s = ();
foreach my $i (@s) {
	my $salt = ".$i";
	my $trip = substr(crypt('', $salt), -10);
	$t2s{$trip} = $i;
}

my @k2s = ();
my @k2s_1 = ();
my @k2s_2 = ();
for (my $i = 0; $i < 256; $i++) {
	my $salt = '.'.chr($i);
	my $trip = substr(crypt('', $salt), -10);
	$k2s[$i] = $t2s{$trip};
	my $s1 = chr($i);
	$s1 =~ s/[^\x2e-\x7a]/\./go;
	$s1 =~ tr/\x3a-\x40\x5b-\x60/A-Ga-f/;
	$k2s_1[$i] = $s1;
	my $s2 = chr($i);
	$s2 =~ s/[^\x21-\x7a]/\./go;
	$s2 =~ tr/\x21-\x2d\x3a-\x40\x5b-\x60/n-zA-Ga-f/;
	$k2s_2[$i] = $s2;
}

my $ctrl = '#';

print "* 00-3F\n";
print 'char   : '.join('', map { $_ < 32 ? $ctrl : chr $_ } (0..63))."\n";
print 'default: '.join('', @k2s[0..63])."\n";
print '2ch    : '.join('', @k2s_1[0..63])."\n";
print 'next2ch: '.join('', @k2s_2[0..63])."\n";
print "* 40-7F\n";
print 'char   : '.join('', map { $_ > 126 ? $ctrl : chr $_ } (64..127))."\n";
print 'default: '.join('', @k2s[64..127])."\n";
print '2ch    : '.join('', @k2s_1[64..127])."\n";
print 'next2ch: '.join('', @k2s_2[64..127])."\n";
print "* 80-BF\n";
print 'char   : '.join('', map { $_ < 161 ? $ctrl : chr $_ } (128..191))."\n";
print 'default: '.join('', @k2s[128..191])."\n";
print '2ch    : '.join('', @k2s_1[128..191])."\n";
print 'next2ch: '.join('', @k2s_2[128..191])."\n";
print "* C0-FF\n";
print 'char   : '.join('', map { $_ > 223 ? $ctrl : chr $_ } (192..255))."\n";
print 'default: '.join('', @k2s[192..255])."\n";
print '2ch    : '.join('', @k2s_1[192..255])."\n";
print 'next2ch: '.join('', @k2s_2[192..255])."\n";
