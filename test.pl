use utf8;
use strict;
use Encode;

my $OUTENC = 'cp932';

sub main {
	require 'trip.cgi';
	binmode(STDOUT);
	
	test_common();
	test_salt();
	test_0x80();
	test_nama();
	test_sharp();
	test_dollar();
	test_whitespace();
	test_replace_ascii();
	test_replace_other();
	test_replace_check();
	test_character();
	test_encoding();
	
	print "end.\n";
	return 0;
}

sub test_common {
	test('',
		'net'   => 'jPpg5.obl6',	# ##0000000000000000H.
		'sc'    => undef,			# 消失
		'open'  => 'fnkquv7jY2',	# ##0000000000000000.G
		'next'  => 'sgO7UmMnWw',	# ##0000000000000000.q
		'strb'  => undef,			# '#'
		'vips'  => 'jPpg5.obl6',	# ##0000000000000000H.
		'0chp'  => 'jPpg5.obl6',	# ##0000000000000000H.
		'bban'  => 'fnkquv7jY2',	# ##0000000000000000.G
		'machi' => undef,			# '#'
		'patio' => 'mF1QH4PEr.E',	# ##0000000000000000ab
		'4chan' => undef,			# 不明
		'ebbs'  => 'sgO7UmMnWw',	# ##0000000000000000.q
		'atchs' => undef,			# '#'
	);
	
	test('1',
		'net'   => 'tsGpSwX8mo',
		'sc'    => 'tsGpSwX8mo',
		'open'  => 'tsGpSwX8mo',
		'next'  => 'tsGpSwX8mo',
		'strb'  => 'tsGpSwX8mo',
		'vips'  => 'tsGpSwX8mo',
		'0chp'  => 'tsGpSwX8mo',
		'bban'  => 'tsGpSwX8mo',
		'machi' => 'tsGpSwX8mo',
		'patio' => 'GQP10890Qs2',
		'4chan' => 'tsGpSwX8mo',
		'ebbs'  => 'tsGpSwX8mo',
		'atchs' => 'tsGpSwX8mo',
	);
	test('12345678',
		'net'   => 'WBRXcNtpf.',
		'sc'    => 'WBRXcNtpf.',
		'open'  => 'WBRXcNtpf.',
		'next'  => 'WBRXcNtpf.',
		'strb'  => 'WBRXcNtpf.',
		'vips'  => 'WBRXcNtpf.',
		'0chp'  => 'WBRXcNtpf.',
		'bban'  => 'WBRXcNtpf.',
		'machi' => 'WBRXcNtpf.',
		'patio' => '1iBa.N.U2C6',
		'4chan' => 'WBRXcNtpf.',
		'ebbs'  => 'WBRXcNtpf.',
		'atchs' => 'WBRXcNtpf.',
	);
	test('ｱｲｳｴｵｶｷｸ',
		'net'   => 'XlUiP8mHCU',
		'sc'    => 'XlUiP8mHCU',
		'open'  => 'XlUiP8mHCU',
		'next'  => 'xmvISdVBK2',
		'strb'  => 'XlUiP8mHCU',
		'vips'  => 'XlUiP8mHCU',
		'0chp'  => 'XlUiP8mHCU',
		'bban'  => 'XlUiP8mHCU',
		'machi' => 'XlUiP8mHCU',
		'patio' => '1iBa.N.U2C6',
		'4chan' => 'XlUiP8mHCU',
		'ebbs'  => 'XlUiP8mHCU',
		'atchs' => '/c6GzZ6.UI',
	);
	test('ｋａｍｉ',
		'net'   => 'yGAhoNiShI',
		'sc'    => 'yGAhoNiShI',
		'open'  => 'yGAhoNiShI',
		'next'  => 'eRrBb7O29A',
		'strb'  => 'yGAhoNiShI',
		'vips'  => 'yGAhoNiShI',
		'0chp'  => 'yGAhoNiShI',
		'bban'  => 'yGAhoNiShI',
		'machi' => 'yGAhoNiShI',
		'patio' => '1Mq5Kc5CJKI',
		'4chan' => 'yGAhoNiShI',
		'ebbs'  => 'yGAhoNiShI',
		'atchs' => 'yGAhoNiShI',
	);
	test('騨ﾚNWKJ諤',
		'net'   => 'YYYYYYYYYY',
		'sc'    => 'YYYYYYYYYY',
		'open'  => 'YYYYYYYYYY',
		'next'  => 'lOOFR1xhP.',
		'strb'  => 'YYYYYYYYYY',
		'vips'  => 'YYYYYYYYYY',
		'0chp'  => 'YYYYYYYYYY',
		'bban'  => 'YYYYYYYYYY',
		'machi' => 'YYYYYYYYYY',
		'patio' => 'pjHcUWPwSY6',
		'4chan' => 'YYYYYYYYYY',
		'ebbs'  => 'YYYYYYYYYY',
		'atchs' => 'YYYYYYYYYY',
	);
	test('あいうえおか',
		'net'   => 'N0mUb9Yq8DyS',
		'sc'    => 'N0mUb9Yq8DyS',
		'open'  => 'N0mUb9Yq8DyS',
		'next'  => 'hhorpR4oiM',
		'strb'  => 'AU/OjWxByc',
		'vips'  => 'N0mUb9Yq8DyS',
		'0chp'  => 'N0mUb9Yq8DyS',
		'bban'  => 'N0mUb9Yq8DyS',
		'machi' => 'AU/OjWxByc',
		'patio' => 'yWz95C3I8Io',
		'4chan' => 'AU/OjWxByc',
		'ebbs'  => 'AU/OjWxByc',
		'atchs' => 'AU/OjWxByc',
	);
	test('1234567890123',
		'net'   => 'CNfebL9sP6Ci',
		'sc'    => 'CNfebL9sP6Ci',
		'open'  => 'CNfebL9sP6Ci',
		'next'  => 'WBRXcNtpf.',
		'strb'  => 'WBRXcNtpf.',
		'vips'  => 'CNfebL9sP6Ci',
		'0chp'  => 'CNfebL9sP6Ci',
		'bban'  => 'CNfebL9sP6Ci',
		'machi' => 'WBRXcNtpf.',
		'patio' => '1iBa.N.U2C6',
		'4chan' => 'WBRXcNtpf.',
		'ebbs'  => 'WBRXcNtpf.',
		'atchs' => 'WBRXcNtpf.',
	);
	test('123456789012',
		'net'   => 'jZk8zfYo4m4X',
		'sc'    => 'jZk8zfYo4m4X',
		'open'  => 'jZk8zfYo4m4X',
		'vips'  => 'jZk8zfYo4m4X',
		'0chp'  => 'jZk8zfYo4m4X',
		'bban'  => 'jZk8zfYo4m4X',
	);
	test('12345678901',
		'net'   => 'WBRXcNtpf.',
		'sc'    => 'WBRXcNtpf.',
		'open'  => 'WBRXcNtpf.',
		'vips'  => 'WBRXcNtpf.',
		'0chp'  => 'WBRXcNtpf.',
		'bban'  => 'WBRXcNtpf.',
	);
}

sub test_salt {
	test('0 !',
		'net'   => 'ZIJx7G/pyg',	# salt ..
		'sc'    => 'ZIJx7G/pyg',	# salt ..
		'open'  => 'ZIJx7G/pyg',	# salt ..
		'next'  => 'JB1xkjXQ86',	# salt .n
		'strb'  => 'ZIJx7G/pyg',	# salt ..
		'vips'  => 'ZIJx7G/pyg',	# salt ..
		'0chp'  => 'ZIJx7G/pyg',	# salt ..
		'bban'  => 'ZIJx7G/pyg',	# salt ..
		'machi' => 'ZIJx7G/pyg',	# salt ..
		'patio' => '/niSpUBWi4s',	# salt ab
		'4chan' => 'ZIJx7G/pyg',	# salt ..
		'ebbs'  => 'JB1xkjXQ86',	# salt .n
		'atchs' => 'ZIJx7G/pyg',	# salt ..
	);
	test('0-:',
		'net'   => 'NE0mkZ2TpI',	# salt .A
		'sc'    => 'NE0mkZ2TpI',	# salt .A
		'open'  => 'NE0mkZ2TpI',	# salt .A
		'next'  => 'tHGdgYtE5Y',	# salt zA
		'strb'  => 'NE0mkZ2TpI',	# salt .A
		'vips'  => 'NE0mkZ2TpI',	# salt .A
		'0chp'  => 'NE0mkZ2TpI',	# salt .A
		'bban'  => 'NE0mkZ2TpI',	# salt .A
		'machi' => 'NE0mkZ2TpI',	# salt .A
		'patio' => 'FQ6sqxr6Fqo',	# salt ab
		'4chan' => 'NE0mkZ2TpI',	# salt .A
		'ebbs'  => 'tHGdgYtE5Y',	# salt zA
		'atchs' => 'NE0mkZ2TpI',	# salt .A
	);
	test('0@[',
		'net'   => 'gkmryCvLz6',	# salt Ga
		'sc'    => 'gkmryCvLz6',	# salt Ga
		'open'  => 'gkmryCvLz6',	# salt Ga
		'next'  => 'gkmryCvLz6',	# salt Ga
		'strb'  => 'gkmryCvLz6',	# salt Ga
		'vips'  => 'gkmryCvLz6',	# salt Ga
		'0chp'  => 'gkmryCvLz6',	# salt Ga
		'bban'  => 'gkmryCvLz6',	# salt Ga
		'machi' => 'gkmryCvLz6',	# salt Ga
		'patio' => 'Vrukgc3M1f.',	# salt ab
		'4chan' => 'gkmryCvLz6',	# salt Ga
		'ebbs'  => 'gkmryCvLz6',	# salt Ga
		'atchs' => 'gkmryCvLz6',	# salt Ga
	);
	test('0`{',
		'net'   => 'WtDsB59Wrk',	# salt f.
		'sc'    => 'WtDsB59Wrk',	# salt f.
		'open'  => 'WtDsB59Wrk',	# salt f.
		'next'  => 'WtDsB59Wrk',	# salt f.
		'strb'  => 'WtDsB59Wrk',	# salt f.
		'vips'  => 'WtDsB59Wrk',	# salt f.
		'0chp'  => 'WtDsB59Wrk',	# salt f.
		'bban'  => 'WtDsB59Wrk',	# salt f.
		'machi' => 'WtDsB59Wrk',	# salt f.
		'patio' => '2vw7A38kVoU',	# salt ab
		'4chan' => 'WtDsB59Wrk',	# salt f.
		'ebbs'  => 'WtDsB59Wrk',	# salt f.
		'atchs' => 'WtDsB59Wrk',	# salt f.
	);
	test('0|}',
		'net'   => 'M6kra150Vk',	# salt ..
		'sc'    => 'M6kra150Vk',	# salt ..
		'open'  => 'M6kra150Vk',	# salt ..
		'next'  => 'M6kra150Vk',	# salt ..
		'strb'  => 'M6kra150Vk',	# salt ..
		'vips'  => 'M6kra150Vk',	# salt ..
		'0chp'  => 'M6kra150Vk',	# salt ..
		'bban'  => 'M6kra150Vk',	# salt ..
		'machi' => 'M6kra150Vk',	# salt ..
		'patio' => '/yKxoYDejWg',	# salt ab
		'4chan' => 'M6kra150Vk',	# salt ..
		'ebbs'  => 'M6kra150Vk',	# salt ..
		'atchs' => 'M6kra150Vk',	# salt ..
	);
}

sub test_0x80 {
	test('ム一0',
		'net'   => 'AOGu5v68Us',	# ##8300000000000000..
		'sc'    => '2n83UgFdjc',	# ##838088ea30000000..
		'open'  => '2n83UgFdjc',	# ##838088ea30000000..
		'next'  => 'lSFC4dj/8s',	# ##e383a0e4b8803000..
		'strb'  => '2n83UgFdjc',	# ##838088ea30000000..
		'vips'  => '2n83UgFdjc',	# ##838088ea30000000..
		'0chp'  => 'AOGu5v68Us',	# ##8300000000000000..
		'bban'  => '2n83UgFdjc',	# ##838088ea30000000..
		'machi' => '2n83UgFdjc',	# ##838088ea30000000..
		'patio' => '.tflz4.mW2.',	# ##838088ea30000000ab
		'4chan' => '2n83UgFdjc',	# ##838088ea30000000..
		'ebbs'  => '2n83UgFdjc',	# ##838088ea30000000..
		'atchs' => '2n83UgFdjc',	# ##838088ea30000000..
	);
	test('#838088ea30000000..',
		'net'   => 'AOGu5v68Us',	# ##8300000000000000..
		'sc'    => '2n83UgFdjc',	# ##838088ea30000000..
		'open'  => '2n83UgFdjc',	# ##838088ea30000000..
		'vips'  => '2n83UgFdjc',	# ##838088ea30000000..
		'0chp'  => 'AOGu5v68Us',	# ##8300000000000000..
		'bban'  => '2n83UgFdjc',	# ##838088ea30000000..
	);
	test('#830088ea30000000..',
		'net'   => 'AOGu5v68Us',	# ##8300000000000000..
		'sc'    => 'AOGu5v68Us',	# ##8300000000000000..
		'open'  => 'AOGu5v68Us',	# ##8300000000000000..
		'vips'  => 'AOGu5v68Us',	# ##8300000000000000..
		'0chp'  => 'AOGu5v68Us',	# ##8300000000000000..
	#	'0chp'  => '2n83UgFdjc',	# ##830088ea30000000.. with Crypt::UnixCrypt
		'bban'  => 'AOGu5v68Us',	# ##8300000000000000..
	);
}

sub test_nama {
	test('#3132333488eb93f3',
		'net'   => 'RpvqNQTwMA',
		'sc'    => 'RpvqNQTwMA',
		'open'  => 'RpvqNQTwMA',
		'next'  => 'ULUFJt9VDM',
		'strb'  => 'ULUFJt9VDM',
		'vips'  => 'RpvqNQTwMA',
		'0chp'  => 'RpvqNQTwMA',
		'bban'  => 'RpvqNQTwMA',
		'machi' => 'ULUFJt9VDM',
		'patio' => 'jATbp6Ebioo',
		'4chan' => 'ULUFJt9VDM',
		'ebbs'  => 'ULUFJt9VDM',
		'atchs' => 'ULUFJt9VDM',
	);
	test('#3132333488eb93F32',
		'net'   => 'AEFr9jFTX.',
		'sc'    => 'AEFr9jFTX.',
		'open'  => 'AEFr9jFTX.',
		'vips'  => 'AEFr9jFTX.',
		'0chp'  => 'AEFr9jFTX.',
		'bban'  => 'AEFr9jFTX.',
	);
	test('#3132333488EB93F323',
		'net'   => '0P0Iw3f8XA',
		'sc'    => '0P0Iw3f8XA',
		'open'  => '0P0Iw3f8XA',
		'vips'  => '0P0Iw3f8XA',
		'0chp'  => '0P0Iw3f8XA',
		'bban'  => '0P0Iw3f8XA',
	);
	test('#1234567890123456..abc',
		'net'   => '???',
		'sc'    => '???',
		'open'  => '???',
		'vips'  => '???',
		'0chp'  => '???',
		'bban'  => '???',
	);
}

sub test_sharp {
	test('#23456789012',
		'net'   => '???',
		'sc'    => '???',
		'open'  => '???',
		'next'  => 'y3.ScW8dbE',
		'strb'  => 'y3.ScW8dbE',
		'vips'  => '???',
		'0chp'  => '???',
		'bban'  => '???',
		'machi' => 'y3.ScW8dbE',
		'patio' => '/kQ.HUDyE.2',
		'4chan' => 'y3.ScW8dbE',
		'ebbs'  => 'y3.ScW8dbE',
		'atchs' => 'y3.ScW8dbE',
	);
	test('#2345678901',
		'net'   => 'y3.ScW8dbE',
		'sc'    => 'y3.ScW8dbE',
		'open'  => 'y3.ScW8dbE',
		'vips'  => 'y3.ScW8dbE',
		'0chp'  => 'y3.ScW8dbE',
		'bban'  => 'y3.ScW8dbE',
	);
}

sub test_dollar {
	test('$23456789012',
		'net'   => '???',
		'sc'    => '4QKLUa.0a8HzwPe',
		'open'  => '???',
		'next'  => 'BaNAE36vrg',
		'strb'  => 'BaNAE36vrg',
		'vips'  => '???',
		'0chp'  => '???',
		'bban'  => '???',
		'machi' => 'BaNAE36vrg',
		'patio' => '3JCiiSIcJns',
		'4chan' => 'BaNAE36vrg',
		'ebbs'  => 'BaNAE36vrg',
		'atchs' => 'BaNAE36vrg',
	);
	test('$2345678901',
		'net'   => 'BaNAE36vrg',
		'sc'    => 'BaNAE36vrg',
		'open'  => 'BaNAE36vrg',
		'vips'  => 'BaNAE36vrg',
		'0chp'  => 'BaNAE36vrg',
		'bban'  => 'BaNAE36vrg',
	);
	test('$ｱ3456789012',
		'net'   => '???',
		'sc'    => 'ﾆﾘﾋｾｵﾁ!｣ﾁﾚﾉｱｷﾛｺ',
		'open'  => '???',
		'vips'  => '???',
		'0chp'  => '???',
		'bban'  => '???',
	);
}

sub test_whitespace {
	test('  0  ',
		'net'   => 'SDtWOGt18E',	# #  0  
		'sc'    => 'SDtWOGt18E',	# #  0  
		'open'  => 'SDtWOGt18E',	# #  0  
		'next'  => '9C.MvjQ/kg',	# #  0
		'strb'  => '9C.MvjQ/kg',	# #  0
		'vips'  => 'SDtWOGt18E',	# #  0  
		'0chp'  => 'SDtWOGt18E',	# #  0  
		'bban'  => '9C.MvjQ/kg',	# #  0
		'machi' => '9C.MvjQ/kg',	# #  0
		'patio' => '6oAcXRksge.',	# #  0  
		'4chan' => 'SDtWOGt18E',	# #  0  
		'ebbs'  => '9C.MvjQ/kg',	# #  0
		'atchs' => '9C.MvjQ/kg',	# #  0
	);
	test("\t\t0\t\t",
		'net'   => 'LP6zoGudAI',	# #\t\t0\t\t
		'sc'    => 'LP6zoGudAI',	# #\t\t0\t\t
		'open'  => 'IGEMrmvKLI',	# #0
		'next'  => '1fNTPS6/lY',	# #\t\t0
		'strb'  => 'SDtWOGt18E',	# #  0  
		'vips'  => 'LP6zoGudAI',	# #\t\t0\t\t
		'0chp'  => 'LP6zoGudAI',	# #\t\t0\t\t
		'bban'  => '1fNTPS6/lY',	# #\t\t0
		'machi' => 'LP6zoGudAI',	# #\t\t0\t\t
		'patio' => 'yKAYabUo/ZU',	# #\t\t0\t\t
		'4chan' => 'LP6zoGudAI',	# #\t\t0\t\t
		'ebbs'  => '1fNTPS6/lY',	# #\t\t0
		'atchs' => '1fNTPS6/lY',	# #\t\t0
	);
}

sub test_replace_ascii {
	test("\t!,'&\"<>",
		'net'   => 'SRh/1cpRuQ',	# all checked
		'sc'    => 'SRh/1cpRuQ',	# all checked
		'open'  => 'yBXCHDOLjUlu',	# all checked
		'next'  => 'kPvUkTyX4w',	# #\t!,&#039
		'strb'  => 'lzy3sq4xRg',	# # !,'&&qu
		'vips'  => 'hHMvDMm.LVIx',	# all checked
		'0chp'  => 'SRh/1cpRuQ',	# all checked
		'bban'  => 'SRh/1cpRuQ',	# all checked
		'machi' => 'aN15v4ZISw',	# #\t!,'&amp
		'patio' => 'Fn0cLL6tnX6',	# #\t!,&#39;
		'4chan' => 'aN15v4ZISw',	# #\t!,'&amp
		'ebbs'  => 'kPvUkTyX4w',	# #\t!,&#039
		'atchs' => 'Y9QtvkYo1g',	# #\t!,&#039
	);
	test('&',
		'next'  => 'MhCJJ7GVT.',	# #&amp;
		'machi' => '17DqEfIfVI',	# #&amp
		'patio' => 'zcjb1/2NNqA',	# #&amp;
		'4chan' => 'MhCJJ7GVT.',	# #&amp;
		'ebbs'  => 'MhCJJ7GVT.',	# #&amp;
		'atchs' => 'MhCJJ7GVT.',	# #&amp;
	);
	test('"',
		'next'  => 'gt1azVccY2',	# #&quot;
		'strb'  => 'gt1azVccY2',	# #&quot;
		'machi' => 'gt1azVccY2',	# #&quot;
		'patio' => 'cHRF68MSGdc',	# #&quot;
		'4chan' => 'RYRu.UCnt.',	# #&amp;quo
		'ebbs'  => 'gt1azVccY2',	# #&quot;
		'atchs' => 'gt1azVccY2',	# #&quot;
	);
	test("'",
		'next'  => 'UtX4XpdDog',	# #&#039;
		'patio' => 'QcqA97SR2PQ',	# #&#39;
		'ebbs'  => 'UtX4XpdDog',	# #&#039;
		'atchs' => '2BBQL3Q2fE',	# #&#039;
	);
	test('<>',
		'next'  => 'Gw/f5wZwNg',	# #&lt;&gt;
		'strb'  => 'Gw/f5wZwNg',	# #&lt;&gt;
		'machi' => 'Gw/f5wZwNg',	# #&lt;&gt;
		'patio' => '6fnK3RL57.6',	# #&lt;&gt;
		'4chan' => 'Gw/f5wZwNg',	# #&lt;&gt;
		'ebbs'  => 'LI9hP7a95o',	# #&amp;lt;
		'atchs' => 'Gw/f5wZwNg',	# #&lt;&gt;
	);
	test('>',
		'ebbs'  => 'kr5gpZiZ.E',	# #&amp;gt;
	);
}

sub test_replace_other {
	test('◆★●■▲▼',
		'net'   => 'zd4pd7kAgJZj',	# #◆★●■▲▼
		'sc'    => 'zd4pd7kAgJZj',	# #◆★●■▲▼
		'open'  => 'fz3/aptwlOdo',	# #◇☆○□△▽
		'next'  => 'gYxGTYY5sQ',	# #◇☆?
		'strb'  => 'Q77oOrg3KE',	# #◇★●■
		'vips'  => 'zd4pd7kAgJZj',	# #◆★●■▲▼
		'0chp'  => 'zd4pd7kAgJZj',	# #◆★●■▲▼
		'bban'  => 'zd4pd7kAgJZj',	# #◆★●■▲▼
		'machi' => 'Q77oOrg3KE',	# #◇★●■
		'patio' => 'duK7p2mKvXM',	# #◇★●■
		'4chan' => 'tcrNoUGN/A',	# #◆★●■
		'ebbs'  => 'tcrNoUGN/A',	# #◆★●■
		'atchs' => 'KgfhKyvJN2',	# #◇☆●■
	);
	test('●■',
		'next'  => 'hQZRqa01jE',	# #●■
	);
	test('▲▼',
		'next'  => '9Lhc7QdEOk',	# #▲▼
		'strb'  => 'ehz4HbpU56',	# #▲▼
		'machi' => 'ehz4HbpU56',	# #▲▼
		'patio' => 'dQXNh6UAyS2',	# #▲▼
		'4chan' => 'ehz4HbpU56',	# #▲▼
		'ebbs'  => 'ehz4HbpU56',	# #▲▼
		'atchs' => 'ehz4HbpU56',	# #▲▼
	);
	test('＃＃',
		'net'   => 'xSK1SiC5MI',	# ###
		'sc'    => 'wOlE71ViKc',	# # #＃
		'open'  => 'dn4m8J5vno',	# #＃＃
		'next'  => '8SjNjRYO8U',	# #＃＃
		'strb'  => 'xSK1SiC5MI',	# ###
		'vips'  => 'dn4m8J5vno',	# #＃＃
		'0chp'  => '48cw0iifQw',	# ##＃
		'bban'  => 'dn4m8J5vno',	# #＃＃
		'machi' => 'xSK1SiC5MI',	# ###
		'patio' => 'Eewhm8s9K32',	# #＃＃
		'4chan' => 'dn4m8J5vno',	# #＃＃
		'ebbs'  => 'dn4m8J5vno',	# #＃＃
		'atchs' => 'dn4m8J5vno',	# #＃＃
	);
	
	test('fusianasan',
		'net'   => 'M2TLe2H2No',
		'sc'    => 'M2TLe2H2No',
		'open'  => 'M2TLe2H2No',
		'next'  => 'M2TLe2H2No',
		'strb'  => 'M2TLe2H2No',
		'vips'  => 'M2TLe2H2No',
		'0chp'  => 'M2TLe2H2No',
		'bban'  => 'M2TLe2H2No',
		'machi' => 'M2TLe2H2No',
		'patio' => 'IqmJD4plbT6',
		'4chan' => 'M2TLe2H2No',
		'ebbs'  => 'M2TLe2H2No',
		'atchs' => 'M2TLe2H2No',
	);
}

sub test_replace_check {
	test('1234567"',
		'open'  => 'DWQ0QMJveuYp',
		'vips'  => 'DWQ0QMJveuYp',
	);
	test('1234567890＃',
		'net'   => 'WBRXcNtpf.',
		'0chp'  => 'WBRXcNtpf.',
	);
	test("12345678901\t",
		'open'  => 'WBRXcNtpf.',
	);
	test('＃31318194313100001.',
		'net'   => '7ZE59iVq1I',
		'0chp'  => '7ZE59iVq1I',
	);
	
	test('＝氈',	# #\x81◆\x81
		'open'  => '3t.a1636RU',	# ##81819f8100000000..
		'strb'  => '3t.a1636RU',	# ##81819f8100000000..
		'machi' => 'kuOsPHb5U.',	# ##81819e8100000000..
		'patio' => 'VL26ZTv/iVA',	# ##81819e8100000000ab
		'atchs' => '3t.a1636RU',	# ##81819f8100000000..
	);
	test('＝煤',	# #\x81＃\x81
		'net'   => 'gelnF4z.L2',	# ##8181948100000000..
		'sc'    => '5/1DcKbAzo',	# ##8120238100000000..
		'strb'  => 'gelnF4z.L2',	# ##8181948100000000..
		'0chp'  => 'gelnF4z.L2',	# ##8181948100000000..
		'machi' => '..ACBJab2M',	# ##8123810000000000..
	);
}

sub test_character {
	test('≒',
		'net'   => 'X29NAsr4vY',	# ##81e0000000000000.H
		'sc'    => 'X29NAsr4vY',	# ##81e0000000000000.H
		'open'  => 'X29NAsr4vY',	# ##81e0000000000000.H
		'next'  => 'pWJiJpaJFQ',	# ##e289920000000000..
		'strb'  => 'X29NAsr4vY',	# ##81e0000000000000.H
		'vips'  => 'X29NAsr4vY',	# ##81e0000000000000.H
		'0chp'  => 'X29NAsr4vY',	# ##81e0000000000000.H
		'bban'  => 'X29NAsr4vY',	# ##81e0000000000000.H
		'machi' => '',	# #
		'patio' => '31jCORTn/1I',	# ##81e0000000000000ab
		'4chan' => '',	# #
		'ebbs'  => 'X29NAsr4vY',	# ##81e0000000000000.H
		'atchs' => 'X29NAsr4vY',	# ##81e0000000000000.H
	);
	test('①',
		'net'   => 'O1epwnpXkI',	# ##8740000000000000GH
		'sc'    => 'O1epwnpXkI',	# ##8740000000000000GH
		'open'  => 'cPUZU5OGFs',	# ##3f00000000000000H.
		'next'  => 'jtD6pvN4EA',	# ##e291a00000000000..
		'strb'  => 'O1epwnpXkI',	# ##8740000000000000GH
		'vips'  => 'O1epwnpXkI',	# ##8740000000000000GH
		'0chp'  => 'O1epwnpXkI',	# ##8740000000000000GH
		'bban'  => 'O1epwnpXkI',	# ##8740000000000000GH
		'machi' => '',	# #
		'patio' => '5uDA1VbkJNg',	# ##8740000000000000ab
		'4chan' => '',	# #
		'ebbs'  => 'O1epwnpXkI',	# ##8740000000000000GH
		'atchs' => 'cPUZU5OGFs',	# ##3f00000000000000H.
	);
	test('∑',
		'net'   => '/B.PMhC2og',	# ##8794000000000000.H
		'sc'    => '/B.PMhC2og',	# ##8794000000000000.H
		'open'  => 'cPUZU5OGFs',	# ##3f00000000000000H.
		'next'  => '',	# #
		'strb'  => '/B.PMhC2og',	# ##8794000000000000.H
		'vips'  => '/B.PMhC2og',	# ##8794000000000000.H
		'0chp'  => '/B.PMhC2og',	# ##8794000000000000.H
		'bban'  => '/B.PMhC2og',	# ##8794000000000000.H
		'machi' => '',	# #
		'patio' => 'OdCeM0OoNs6',	# ##8794000000000000ab
		'4chan' => '',	# #
		'ebbs'  => '/B.PMhC2og',	# ##8794000000000000.H
		'atchs' => 'cPUZU5OGFs',	# ##3f00000000000000H.
	);
	test('∵',
		'net'   => 'ZSDfnm3ZdA',	# ##81e6000000000000.H
		'sc'    => 'ZSDfnm3ZdA',	# ##81e6000000000000.H
		'open'  => 'ZSDfnm3ZdA',	# ##81e6000000000000.H
		'next'  => '',	# #
		'strb'  => 'ZSDfnm3ZdA',	# ##81e6000000000000.H
		'vips'  => 'ZSDfnm3ZdA',	# ##81e6000000000000.H
		'0chp'  => 'ZSDfnm3ZdA',	# ##81e6000000000000.H
		'bban'  => 'ZSDfnm3ZdA',	# ##81e6000000000000.H
		'machi' => '',	# #
		'patio' => 'm4keEUP2hrk',	# ##81e6000000000000ab
		'4chan' => '',	# #
		'ebbs'  => 'ZSDfnm3ZdA',	# ##81e6000000000000.H
		'atchs' => 'ZSDfnm3ZdA',	# ##81e6000000000000.H
	);
	test('№',
		'net'   => '6Y7URAxU/w',	# ##8782000000000000.H
		'sc'    => '6Y7URAxU/w',	# ##8782000000000000.H
		'open'  => 'cPUZU5OGFs',	# ##3f00000000000000H.
		'next'  => 'mZ5VUIGw1w',	# ##e284960000000000..
		'strb'  => '6Y7URAxU/w',	# ##8782000000000000.H
		'vips'  => '6Y7URAxU/w',	# ##8782000000000000.H
		'0chp'  => '6Y7URAxU/w',	# ##8782000000000000.H
		'bban'  => '6Y7URAxU/w',	# ##8782000000000000.H
		'machi' => '',	# #
		'patio' => 'aIw7kcFNlb2',	# ##8782000000000000ab
		'4chan' => '',	# #
		'ebbs'  => '6Y7URAxU/w',	# ##8782000000000000.H
		'atchs' => 'cPUZU5OGFs',	# ##3f00000000000000H.
	);
	test('Ⅲ',
		'net'   => 'fCIdwgO26w',	# ##8756000000000000VH
		'sc'    => 'fCIdwgO26w',	# ##8756000000000000VH
		'open'  => 'cPUZU5OGFs',	# ##3f00000000000000H.
		'next'  => '',	# #
		'strb'  => 'fCIdwgO26w',	# ##8756000000000000VH
		'vips'  => 'fCIdwgO26w',	# ##8756000000000000VH
		'0chp'  => 'fCIdwgO26w',	# ##8756000000000000VH
		'bban'  => 'fCIdwgO26w',	# ##8756000000000000VH
		'machi' => '',	# #
		'patio' => 'HwRx56CQ6lU',	# ##8756000000000000ab
		'4chan' => '',	# #
		'ebbs'  => 'fCIdwgO26w',	# ##8756000000000000VH
		'atchs' => 'cPUZU5OGFs',	# ##3f00000000000000H.
	);
	test('￢',
		'net'   => 'Nq6k.G36w2',	# ##81ca000000000000.H
		'sc'    => 'Nq6k.G36w2',	# ##81ca000000000000.H
		'open'  => 'cPUZU5OGFs',	# ##3f00000000000000H.
		'next'  => '',	# #
		'strb'  => 'Nq6k.G36w2',	# ##81ca000000000000.H
		'vips'  => 'Nq6k.G36w2',	# ##81ca000000000000.H
		'0chp'  => 'Nq6k.G36w2',	# ##81ca000000000000.H
		'bban'  => 'Nq6k.G36w2',	# ##81ca000000000000.H
		'machi' => '',	# #
		'patio' => 'J8X45culjcg',	# ##81ca000000000000ab
		'4chan' => '',	# #
		'ebbs'  => 'Nq6k.G36w2',	# ##81ca000000000000.H
		'atchs' => 'Nq6k.G36w2',	# ##81ca000000000000.H
	);
	test('ⅲ',
		'net'   => 'E1M5DyPeHw',	# ##fa42000000000000BH
		'sc'    => 'E1M5DyPeHw',	# ##fa42000000000000BH
		'open'  => 'cPUZU5OGFs',	# ##3f00000000000000H.
		'next'  => '',	# #
		'strb'  => 'k97z9JJE.M',	# ##eef1000000000000.H
		'vips'  => 'E1M5DyPeHw',	# ##fa42000000000000BH
		'0chp'  => 'E1M5DyPeHw',	# ##fa42000000000000BH
		'bban'  => 'E1M5DyPeHw',	# ##fa42000000000000BH
		'machi' => '',	# #
		'patio' => 'aqpP2uvzc5E',	# ##fa42000000000000ab
		'4chan' => '',	# #
		'ebbs'  => 'E1M5DyPeHw',	# ##fa42000000000000BH
		'atchs' => 'cPUZU5OGFs',	# ##3f00000000000000H.
	);
	test('￤',
		'net'   => 'BXxTN6uxnE',	# ##fa55000000000000UH
		'sc'    => 'BXxTN6uxnE',	# ##fa55000000000000UH
		'open'  => 'cPUZU5OGFs',	# ##3f00000000000000H.
		'next'  => '',	# #
		'strb'  => 'QONe/HtnOg',	# ##eefa000000000000.H
		'vips'  => 'BXxTN6uxnE',	# ##fa55000000000000UH
		'0chp'  => 'BXxTN6uxnE',	# ##fa55000000000000UH
		'bban'  => 'BXxTN6uxnE',	# ##fa55000000000000UH
		'machi' => '',	# #
		'patio' => 'jJoYM.5Lt6M',	# ##fa55000000000000ab
		'4chan' => '',	# #
		'ebbs'  => 'BXxTN6uxnE',	# ##fa55000000000000UH
		'atchs' => 'cPUZU5OGFs',	# ##3f00000000000000H.
	);
	test('―',
		'net'   => 'EL2CIVwtV6',	# ##815c000000000000bH
		'sc'    => 'EL2CIVwtV6',	# ##815c000000000000bH
		'open'  => 'EL2CIVwtV6',	# ##815c000000000000bH
		'next'  => 'VhoNrmdIjI',	# ##e280950000000000..
		'strb'  => 'EL2CIVwtV6',	# ##815c000000000000bH
		'vips'  => 'EL2CIVwtV6',	# ##815c000000000000bH
		'0chp'  => 'EL2CIVwtV6',	# ##815c000000000000bH
		'bban'  => 'EL2CIVwtV6',	# ##815c000000000000bH
		'machi' => '',	# #
		'patio' => '3XyKGCDTI7A',	# ##815c000000000000ab
		'4chan' => '',	# #
		'ebbs'  => 'EL2CIVwtV6',	# ##815c000000000000bH
		'atchs' => 'EL2CIVwtV6',	# ##815c000000000000bH
	);
	test('～',
		'net'   => 'Fg7tQabTMc',	# ##8160000000000000fH
		'sc'    => 'Fg7tQabTMc',	# ##8160000000000000fH
		'open'  => 'cPUZU5OGFs',	# ##3f00000000000000H.
		'next'  => '2nUHWotKCQ',	# ##efbd9e0000000000..
		'strb'  => 'Fg7tQabTMc',	# ##8160000000000000fH
		'vips'  => 'Fg7tQabTMc',	# ##8160000000000000fH
		'0chp'  => 'Fg7tQabTMc',	# ##8160000000000000fH
		'bban'  => 'Fg7tQabTMc',	# ##8160000000000000fH
		'machi' => '',	# #
		'patio' => '31jCORTn/1I',	# ##8160000000000000ab
		'4chan' => '',	# #
		'ebbs'  => 'Fg7tQabTMc',	# ##8160000000000000fH
		'atchs' => 'Fg7tQabTMc',	# ##8160000000000000fH
	);
	test('∥',
		'net'   => '3n1Bt/uhKo',	# ##8161000000000000aH
		'sc'    => '3n1Bt/uhKo',	# ##8161000000000000aH
		'open'  => 'cPUZU5OGFs',	# ##3f00000000000000H.
		'next'  => '',	# #
		'strb'  => '3n1Bt/uhKo',	# ##8161000000000000aH
		'vips'  => '3n1Bt/uhKo',	# ##8161000000000000aH
		'0chp'  => '3n1Bt/uhKo',	# ##8161000000000000aH
		'bban'  => '3n1Bt/uhKo',	# ##8161000000000000aH
		'machi' => '',	# #
		'patio' => 'ak./w2BcT4Q',	# ##8161000000000000ab
		'4chan' => '',	# #
		'ebbs'  => '3n1Bt/uhKo',	# ##8161000000000000aH
		'atchs' => '3n1Bt/uhKo',	# ##8161000000000000aH
	);
	test('－',
		'net'   => '29g6Md5az6',	# ##817c000000000000.H
		'sc'    => '29g6Md5az6',	# ##817c000000000000.H
		'open'  => 'cPUZU5OGFs',	# ##3f00000000000000H.
		'next'  => 'HMyU06RKY6',	# ##efbc8d0000000000..
		'strb'  => '29g6Md5az6',	# ##817c000000000000.H
		'vips'  => '29g6Md5az6',	# ##817c000000000000.H
		'0chp'  => '29g6Md5az6',	# ##817c000000000000.H
		'bban'  => '29g6Md5az6',	# ##817c000000000000.H
		'machi' => '',	# #
		'patio' => 'TmiaNz4z2dc',	# ##817c000000000000ab
		'4chan' => '',	# #
		'ebbs'  => '29g6Md5az6',	# ##817c000000000000.H
		'atchs' => '29g6Md5az6',	# ##817c000000000000.H
	);
	test('￠',
		'net'   => 'kpf9fyyAsw',	# ##8191000000000000.H
		'sc'    => 'kpf9fyyAsw',	# ##8191000000000000.H
		'open'  => 'cPUZU5OGFs',	# ##3f00000000000000H.
		'next'  => '',	# #
		'strb'  => 'kpf9fyyAsw',	# ##8191000000000000.H
		'vips'  => 'kpf9fyyAsw',	# ##8191000000000000.H
		'0chp'  => 'kpf9fyyAsw',	# ##8191000000000000.H
		'bban'  => 'kpf9fyyAsw',	# ##8191000000000000.H
		'machi' => '',	# #
		'patio' => 'C6t3h70Z70c',	# ##8191000000000000ab
		'4chan' => '',	# #
		'ebbs'  => 'kpf9fyyAsw',	# ##8191000000000000.H
		'atchs' => 'kpf9fyyAsw',	# ##8191000000000000.H
	);
	test('￡',
		'net'   => '.PkiEfvCys',	# ##8192000000000000.H
		'sc'    => '.PkiEfvCys',	# ##8192000000000000.H
		'open'  => 'cPUZU5OGFs',	# ##3f00000000000000H.
		'next'  => '',	# #
		'strb'  => '.PkiEfvCys',	# ##8192000000000000.H
		'vips'  => '.PkiEfvCys',	# ##8192000000000000.H
		'0chp'  => '.PkiEfvCys',	# ##8192000000000000.H
		'bban'  => '.PkiEfvCys',	# ##8192000000000000.H
		'machi' => '',	# #
		'patio' => 'Ks9VyzUe/Us',	# ##8192000000000000ab
		'4chan' => '',	# #
		'ebbs'  => '.PkiEfvCys',	# ##8192000000000000.H
		'atchs' => '.PkiEfvCys',	# ##8192000000000000.H
	);
	test('凜',
		'net'   => 'fH9fVUpi9E',	# ##eaa3000000000000.H
		'sc'    => 'fH9fVUpi9E',	# ##eaa3000000000000.H
		'open'  => 'fH9fVUpi9E',	# ##eaa3000000000000.H
		'next'  => '',	# #
		'strb'  => 'fH9fVUpi9E',	# ##eaa3000000000000.H
		'vips'  => 'fH9fVUpi9E',	# ##eaa3000000000000.H
		'0chp'  => 'fH9fVUpi9E',	# ##eaa3000000000000.H
		'bban'  => 'fH9fVUpi9E',	# ##eaa3000000000000.H
		'machi' => '',	# #
		'patio' => 'V8Sudx4x1Vs',	# ##eaa3000000000000ab
		'4chan' => '',	# #
		'ebbs'  => 'fH9fVUpi9E',	# ##eaa3000000000000.H
		'atchs' => 'fH9fVUpi9E',	# ##eaa3000000000000.H
	);
	test('彅',
		'net'   => 'RseVyuN7QQ',	# ##fa67000000000000gH
		'sc'    => 'RseVyuN7QQ',	# ##fa67000000000000gH
		'open'  => 'cPUZU5OGFs',	# ##3f00000000000000H.
		'next'  => '',	# #
		'strb'  => '33z9e8DJYI',	# ##ed4b000000000000KH
		'vips'  => 'RseVyuN7QQ',	# ##fa67000000000000gH
		'0chp'  => 'RseVyuN7QQ',	# ##fa67000000000000gH
		'bban'  => 'RseVyuN7QQ',	# ##fa67000000000000gH
		'machi' => '',	# #
		'patio' => 'NM8mam8c5Wc',	# ##fa67000000000000ab
		'4chan' => '',	# #
		'ebbs'  => 'RseVyuN7QQ',	# ##fa67000000000000gH
		'atchs' => 'cPUZU5OGFs',	# ##3f00000000000000H.
	);
	test('黑',
		'net'   => 'cghMPMNK6Y',	# ##fc4b000000000000KH
		'sc'    => 'cghMPMNK6Y',	# ##fc4b000000000000KH
		'open'  => 'cPUZU5OGFs',	# ##3f00000000000000H.
		'next'  => '',	# #
		'strb'  => 'mH/4fD.zCo',	# ##eeec000000000000.H
		'vips'  => 'cghMPMNK6Y',	# ##fc4b000000000000KH
		'0chp'  => 'cghMPMNK6Y',	# ##fc4b000000000000KH
		'bban'  => 'cghMPMNK6Y',	# ##fc4b000000000000KH
		'machi' => '',	# #
		'patio' => 'W80xSRTWdK6',	# ##fc4b000000000000ab
		'4chan' => '',	# #
		'ebbs'  => 'cghMPMNK6Y',	# ##fc4b000000000000KH
		'atchs' => 'cPUZU5OGFs',	# ##3f00000000000000H.
	);
	test('妺',
		'net'   => 'wzJo8IKZok',	# ##faa5000000000000.H
		'sc'    => 'wzJo8IKZok',	# ##faa5000000000000.H
		'open'  => 'cPUZU5OGFs',	# ##3f00000000000000H.
		'next'  => '',	# #
		'strb'  => 'qlUPGnKQXU',	# ##ed89000000000000.H
		'vips'  => 'wzJo8IKZok',	# ##faa5000000000000.H
		'0chp'  => 'wzJo8IKZok',	# ##faa5000000000000.H
		'bban'  => 'wzJo8IKZok',	# ##faa5000000000000.H
		'machi' => '',	# #
		'patio' => 'aK4nN1K9AUI',	# ##faa5000000000000ab
		'4chan' => '',	# #
		'ebbs'  => 'wzJo8IKZok',	# ##faa5000000000000.H
		'atchs' => 'cPUZU5OGFs',	# ##3f00000000000000H.
	);
	test('髙',
		'net'   => '4BOi.KXL4Y',	# ##fbfc000000000000.H
		'sc'    => '4BOi.KXL4Y',	# ##fbfc000000000000.H
		'open'  => 'cPUZU5OGFs',	# ##3f00000000000000H.
		'next'  => '',	# #
		'strb'  => 'r2A346jBC6',	# ##eee0000000000000.H
		'vips'  => '4BOi.KXL4Y',	# ##fbfc000000000000.H
		'0chp'  => '4BOi.KXL4Y',	# ##fbfc000000000000.H
		'bban'  => '4BOi.KXL4Y',	# ##fbfc000000000000.H
		'machi' => '',	# #
		'patio' => 'QckMMX1L2tE',	# ##fbfc000000000000ab
		'4chan' => '',	# #
		'ebbs'  => '4BOi.KXL4Y',	# ##fbfc000000000000.H
		'atchs' => 'cPUZU5OGFs',	# ##3f00000000000000H.
	);
	test('﨑',
		'net'   => 'iS0Sf/Zl1E',	# ##fab1000000000000.H
		'sc'    => 'iS0Sf/Zl1E',	# ##fab1000000000000.H
		'open'  => 'cPUZU5OGFs',	# ##3f00000000000000H.
		'next'  => '',	# #
		'strb'  => 'ijEjUAM5sw',	# ##ed95000000000000.H
		'vips'  => 'iS0Sf/Zl1E',	# ##fab1000000000000.H
		'0chp'  => 'iS0Sf/Zl1E',	# ##fab1000000000000.H
		'bban'  => 'iS0Sf/Zl1E',	# ##fab1000000000000.H
		'machi' => '',	# #
		'patio' => 'xtuCXNSwoFI',	# ##fab1000000000000ab
		'4chan' => '',	# #
		'ebbs'  => 'iS0Sf/Zl1E',	# ##fab1000000000000.H
		'atchs' => 'cPUZU5OGFs',	# ##3f00000000000000H.
	);
	test('﨧',
		'net'   => '3FY9N5W9Ws',	# ##fbd3000000000000.H
		'sc'    => '3FY9N5W9Ws',	# ##fbd3000000000000.H
		'open'  => 'cPUZU5OGFs',	# ##3f00000000000000H.
		'next'  => '',	# #
		'strb'  => 'CuSsRGhJxw',	# ##eeb7000000000000.H
		'vips'  => '3FY9N5W9Ws',	# ##fbd3000000000000.H
		'0chp'  => '3FY9N5W9Ws',	# ##fbd3000000000000.H
		'bban'  => '3FY9N5W9Ws',	# ##fbd3000000000000.H
		'machi' => '',	# #
		'patio' => 'Cl9tRh4vLr2',	# ##fbd3000000000000ab
		'4chan' => '',	# #
		'ebbs'  => '3FY9N5W9Ws',	# ##fbd3000000000000.H
		'atchs' => 'cPUZU5OGFs',	# ##3f00000000000000H.
	);
	test('塚',
		'net'   => 'e7JaI/rlAA',	# ##fa9c000000000000.H
		'sc'    => 'e7JaI/rlAA',	# ##fa9c000000000000.H
		'open'  => 'cPUZU5OGFs',	# ##3f00000000000000H.
		'next'  => '',	# #
		'strb'  => '.Azvb3mG0E',	# ##ed80000000000000.H
		'vips'  => 'e7JaI/rlAA',	# ##fa9c000000000000.H
		'0chp'  => 'e7JaI/rlAA',	# ##fa9c000000000000.H
		'bban'  => 'e7JaI/rlAA',	# ##fa9c000000000000.H
		'machi' => '',	# #
		'patio' => 'hDEYE9zPB9Q',	# ##fa9c000000000000ab
		'4chan' => '',	# #
		'ebbs'  => 'e7JaI/rlAA',	# ##fa9c000000000000.H
		'atchs' => 'cPUZU5OGFs',	# ##3f00000000000000H.
	);
	test('羽',
		'net'   => 'JwSd9nMFyI',	# ##fb92000000000000.H
		'sc'    => 'JwSd9nMFyI',	# ##fb92000000000000.H
		'open'  => 'cPUZU5OGFs',	# ##3f00000000000000H.
		'next'  => '',	# #
		'strb'  => 'K.S8LGPiZE',	# ##ee75000000000000uH
		'vips'  => 'JwSd9nMFyI',	# ##fb92000000000000.H
		'0chp'  => 'JwSd9nMFyI',	# ##fb92000000000000.H
		'bban'  => 'JwSd9nMFyI',	# ##fb92000000000000.H
		'machi' => '',	# #
		'patio' => 'YRdDaGiFRlA',	# ##fb92000000000000ab
		'4chan' => '',	# #
		'ebbs'  => 'JwSd9nMFyI',	# ##fb92000000000000.H
		'atchs' => 'cPUZU5OGFs',	# ##3f00000000000000H.
	);
	test('朗',
		'net'   => '3HK.lhpkUE',	# ##fae0000000000000.H
		'sc'    => '3HK.lhpkUE',	# ##fae0000000000000.H
		'open'  => 'cPUZU5OGFs',	# ##3f00000000000000H.
		'next'  => '',	# #
		'strb'  => 'SfZCJ/g.WA',	# ##edc4000000000000.H
		'vips'  => '3HK.lhpkUE',	# ##fae0000000000000.H
		'0chp'  => '3HK.lhpkUE',	# ##fae0000000000000.H
		'bban'  => '3HK.lhpkUE',	# ##fae0000000000000.H
		'machi' => '',	# #
		'patio' => 'trKTzVNbq.s',	# ##fae0000000000000ab
		'4chan' => '',	# #
		'ebbs'  => '3HK.lhpkUE',	# ##fae0000000000000.H
		'atchs' => 'cPUZU5OGFs',	# ##3f00000000000000H.
	);
	test('骶',	# U+9AB6 (E9 AA B6) in JIS X 0212
		'open'  => 'cPUZU5OGFs',	# ##3f00000000000000H.
		'next'  => '',	# #
		'strb'  => 'j0srOJyByE',	# ##81ac000000000000.H
		'4chan' => '',	# #
		'atchs' => 'AgAJj0YCtM',	# ##e9aab60000000000..
	);
	test('杮',	# U+676E (E6 9D AE) in JIS X 0212
		'open'  => 'cPUZU5OGFs',	# ##3f00000000000000H.
		'next'  => '',	# #
		'strb'  => 'j0srOJyByE',	# ##81ac000000000000.H
		'4chan' => '',	# #
		'atchs' => 'gFVntGVfmM',	# ##e69dae0000000000..
	);
	test("\x{00a5}",	# '¥' U+00A5 (C2 A5) in JIS X 0201
		'open'  => 'cPUZU5OGFs',	# ##3f00000000000000H.
		'next'  => 'oA2ex0/x92',	# ##c2a5000000000000.H
		'4chan' => '',	# #
		'atchs' => 'oA2ex0/x92',	# ##c2a5000000000000.H
	);
	test("\x{203e}",	# '‾' U+203E (E2 80 BE) in JIS X 0201?
		'open'  => 'cPUZU5OGFs',	# ##3f00000000000000H.
		'next'  => 'ChbEnx9JSM',	# ##e280be0000000000..
		'4chan' => '',	# #
		'atchs' => 'ChbEnx9JSM',	# ##e280be0000000000..
	);
	test("\x{304b}\x{309a}",	# 'か゚' U+304B U+309A (E3 81 8B E3 82 9A) in Unicode 3.0
		'open'  => '',	# #
		'next'  => 'sxQbPeczMg',	# ##e3818be3829a0000..
		'4chan' => '',	# #
		'atchs' => '',	# #
	);
	test("\x{214a}",	# '⅊' U+214A (E2 85 8A) in Unicode 3.2
		'open'  => '',	# #
		'next'  => 'oEm/SUE1.w',	# ##e2858a0000000000..
		'4chan' => '',	# #
		'atchs' => '',	# #
	);
#	test("\x{}",	# U+ ()
#		'open'  => '',	# #
#		'next'  => '',	# #
#		'4chan' => '',	# #
#		'atchs' => '',	# #
#	);
}

sub test_encoding {
	# E4 BF A1 E8 BB BD : 信軽 / 菫｡霆ｽ / 篆∴蚕
	test('信軽',	# E4 BF A1 E8 BB BD => 90 4D 8C 79 (utf8=>sjis)
		'atchs' => '7kFWX/qQYo',	# ##904d8c7900000000M.
	);
	test('菫｡霆ｽ',	# E8 8F AB EF BD A1 E9 9C 86 EF BD BD => E4 BF A1 E8 BB BD (utf8=>sjis)
		'atchs' => 'APAvffTKNY',	# ##e4bfa1e8bbbd0000..
	);
	test('篆∴蚕',	# E7 AF 86 E2 88 B4 E8 9A 95 => E2 BD 81 88 8E 5C (utf8=>sjis)
		'atchs' => 'xV10Cw674M',	# ##e2bd81888e5c0000..
	);
	# EB A7 A8 E3 B9 AD : 맨㹭 / ?ｨ羯ｭ / 襷?広
	test('맨㹭',	# EB A7 A8 E3 B9 AD => 3F A8 E3 B9 AD (sjis=>sjis)
		'atchs' => 'l9OGNUEGNg',	# ##3fa8e3b9ad000000.. #?ｨ羯ｭ
	);
	# E5 AD A5 EB B0 B4 : 孥밴 / 蟄??ｴ / 絖ル梓
	test('孥밴',	# E5 AD A5 EB B0 B4 => E3 4C 83 8B 88 B2 (eucjp=>sjis)
		'atchs' => 'M2oL7qG6dM',	# ##e34c838b88b20000L.
	);
	test('絖ル梓',	# E7 B5 96 E3 83 AB E6 A2 93 => E3 4C 83 8B 88 B2 (utf8=>sjis)
		'atchs' => 'M2oL7qG6dM',	# ##e34c838b88b20000L.
	);
	# E5 B3 B1 E3 A2 BE : 峱㢾 / 蟲ｱ罎ｾ / 絣宴⊂
	test('峱㢾',	# E5 B3 B1 E3 A2 BE => E3 52 89 83 81 BC (eucjp=>sjis)
		'atchs' => 'V3HdQo70SA',	# ##e352898381bc0000R.
	);
	test('蟲ｱ罎ｾ',	# E8 9F B2 EF BD B1 E7 BD 8E EF BD BE => E5 B3 B1 E3 A2 BE (utf8=>sjis)
		'atchs' => 'AABymBxNrU',	# ##e5b3b1e3a2be0000..
	);
	test('絣宴⊂',	# E7 B5 A3 E5 AE B4 E2 8A 82 => E3 52 89 83 81 BC (utf8=>sjis)
		'atchs' => 'V3HdQo70SA',	# ##e352898381bc0000R.
	);
	# E7 BC BA E5 BF B3 : 缺忳 / 郛ｺ蠢ｳ / 膽阪審
	test('缺忳',	# E7 BC BA E5 BF B3 (sjis=>sjis)
		'atchs' => 'WvHcc0tL/g',	# ##e7bcbae5bfb30000..
	);
	test('郛ｺ蠢ｳ',	# E9 83 9B EF BD BA E8 A0 A2 EF BD B3 => E7 BC BA E5 BF B3 (utf8=>sjis)
		'atchs' => 'WvHcc0tL/g',	# ##e7bcbae5bfb30000..
	);
	test('膽阪審',	# E8 86 BD E9 98 AA E5 AF A9 => E4 5B 8D E3 90 52 (utf8=>sjis)
		'atchs' => 'nXqoPlEsW.',	# ##e45b8de390520000a.
	);
	# E6 AD A3 E8 B9 AE : 正蹮 / 豁｣雹ｮ / 罩ｈ庚
	test('正蹮',	# E6 AD A3 E8 B9 AE (sjis=>sjis)
		'atchs' => 'sJaNondzgA',	# ##e6ada3e8b9ae0000..
	);
	test('豁｣雹ｮ',	# E8 B1 81 EF BD A3 E9 9B B9 EF BD AE => E6 AD A3 E8 B9 AE (utf8=>sjis)
		'atchs' => 'sJaNondzgA',	# ##e6ada3e8b9ae0000..
	);
	test('罩ｈ庚',	# E7 BD A9 EF BD 88 E5 BA 9A => E3 AB 82 88 8D 4D (utf8=>sjis)
		'atchs' => 'JF6srNhdqE',	# ##e3ab82888d4d0000..
	);
	# E6 A4 BB E4 BE AA : 椻侪 / 讀ｻ萓ｪ / 罎私妾
	test('椻侪',	# E6 A4 BB E4 BE AA (sjis=>sjis)
		'atchs' => '/ZlVOBaCDY',	# ##e6a4bbe4beaa0000..
	);
	test('讀ｻ萓ｪ',	# E8 AE 80 EF BD BB E8 90 93 EF BD AA => E6 A4 BB E4 BE AA (utf8=>sjis)
		'atchs' => '/ZlVOBaCDY',	# ##e6a4bbe4beaa0000..
	);
	test('罎私妾',	# E7 BD 8E E7 A7 81 E5 A6 BE => E3 A2 8E 84 8F A8 (utf8=>sjis)
		'atchs' => 'by3Lhxz1H6',	# ##e3a28e848fa80000..
	);
	# E5 AA BE E9 A1 B6 : 媾顶 / 蟐ｾ鬘ｶ / 紵冗ゞ
	test('媾顶',	# E5 AA BE E9 A1 B6 (sjis=>sjis)
		'atchs' => '4o.Bpl1ORc',	# ##e5aabee9a1b60000..
	);
	test('蟐ｾ鬘ｶ',	# E8 9F 90 EF BD BE E9 AC 98 EF BD B6 => E5 AA BE E9 A1 B6 (utf8=>sjis)
		'atchs' => '4o.Bpl1ORc',	# ##e5aabee9a1b60000..
	);
	test('紵冗ゞ',	# E7 B4 B5 E5 86 97 E3 82 9E => E3 49 8F E7 81 55 (utf8=>sjis)
		'atchs' => 'p.CsKTRhlE',	# ##e3498fe781550000I.
	);
	# E3 B6 BD EC B9 AA : 㶽칪 / 羝ｽ?ｪ / 禧曙巧
	test('㶽칪',	# E3 B6 BD EC B9 AA => E2 55 8F 8C 8D 49 (eucjp=>sjis)
		'atchs' => 'KLCGM8uxXI',	# ##e2558f8c8d490000U.
	);
	test('禧曙巧',	# E7 A6 A7 E6 9B 99 E5 B7 A7 => E2 55 8F 8C 8D 49 (utf8=>sjis)
		'atchs' => 'KLCGM8uxXI',	# ##e2558f8c8d490000U.
	);
	# EC B9 A8 E5 A4 BB : 침夻 / ?ｨ螟ｻ / 豺?せ
	test('침夻',	# EC B9 A8 E5 A4 BB => 3F A8 E5 A4 BB (sjis=>sjis)
		'atchs' => 'Hyot5W8Vhw',	# ##3fa8e5a4bb000000.. #?ｨ螟ｻ
	);
	# E7 B4 A6 E5 BC A9 : 紦弩 / 邏ｦ蠑ｩ / 膣?而
	test('紦弩',	# E7 B4 A6 E5 BC A9 (sjis=>sjis)
		'atchs' => '53rES.iYkg',	# ##e7b4a6e5bca90000..
	);
	test('邏ｦ蠑ｩ',	# E9 82 8F EF BD A6 E8 A0 91 EF BD A9 => E7 B4 A6 E5 BC A9 (utf8=>sjis)
		'atchs' => '53rES.iYkg',	# ##e7b4a6e5bca90000..
	);
	# EF AD A4 E0 B3 AE : ﭤ೮ / ?､犁ｮ / 鎰む凱
	test('ﭤ೮',	# EF AD A4 E0 B3 AE => E8 4C 82 DE 8A 4D (eucjp=>sjis)
		'atchs' => 'TE0wPGNiCg',	# ##e84c82de8a4d0000L.
	);
	test('鎰む凱',	# E9 8E B0 E3 82 80 E5 87 B1 => E8 4C 82 DE 8A 4D (utf8=>sjis)
		'atchs' => 'TE0wPGNiCg',	# ##e84c82de8a4d0000L.
	);
#	# 
#	test('',	# 
#		'atchs' => '',	# 
#	);
#	test('',	# 
#		'atchs' => '',	# 
#	);
#	test('',	# 
#		'atchs' => '',	# 
#	);
}

sub test {
	my ($key, %expects) = @_;
	foreach my $mode (keys %expects) {
		my ($result) = trip($key, $mode);
		my $diff = 0;
		if (defined $result && defined $expects{$mode}) {
			if ($result ne $expects{$mode}) {
				$diff = 1;
			}
		} elsif (defined $result || defined $expects{$mode}) {
			$diff = 1;
		}
		if ($diff) {
			if (utf8::is_utf8($key)) {
				my $valid = 1;
				my $outkey = encode($OUTENC, $key, sub { $valid = 0; '?' });
				if ($valid) {
					printf "key #$outkey\n";
				} else {
					my $keyhex = encode('utf8', $key);
					$keyhex =~ s/(.)/sprintf('%02X ', ord($1))/egso;
					$keyhex =~ s/ $//so;
					printf "key #$outkey ($keyhex)\n";
				}
			} else {
				my $outkey = $key;
				if ($outkey =~ /[^\x20-\x7e]/so) {
					my $keyhex = $key;
					$keyhex =~ s/(.)/sprintf('%02X ', ord($1))/egso;
					$keyhex =~ s/ $//so;
					printf "key #$outkey ($keyhex)\n";
				} else {
					printf "key #$outkey\n";
				}
			}
			print "  mode $mode\n";
			if (defined $result) {
				print '  result '.encode($OUTENC, $result)."\n";
			} else {
				print "  result [no trip]\n";
			}
			if (defined $expects{$mode}) {
				print '  expect '.encode($OUTENC, $expects{$mode})."\n";
			} else {
				print "  expect [no trip]\n";
			}
		}
	}
}

exit(main()) if (!defined caller);
