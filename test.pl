use utf8;
use strict;

use lib '.';
use Crypt::UnixCrypt;
use Digest::SHA::PurePerl qw(sha1_base64);

sub main {
	require 'trip.cgi';
	# #1
	test('1', 'tsGpSwX8mo', 'tsGpSwX8mo');
	# #12345678
	test("\x31\x32\x33\x34\x35\x36\x37\x38", 'WBRXcNtpf.', 'WBRXcNtpf.');
	# #ｱ23ｴｵｶｷｸ
	test("\xb1\x32\x33\xb4\xb5\xb6\xb7\xb8", 'WBRXcNtpf.', 'WBRXcNtpf.');
	# #ｱｲｳｴｵｶｷｸ
	test("\xb1\xb2\xb3\xb4\xb5\xb6\xb7\xb8", 'XlUiP8mHCU', 'XlUiP8mHCU');
	# #ｋａｍｉ
	test("\x82\x8b\x82\x81\x82\x8d\x82\x89", 'yGAhoNiShI', 'yGAhoNiShI');
	# #828b8281828d8289
	test('#828b8281828d8289', 'yGAhoNiShI', 'yGAhoNiShI');
	# #828b8281828d8289.
	test('#828b8281828d8289.', 'yGAhoNiShI', 'yGAhoNiShI');
	# #828b8281828d8289..
	test('#828b8281828d8289..', 'yGAhoNiShI', 'yGAhoNiShI');
	# #騨ﾚNWKJ諤
	test("\x91\xcb\xda\x4e\x57\x4b\x4a\xe6\x80", 'YYYYYYYYYY', 'YYYYYYYYYY');
	# ##3132333435363738
	test('#3132333435363738', 'XlUiP8mHCU', 'XlUiP8mHCU');
	# ##31323334353637382
	test('#31323334353637382', '1tWQFkUcLU', '1tWQFkUcLU');
	# ##313233343536373823
	test('#313233343536373823', 'WBRXcNtpf.', 'WBRXcNtpf.');
	# ##3100000000000000H.
	test('#3100000000000000H.', 'tsGpSwX8mo', 'tsGpSwX8mo');
	# #123456789
	test('123456789', 'WBRXcNtpf.', 'WBRXcNtpf.');
	# #1234567890
	test('1234567890', 'WBRXcNtpf.', 'WBRXcNtpf.');
	# #12345678901
	test('12345678901', 'WBRXcNtpf.', 'WBRXcNtpf.');
	# #123456789012
	test('123456789012', 'jZk8zfYo4m4X', 'jZk8zfYo4m4X');
	# #1234567890123
	test('1234567890123', 'CNfebL9sP6Ci', 'CNfebL9sP6Ci');
	# #あいうえおか
	test("\x82\xa0\x82\xa2\x82\xa4\x82\xa6\x82\xa8\x82\xa9", 'N0mUb9Yq8DyS', 'N0mUb9Yq8DyS');
	# #$2345678901
	test('$2345678901', 'BaNAE36vrg', 'BaNAE36vrg');
	# #$23456789012
	test('$23456789012', '???', '4QKLUa.0a8HzwPe');
	# #$..........2
	test('$..........2', '???', 'RqK!0i.t49rNji7');
	# #$｡3456789012
	test("\x24\xa13456789012", '???', "\xbe\xcd\xb5\xcf\xdd\xb7\xa9\xb3\xda\xd4\xa5\xb4\xcb\xa5\xb4"); # ｾﾍｵﾏﾝｷｩｳﾚﾔ･ｴﾋ･ｴ
	# #$｡1008343131
	test("\x24\xa11008343131", '???', "\xc3\xbd\xc4\x21\xb9\xcf\xdc\xac\xb4\xa5\xa7\xce\xd6\xb2\xce"); # ﾃｽﾄ!ｹﾏﾜｬｴ･ｧﾎﾖｲﾎ
	# #$ｱｲｳｴｵｱｲｳｴｵｱｲｳｴｵ
	test("\x24\xb1\xb2\xb3\xb4\xb5\xb1\xb2\xb3\xb4\xb5\xb1\xb2\xb3\xb4\xb5", '???', "\xb3\xdf\xbe\xc9\xaa\xa3\xc8\xca\xcd\xac\xcf\xdf\xa6\xb3\xb9"); # ｳﾟｾﾉｪ｣ﾈﾊﾍｬﾏﾟｦｳｹ
	# ##23456789012
	test('#23456789012', '???', '???');
	# ##1234567890123456..abc
	test('#1234567890123456..abc', '???', '???');
	# #ホムホム
	test("\x83\x7a\x83\x80\x83\x7a\x83\x80", 'QD4TDVpNOM', 'L809q.Wvdk');
	# ##837a8380837a8380z.
	test('#837a8380837a8380z.', 'QD4TDVpNOM', 'L809q.Wvdk');
	# #◆●★
	test("\x81\x9f\x81\x9c\x81\x9a", 'dTHrbNrOw.', 'dTHrbNrOw.');
	# #<>"&
	test('<>"&', 'f0abm3NbDw', 'f0abm3NbDw');
	# #1234567&
	test('1234567&', 'q3.yfaIC5s', 'q3.yfaIC5s');
	# #＃
	test("\x81\x94", 'u2YjtUz8MU', '68NHrw0u9M');
	# # ＃
	test(" \x81\x94", '68NHrw0u9M', 'g3.NWF1Chs');
	# #＃＃
	test("\x81\x94\x81\x94", 'xSK1SiC5MI', 'wOlE71ViKc');
	# #＝煤＃
	test("\x81\x81\x94\x81\x81\x94", '0ZaZ6Ph9YM', '8Ifcd5IMRw');
	# #123456789012＃
	test("123456789012\x81\x94", 'RITzbxS2I3J9', 'aKqOHnvuUtkd');
	# #＃3456789012
	test("\x81\x943456789012", 'lg6Q/4u.i.', 'VlTC9VCYT7DD');
	# #＃31318194313100001.
	test("\x81\x9431318194313100001.", '7ZE59iVq1I', 'j6J/iuF0lYOO');
}

sub test {
	my ($key, $tripnet, $tripsc) = @_;
	my ($tripnet_, undef, undef, undef, undef) = trip($key, 0);
	my ($tripsc_, undef, undef, undef, undef) = trip($key, 1);
	if ($tripnet_ eq $tripnet && $tripsc_ eq $tripsc) {
		#print "key #$key\n";
		#print "  ...ok\n";
	} else {
		print "key #$key\n";
		print "  result net:$tripnet_ sc:$tripsc_\n";
		print "  expect net:$tripnet sc:$tripsc\n";
	}
}

exit(main()) if (!defined caller);
