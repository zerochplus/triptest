use utf8;
use strict;

sub main {
	require 'trip.cgi';
	binmode(STDOUT);
	binmode(STDOUT, ':encoding(cp932)');
	test('',
		'jPpg5.obl6',	# net
		undef,			# sc / 消失
		'fnkquv7jY2',	# open
		'sgO7UmMnWw',	# next
		undef,			# strb / #
		'jPpg5.obl6',	# vips
		'jPpg5.obl6',	# 0chp
		'fnkquv7jY2',	# bban
		undef,			# machi / #
		'mF1QH4PEr.E',	# patio
		undef,			# 4chan / 不明
		'sgO7UmMnWw',	# ebbs
	);
	test('1',
		'tsGpSwX8mo',	# net
		'tsGpSwX8mo',	# sc
		'tsGpSwX8mo',	# open
		'tsGpSwX8mo',	# next
		'tsGpSwX8mo',	# strb
		'tsGpSwX8mo',	# vips
		'tsGpSwX8mo',	# 0chp
		'tsGpSwX8mo',	# bban
		'tsGpSwX8mo',	# machi
		'GQP10890Qs2',	# patio
		'tsGpSwX8mo',	# 4chan
		'tsGpSwX8mo',	# ebbs
	);
	test('12345678',
		'WBRXcNtpf.',	# net
		'WBRXcNtpf.',	# sc
		'WBRXcNtpf.',	# open
		'WBRXcNtpf.',	# next
		'WBRXcNtpf.',	# strb
		'WBRXcNtpf.',	# vips
		'WBRXcNtpf.',	# 0chp
		'WBRXcNtpf.',	# bban
		'WBRXcNtpf.',	# machi
		'1iBa.N.U2C6',	# patio
		'WBRXcNtpf.',	# 4chan
		'WBRXcNtpf.',	# ebbs
	);
	test('ｱｲｳｴｵｶｷｸ',
		'XlUiP8mHCU',	# net
		'XlUiP8mHCU',	# sc
		'XlUiP8mHCU',	# open
		'xmvISdVBK2',	# next
		'XlUiP8mHCU',	# strb
		'XlUiP8mHCU',	# vips
		'XlUiP8mHCU',	# 0chp
		'XlUiP8mHCU',	# bban
		'XlUiP8mHCU',	# machi
		'1iBa.N.U2C6',	# patio
		'XlUiP8mHCU',	# 4chan
		'XlUiP8mHCU',	# ebbs
	);
	test('ｱ23ｴｵｶｷｸ',
		'WBRXcNtpf.',	# net
		'WBRXcNtpf.',	# sc
		'WBRXcNtpf.',	# open
		'XrlOBrDwyU',	# next
		'WBRXcNtpf.',	# strb
		'WBRXcNtpf.',	# vips
		'WBRXcNtpf.',	# 0chp
		'WBRXcNtpf.',	# bban
		'WBRXcNtpf.',	# machi
		'1iBa.N.U2C6',	# patio
		'WBRXcNtpf.',	# 4chan
		'WBRXcNtpf.',	# ebbs
	);
	test('ｋａｍｉ',
		'yGAhoNiShI',	# net
		'yGAhoNiShI',	# sc
		'yGAhoNiShI',	# open
		'eRrBb7O29A',	# next
		'yGAhoNiShI',	# strb
		'yGAhoNiShI',	# vips
		'yGAhoNiShI',	# 0chp
		'yGAhoNiShI',	# bban
		'yGAhoNiShI',	# machi
		'1Mq5Kc5CJKI',	# patio
		'yGAhoNiShI',	# 4chan
		'yGAhoNiShI',	# ebbs
	);
	test('騨ﾚNWKJ諤',
		'YYYYYYYYYY',	# net
		'YYYYYYYYYY',	# sc
		'YYYYYYYYYY',	# open
		'lOOFR1xhP.',	# next
		'YYYYYYYYYY',	# strb
		'YYYYYYYYYY',	# vips
		'YYYYYYYYYY',	# 0chp
		'YYYYYYYYYY',	# bban
		'YYYYYYYYYY',	# machi
		'pjHcUWPwSY6',	# patio
		'YYYYYYYYYY',	# 4chan
		'YYYYYYYYYY',	# ebbs
	);
	test('#828b8281828d8289',
		'yGAhoNiShI',	# net
		'yGAhoNiShI',	# sc
		'yGAhoNiShI',	# open
		'NXUZ00CMW6',	# next
		'NXUZ00CMW6',	# strb
		'yGAhoNiShI',	# vips
		'yGAhoNiShI',	# 0chp
		'yGAhoNiShI',	# bban
		'NXUZ00CMW6',	# machi
		'9f2.YIAJSW.',	# patio
		'NXUZ00CMW6',	# 4chan
		'NXUZ00CMW6',	# ebbs
	);
	test('#828b8281828d8289.',
		'yGAhoNiShI',	# net
		'yGAhoNiShI',	# sc
		'yGAhoNiShI',	# open
		'NXUZ00CMW6',	# next
		'NXUZ00CMW6',	# strb
		'yGAhoNiShI',	# vips
		'yGAhoNiShI',	# 0chp
		'yGAhoNiShI',	# bban
		'NXUZ00CMW6',	# machi
		'9f2.YIAJSW.',	# patio
		'NXUZ00CMW6',	# 4chan
		'NXUZ00CMW6',	# ebbs
	);
	test('#828b8281828d8289..',
		'yGAhoNiShI',	# net
		'yGAhoNiShI',	# sc
		'yGAhoNiShI',	# open
		'NXUZ00CMW6',	# next
		'NXUZ00CMW6',	# strb
		'yGAhoNiShI',	# vips
		'yGAhoNiShI',	# 0chp
		'yGAhoNiShI',	# bban
		'NXUZ00CMW6',	# machi
		'9f2.YIAJSW.',	# patio
		'NXUZ00CMW6',	# 4chan
		'NXUZ00CMW6',	# ebbs
	);
	test('#3132333435363738',
		'XlUiP8mHCU',	# net
		'XlUiP8mHCU',	# sc
		'XlUiP8mHCU',	# open
		'ULUFJt9VDM',	# next
		'ULUFJt9VDM',	# strb
		'XlUiP8mHCU',	# vips
		'XlUiP8mHCU',	# 0chp
		'XlUiP8mHCU',	# bban
		'ULUFJt9VDM',	# machi
		'jATbp6Ebioo',	# patio
		'ULUFJt9VDM',	# 4chan
		'ULUFJt9VDM',	# ebbs
	);
	test('#31323334353637382',
		'1tWQFkUcLU',	# net
		'1tWQFkUcLU',	# sc
		'1tWQFkUcLU',	# open
		'ULUFJt9VDM',	# next
		'ULUFJt9VDM',	# strb
		'1tWQFkUcLU',	# vips
		'1tWQFkUcLU',	# 0chp
		'1tWQFkUcLU',	# bban
		'ULUFJt9VDM',	# machi
		'jATbp6Ebioo',	# patio
		'ULUFJt9VDM',	# 4chan
		'ULUFJt9VDM',	# ebbs
	);
	test('#313233343536373823',
		'WBRXcNtpf.',	# net
		'WBRXcNtpf.',	# sc
		'WBRXcNtpf.',	# open
		'ULUFJt9VDM',	# next
		'ULUFJt9VDM',	# strb
		'WBRXcNtpf.',	# vips
		'WBRXcNtpf.',	# 0chp
		'WBRXcNtpf.',	# bban
		'ULUFJt9VDM',	# machi
		'jATbp6Ebioo',	# patio
		'ULUFJt9VDM',	# 4chan
		'ULUFJt9VDM',	# ebbs
	);
	test('#3100000000000000H.',
		'tsGpSwX8mo',	# net
		'tsGpSwX8mo',	# sc
		'tsGpSwX8mo',	# open
		'6O5ptllf5k',	# next
		'6O5ptllf5k',	# strb
		'tsGpSwX8mo',	# vips
		'tsGpSwX8mo',	# 0chp
		'tsGpSwX8mo',	# bban
		'6O5ptllf5k',	# machi
		'0HsMU3YYzL6',	# patio
		'6O5ptllf5k',	# 4chan
		'6O5ptllf5k',	# ebbs
	);
	test('123456789',
		'WBRXcNtpf.',	# net
		'WBRXcNtpf.',	# sc
		'WBRXcNtpf.',	# open
		'WBRXcNtpf.',	# next
		'WBRXcNtpf.',	# strb
		'WBRXcNtpf.',	# vips
		'WBRXcNtpf.',	# 0chp
		'WBRXcNtpf.',	# bban
		'WBRXcNtpf.',	# machi
		'1iBa.N.U2C6',	# patio
		'WBRXcNtpf.',	# 4chan
		'WBRXcNtpf.',	# ebbs
	);
	test('1234567890',
		'WBRXcNtpf.',	# net
		'WBRXcNtpf.',	# sc
		'WBRXcNtpf.',	# open
		'WBRXcNtpf.',	# next
		'WBRXcNtpf.',	# strb
		'WBRXcNtpf.',	# vips
		'WBRXcNtpf.',	# 0chp
		'WBRXcNtpf.',	# bban
		'WBRXcNtpf.',	# machi
		'1iBa.N.U2C6',	# patio
		'WBRXcNtpf.',	# 4chan
		'WBRXcNtpf.',	# ebbs
	);
	test('12345678901',
		'WBRXcNtpf.',	# net
		'WBRXcNtpf.',	# sc
		'WBRXcNtpf.',	# open
		'WBRXcNtpf.',	# next
		'WBRXcNtpf.',	# strb
		'WBRXcNtpf.',	# vips
		'WBRXcNtpf.',	# 0chp
		'WBRXcNtpf.',	# bban
		'WBRXcNtpf.',	# machi
		'1iBa.N.U2C6',	# patio
		'WBRXcNtpf.',	# 4chan
		'WBRXcNtpf.',	# ebbs
	);
	test('123456789012',
		'jZk8zfYo4m4X',	# net
		'jZk8zfYo4m4X',	# sc
		'jZk8zfYo4m4X',	# open
		'WBRXcNtpf.',	# next
		'WBRXcNtpf.',	# strb
		'jZk8zfYo4m4X',	# vips
		'jZk8zfYo4m4X',	# 0chp
		'jZk8zfYo4m4X',	# bban
		'WBRXcNtpf.',	# machi
		'1iBa.N.U2C6',	# patio
		'WBRXcNtpf.',	# 4chan
		'WBRXcNtpf.',	# ebbs
	);
	test('1234567890123',
		'CNfebL9sP6Ci',	# net
		'CNfebL9sP6Ci',	# sc
		'CNfebL9sP6Ci',	# open
		'WBRXcNtpf.',	# next
		'WBRXcNtpf.',	# strb
		'CNfebL9sP6Ci',	# vips
		'CNfebL9sP6Ci',	# 0chp
		'CNfebL9sP6Ci',	# bban
		'WBRXcNtpf.',	# machi
		'1iBa.N.U2C6',	# patio
		'WBRXcNtpf.',	# 4chan
		'WBRXcNtpf.',	# ebbs
	);
	test('あいうえおか',
		'N0mUb9Yq8DyS',	# net
		'N0mUb9Yq8DyS',	# sc
		'N0mUb9Yq8DyS',	# open
		'hhorpR4oiM',	# next
		'AU/OjWxByc',	# strb
		'N0mUb9Yq8DyS',	# vips
		'N0mUb9Yq8DyS',	# 0chp
		'N0mUb9Yq8DyS',	# bban
		'AU/OjWxByc',	# machi
		'yWz95C3I8Io',	# patio
		'AU/OjWxByc',	# 4chan
		'AU/OjWxByc',	# ebbs
	);
	test('$2345678901',
		'BaNAE36vrg',	# net
		'BaNAE36vrg',	# sc
		'BaNAE36vrg',	# open
		'BaNAE36vrg',	# next
		'BaNAE36vrg',	# strb
		'BaNAE36vrg',	# vips
		'BaNAE36vrg',	# 0chp
		'BaNAE36vrg',	# bban
		'BaNAE36vrg',	# machi
		'3JCiiSIcJns',	# patio
		'BaNAE36vrg',	# 4chan
		'BaNAE36vrg',	# ebbs
	);
	test('$23456789012',
		'???',				# net
		'4QKLUa.0a8HzwPe',	# sc
		'???',				# open
		'BaNAE36vrg',		# next
		'BaNAE36vrg',		# strb
		'???',				# vips
		'???',				# 0chp
		'???',				# bban
		'BaNAE36vrg',		# machi
		'3JCiiSIcJns',		# patio
		'BaNAE36vrg',		# 4chan
		'BaNAE36vrg',		# ebbs
	);
	test('$..........2',
		'???',				# net
		'RqK!0i.t49rNji7',	# sc
		'???',				# open
		'bwOnxXJup.',		# next
		'bwOnxXJup.',		# strb
		'???',				# vips
		'???',				# 0chp
		'???',				# bban
		'bwOnxXJup.',		# machi
		'02NgA38l.qI',		# patio
		'bwOnxXJup.',		# 4chan
		'bwOnxXJup.',		# ebbs
	);
	test('$｡3456789012',
		'???',				# net
		'ｾﾍｵﾏﾝｷｩｳﾚﾔ･ｴﾋ･ｴ',	# sc
		'???',				# open
		'3A/Hqpzc9c',		# next
		'RhQIlLvzs6',		# strb
		'???',				# vips
		'???',				# 0chp
		'???',				# bban
		'RhQIlLvzs6',		# machi
		'ns3QsnnftmU',		# patio
		'RhQIlLvzs6',		# 4chan
		'RhQIlLvzs6',		# ebbs
	);
	test('$｡1008343131',
		'???',				# net
		'ﾃｽﾄ!ｹﾏﾜｬｴ･ｧﾎﾖｲﾎ',	# sc
		'???',				# open
		'hkjDnZZGPM',		# next
		'lEjCdVtEDo',		# strb
		'???',				# vips
		'???',				# 0chp
		'???',				# bban
		'lEjCdVtEDo',		# machi
		'UJGgZRgio5A',		# patio
		'lEjCdVtEDo',		# 4chan
		'lEjCdVtEDo',		# ebbs
	);
	test('$ｱｲｳｴｵｱｲｳｴｵｱｲｳｴｵ',
		'???',				# net
		'ｳﾟｾﾉｪ｣ﾈﾊﾍｬﾏﾟｦｳｹ',	# sc
		'???',				# open
		'OS8Cx1YIIk',		# next
		'Nxf9REt3eA',		# strb
		'???',				# vips
		'???',				# 0chp
		'???',				# bban
		'Nxf9REt3eA',		# machi
		'uzipAJnBCXw',		# patio
		'Nxf9REt3eA',		# 4chan
		'Nxf9REt3eA',		# ebbs
	);
	test('#23456789012',
		'???',			# net
		'???',			# sc
		'???',			# open
		'y3.ScW8dbE',	# next
		'y3.ScW8dbE',	# strb
		'???',			# vips
		'???',			# 0chp
		'???',			# bban
		'y3.ScW8dbE',	# machi
		'/kQ.HUDyE.2',	# patio
		'y3.ScW8dbE',	# 4chan
		'y3.ScW8dbE',	# ebbs
	);
	test('#1234567890123456..abc',
		'???',			# net
		'???',			# sc
		'???',			# open
		'Oi/x1UMuw.',	# next
		'Oi/x1UMuw.',	# strb
		'???',			# vips
		'???',			# 0chp
		'???',			# bban
		'Oi/x1UMuw.',	# machi
		'OYvAb3AA/Vc',	# patio
		'Oi/x1UMuw.',	# 4chan
		'Oi/x1UMuw.',	# ebbs
	);
	test('ホムホム',
		'QD4TDVpNOM',	# net
		'L809q.Wvdk',	# sc
		'L809q.Wvdk',	# open
		'C93qWoB2hg',	# next
		'L809q.Wvdk',	# strb
		'L809q.Wvdk',	# vips
		'QD4TDVpNOM',	# 0chp
		'L809q.Wvdk',	# bban
		'L809q.Wvdk',	# machi
		'nPRdUdp37f2',	# patio
		'L809q.Wvdk',	# 4chan
		'L809q.Wvdk',	# ebbs
	);
	test('#837a8380837a8380z.',
		'QD4TDVpNOM',	# net
		'L809q.Wvdk',	# sc
		'L809q.Wvdk',	# open
		'RzVraEhVVs',	# next
		'RzVraEhVVs',	# strb
		'L809q.Wvdk',	# vips
		'QD4TDVpNOM',	# 0chp
		'L809q.Wvdk',	# bban
		'RzVraEhVVs',	# machi
		'lvp6WTecHrI',	# patio
		'RzVraEhVVs',	# 4chan
		'RzVraEhVVs',	# ebbs
	);
	test('◆●★',
		'dTHrbNrOw.',	# net
		'dTHrbNrOw.',	# sc
		'RNM4OlZz7s',	# open
		'yNZt80OfCs',	# next
		'YZQgr.7WNI',	# strb
		'dTHrbNrOw.',	# vips
		'dTHrbNrOw.',	# 0chp
		'dTHrbNrOw.',	# bban
		'YZQgr.7WNI',	# machi
		'ub6VtoVDrhM',	# patio
		'dTHrbNrOw.',	# 4chan
		'dTHrbNrOw.',	# ebbs
	);
	test('■▲▼',
		'GExJOqup6A',	# net
		'GExJOqup6A',	# sc
		'MOZcYuJkdU',	# open
		'qkC5YKQWyg',	# next
		'GExJOqup6A',	# strb
		'GExJOqup6A',	# vips
		'GExJOqup6A',	# 0chp
		'GExJOqup6A',	# bban
		'GExJOqup6A',	# machi
		'au8rdKNKXv.',	# patio
		'GExJOqup6A',	# 4chan
		'GExJOqup6A',	# ebbs
	);
	test('◆★',
		'9hhQmDPmK2',	# net
		'9hhQmDPmK2',	# sc
		'DVlEzgbdkE',	# open
		'pF26cWkf/Q',	# next
		'wJ5itNiesE',	# strb
		'9hhQmDPmK2',	# vips
		'9hhQmDPmK2',	# 0chp
		'9hhQmDPmK2',	# bban
		'wJ5itNiesE',	# machi
		'bhqKOtOojug',	# patio
		'9hhQmDPmK2',	# 4chan
		'9hhQmDPmK2',	# ebbs
	);
	test('<>"&',
		'f0abm3NbDw',	# net
		'f0abm3NbDw',	# sc
		'7gGRCKani97t',	# open
		'Gw/f5wZwNg',	# next
		'Gw/f5wZwNg',	# strb
		'7gGRCKani97t',	# vips
		'f0abm3NbDw',	# 0chp
		'f0abm3NbDw',	# bban
		'Gw/f5wZwNg',	# machi
		'6fnK3RL57.6',	# patio
		'Gw/f5wZwNg',	# 4chan
		'LI9hP7a95o',	# ebbs
	);
	test('<>',
		'3wNccY4njg',	# net
		'3wNccY4njg',	# sc
		'Gw/f5wZwNg',	# open
		'Gw/f5wZwNg',	# next
		'Gw/f5wZwNg',	# strb
		'Gw/f5wZwNg',	# vips
		'3wNccY4njg',	# 0chp
		'3wNccY4njg',	# bban
		'Gw/f5wZwNg',	# machi
		'6fnK3RL57.6',	# patio
		'Gw/f5wZwNg',	# 4chan
		'LI9hP7a95o',	# ebbs
	);
	test('"',
		'4eqVTkonjE',	# net
		'4eqVTkonjE',	# sc
		'gt1azVccY2',	# open
		'gt1azVccY2',	# next
		'gt1azVccY2',	# strb
		'gt1azVccY2',	# vips
		'4eqVTkonjE',	# 0chp
		'4eqVTkonjE',	# bban
		'gt1azVccY2',	# machi
		'cHRF68MSGdc',	# patio
		'RYRu.UCnt.',	# 4chan
		'gt1azVccY2',	# ebbs
	);
	test("'",
		'8/08awL.AE',	# net
		'8/08awL.AE',	# sc
		'HA0pkXpKB6',	# open
		'UtX4XpdDog',	# next
		'8/08awL.AE',	# strb
		'HA0pkXpKB6',	# vips
		'8/08awL.AE',	# 0chp
		'8/08awL.AE',	# bban
		'8/08awL.AE',	# machi
		'QcqA97SR2PQ',	# patio
		'8/08awL.AE',	# 4chan
		'UtX4XpdDog',	# ebbs
	);
	test('&',
		'2r2Ga7GHRc',	# net
		'2r2Ga7GHRc',	# sc
		'2r2Ga7GHRc',	# open
		'MhCJJ7GVT.',	# next
		'2r2Ga7GHRc',	# strb
		'2r2Ga7GHRc',	# vips
		'2r2Ga7GHRc',	# 0chp
		'2r2Ga7GHRc',	# bban
		'17DqEfIfVI',	# machi
		'zcjb1/2NNqA',	# patio
		'MhCJJ7GVT.',	# 4chan
		'MhCJJ7GVT.',	# ebbs
	);
	test('!',
		'KNs1o0VDv6',	# net
		'KNs1o0VDv6',	# sc
		'KNs1o0VDv6',	# open
		'KNs1o0VDv6',	# next
		'KNs1o0VDv6',	# strb
		'KNs1o0VDv6',	# vips
		'KNs1o0VDv6',	# 0chp
		'KNs1o0VDv6',	# bban
		'KNs1o0VDv6',	# machi
		'WL1zJlMqfCM',	# patio
		'KNs1o0VDv6',	# 4chan
		'KNs1o0VDv6',	# ebbs
	);
	test(',',
		'YeQQgdCJE6',	# net
		'YeQQgdCJE6',	# sc
		'YeQQgdCJE6',	# open
		'YeQQgdCJE6',	# next
		'YeQQgdCJE6',	# strb
		'YeQQgdCJE6',	# vips
		'YeQQgdCJE6',	# 0chp
		'YeQQgdCJE6',	# bban
		'YeQQgdCJE6',	# machi
		'eXdD4qEaHlQ',	# patio
		'YeQQgdCJE6',	# 4chan
		'YeQQgdCJE6',	# ebbs
	);
	test('1234567&',
		'q3.yfaIC5s',	# net
		'q3.yfaIC5s',	# sc
		'q3.yfaIC5s',	# open
		'q3.yfaIC5s',	# next
		'q3.yfaIC5s',	# strb
		'q3.yfaIC5s',	# vips
		'q3.yfaIC5s',	# 0chp
		'q3.yfaIC5s',	# bban
		'q3.yfaIC5s',	# machi
		'n0BFJyHNYuw',	# patio
		'q3.yfaIC5s',	# 4chan
		'q3.yfaIC5s',	# ebbs
	);
	test('1234567"',
		'4qJVtuc8yc',	# net
		'4qJVtuc8yc',	# sc
		'DWQ0QMJveuYp',	# open
		'q3.yfaIC5s',	# next
		'q3.yfaIC5s',	# strb
		'DWQ0QMJveuYp',	# vips
		'4qJVtuc8yc',	# 0chp
		'4qJVtuc8yc',	# bban
		'q3.yfaIC5s',	# machi
		'n0BFJyHNYuw',	# patio
		'q3.yfaIC5s',	# 4chan
		'q3.yfaIC5s',	# ebbs
	);
	test('＃',
		'u2YjtUz8MU',	# net
		'68NHrw0u9M',	# sc
		'e57oZ1fb1o',	# open
		'By6DvOdjOA',	# next
		'u2YjtUz8MU',	# strb
		'e57oZ1fb1o',	# vips
		'u2YjtUz8MU',	# 0chp
		'e57oZ1fb1o',	# bban
		'u2YjtUz8MU',	# machi
		'5dDmbWcvHQ2',	# patio
		'e57oZ1fb1o',	# 4chan
		'e57oZ1fb1o',	# ebbs
	);
	test(' ＃',
		'68NHrw0u9M',	# net
		'g3.NWF1Chs',	# sc
		'PlnfWZhzek',	# open
		'.Agbc1OR8c',	# next
		'68NHrw0u9M',	# strb
		'PlnfWZhzek',	# vips
		'68NHrw0u9M',	# 0chp
		'PlnfWZhzek',	# bban
		'68NHrw0u9M',	# machi
		'6P5FYZ3aJ3k',	# patio
		'PlnfWZhzek',	# 4chan
		'PlnfWZhzek',	# ebbs
	);
	test('＃＃',
		'xSK1SiC5MI',	# net
		'wOlE71ViKc',	# sc
		'dn4m8J5vno',	# open
		'8SjNjRYO8U',	# next
		'xSK1SiC5MI',	# strb
		'dn4m8J5vno',	# vips
		'48cw0iifQw',	# 0chp
		'dn4m8J5vno',	# bban
		'xSK1SiC5MI',	# machi
		'Eewhm8s9K32',	# patio
		'dn4m8J5vno',	# 4chan
		'dn4m8J5vno',	# ebbs
	);
	test('＝煤＃',
		'0ZaZ6Ph9YM',	# net
		'8Ifcd5IMRw',	# sc
		'pnkCIOJmhY',	# open
		'u/UThijc9k',	# next
		'0ZaZ6Ph9YM',	# strb
		'pnkCIOJmhY',	# vips
		'0ZaZ6Ph9YM',	# 0chp
		'pnkCIOJmhY',	# bban
		'ILA35PqZQE',	# machi
		'BzKBQH5tylA',	# patio
		'pnkCIOJmhY',	# 4chan
		'pnkCIOJmhY',	# ebbs
	);
	test('123456789012＃',
		'RITzbxS2I3J9',	# net
		'aKqOHnvuUtkd',	# sc
		'.sf3a0vVPg6Q',	# open
		'WBRXcNtpf.',	# next
		'WBRXcNtpf.',	# strb
		'.sf3a0vVPg6Q',	# vips
		'RITzbxS2I3J9',	# 0chp
		'.sf3a0vVPg6Q',	# bban
		'WBRXcNtpf.',	# machi
		'1iBa.N.U2C6',	# patio
		'WBRXcNtpf.',	# 4chan
		'WBRXcNtpf.',	# ebbs
	);
	test('1234567890＃',
		'WBRXcNtpf.',	# net
		'.oWZrnJVutMW',	# sc
		'VIJJSV7/Fqfl',	# open
		'WBRXcNtpf.',	# next
		'WBRXcNtpf.',	# strb
		'VIJJSV7/Fqfl',	# vips
		'WBRXcNtpf.',	# 0chp
		'VIJJSV7/Fqfl',	# bban
		'WBRXcNtpf.',	# machi
		'1iBa.N.U2C6',	# patio
		'WBRXcNtpf.',	# 4chan
		'WBRXcNtpf.',	# ebbs
	);
	test('＃3456789012',
		'lg6Q/4u.i.',	# net
		'VlTC9VCYT7DD',	# sc
		'fbYpKBXnp7Oj',	# open
		'p2nGyNlkqo',	# next
		'lg6Q/4u.i.',	# strb
		'fbYpKBXnp7Oj',	# vips
		'lg6Q/4u.i.',	# 0chp
		'fbYpKBXnp7Oj',	# bban
		'lg6Q/4u.i.',	# machi
		'b3B23rtXcYE',	# patio
		'oLUwO8zJDE',	# 4chan
		'oLUwO8zJDE',	# ebbs
	);
	test('＃31318194313100001.',
		'7ZE59iVq1I',	# net
		'j6J/iuF0lYOO',	# sc
		'f9AYGqFM9G6T',	# open
		'wHuJ.Rjqa2',	# next
		'JFUJu00dRM',	# strb
		'f9AYGqFM9G6T',	# vips
		'7ZE59iVq1I',	# 0chp
		'f9AYGqFM9G6T',	# bban
		'JFUJu00dRM',	# machi
		'3quFX4KCbCA',	# patio
		'jcRaOUsIrk',	# 4chan
		'jcRaOUsIrk',	# ebbs
	);
	test('＝噤＝氈',
		'Pcn5KeK8IQ',	# net
		'Pcn5KeK8IQ',	# sc
		'Pcn5KeK8IQ',	# open
		'cZaFShsneI',	# next
		'Pcn5KeK8IQ',	# strb
		'Pcn5KeK8IQ',	# vips
		'Pcn5KeK8IQ',	# 0chp
		'Pcn5KeK8IQ',	# bban
		'SFAQHB9jpw',	# machi
		'TbfudtHiano',	# patio
		'Pcn5KeK8IQ',	# 4chan
		'Pcn5KeK8IQ',	# ebbs
	);
	test('fusianasan',
		'M2TLe2H2No',	# net
		'M2TLe2H2No',	# sc
		'M2TLe2H2No',	# open
		'M2TLe2H2No',	# next
		'M2TLe2H2No',	# strb
		'M2TLe2H2No',	# vips
		'M2TLe2H2No',	# 0chp
		'M2TLe2H2No',	# bban
		'M2TLe2H2No',	# machi
		'IqmJD4plbT6',	# patio
		'M2TLe2H2No',	# 4chan
		'M2TLe2H2No',	# ebbs
	);
	test('①Ⅰ㍉㈱',
		'Az6yZqa0I2',	# net
		'Az6yZqa0I2',	# sc
		'Vyfxi/dpqw',	# open
		'e3LOKfsWv2',	# next
		'Az6yZqa0I2',	# strb
		'Az6yZqa0I2',	# vips
		'Az6yZqa0I2',	# 0chp
		'Az6yZqa0I2',	# bban
		'Az6yZqa0I2',	# machi
		'CuOm6lMouYE',	# patio
		'Az6yZqa0I2',	# 4chan
		'Az6yZqa0I2',	# ebbs
	);
	test('～',
		'Fg7tQabTMc',	# net
		'Fg7tQabTMc',	# sc
		'cPUZU5OGFs',	# open
		'2nUHWotKCQ',	# next
		'Fg7tQabTMc',	# strb
		'Fg7tQabTMc',	# vips
		'Fg7tQabTMc',	# 0chp
		'Fg7tQabTMc',	# bban
		'Fg7tQabTMc',	# machi
		'31jCORTn/1I',	# patio
		'Fg7tQabTMc',	# 4chan
		'Fg7tQabTMc',	# ebbs
	);
	test('一一',
		'b3B4i2sLpY',	# net
		'b3B4i2sLpY',	# sc
		'b3B4i2sLpY',	# open
		'VAhc1fHCZ2',	# next
		'b3B4i2sLpY',	# strb
		'b3B4i2sLpY',	# vips
		'b3B4i2sLpY',	# 0chp
		'b3B4i2sLpY',	# bban
		'b3B4i2sLpY',	# machi
		'wrFukDbqx0g',	# patio
		'b3B4i2sLpY',	# 4chan
		'b3B4i2sLpY',	# ebbs
	);
	test('0 !',
		'ZIJx7G/pyg',	# net
		'ZIJx7G/pyg',	# sc
		'ZIJx7G/pyg',	# open
		'JB1xkjXQ86',	# next
		'ZIJx7G/pyg',	# strb
		'ZIJx7G/pyg',	# vips
		'ZIJx7G/pyg',	# 0chp
		'ZIJx7G/pyg',	# bban
		'ZIJx7G/pyg',	# machi
		'/niSpUBWi4s',	# patio
		'ZIJx7G/pyg',	# 4chan
		'JB1xkjXQ86',	# ebbs
	);
	test('0-:',
		'NE0mkZ2TpI',	# net
		'NE0mkZ2TpI',	# sc
		'NE0mkZ2TpI',	# open
		'tHGdgYtE5Y',	# next
		'NE0mkZ2TpI',	# strb
		'NE0mkZ2TpI',	# vips
		'NE0mkZ2TpI',	# 0chp
		'NE0mkZ2TpI',	# bban
		'NE0mkZ2TpI',	# machi
		'FQ6sqxr6Fqo',	# patio
		'NE0mkZ2TpI',	# 4chan
		'tHGdgYtE5Y',	# ebbs
	);
	test('0@[',
		'gkmryCvLz6',	# net
		'gkmryCvLz6',	# sc
		'gkmryCvLz6',	# open
		'gkmryCvLz6',	# next
		'gkmryCvLz6',	# strb
		'gkmryCvLz6',	# vips
		'gkmryCvLz6',	# 0chp
		'gkmryCvLz6',	# bban
		'gkmryCvLz6',	# machi
		'Vrukgc3M1f.',	# patio
		'gkmryCvLz6',	# 4chan
		'gkmryCvLz6',	# ebbs
	);
	test('0`{',
		'WtDsB59Wrk',	# net
		'WtDsB59Wrk',	# sc
		'WtDsB59Wrk',	# open
		'WtDsB59Wrk',	# next
		'WtDsB59Wrk',	# strb
		'WtDsB59Wrk',	# vips
		'WtDsB59Wrk',	# 0chp
		'WtDsB59Wrk',	# bban
		'WtDsB59Wrk',	# machi
		'2vw7A38kVoU',	# patio
		'WtDsB59Wrk',	# 4chan
		'WtDsB59Wrk',	# ebbs
	);
	test('0|}',
		'M6kra150Vk',	# net
		'M6kra150Vk',	# sc
		'M6kra150Vk',	# open
		'M6kra150Vk',	# next
		'M6kra150Vk',	# strb
		'M6kra150Vk',	# vips
		'M6kra150Vk',	# 0chp
		'M6kra150Vk',	# bban
		'M6kra150Vk',	# machi
		'/yKxoYDejWg',	# patio
		'M6kra150Vk',	# 4chan
		'M6kra150Vk',	# ebbs
	);
	test("0\x090",
		'sXoB65CSvY',	# net
		'sXoB65CSvY',	# sc
		'/lQMO72QVo',	# open
		'sXoB65CSvY',	# next
		'OeKveLL.YQ',	# strb
		'sXoB65CSvY',	# vips
		'sXoB65CSvY',	# 0chp
		'sXoB65CSvY',	# bban
		'sXoB65CSvY',	# machi
		'j80bUaYWE9A',	# patio
		'sXoB65CSvY',	# 4chan
		'sXoB65CSvY',	# ebbs
	);
}

sub test {
	my ($key, @expects) = @_;
	my @modes = qw(net sc open next strb vips 0chp bban machi patio 4chan ebbs);
	my @results = ();
	for my $i (0 .. $#modes) {
		my ($result, undef, undef, undef, undef) = trip($key, $modes[$i]);
		$results[$i] = $result;
		my $diff = 0;
		if (defined $results[$i] && defined $expects[$i]) {
			if ($results[$i] ne $expects[$i]) {
				$diff = 1;
			}
		} elsif (defined $results[$i] || defined $expects[$i]) {
			$diff = 1;
		}
		if ($diff) {
			print "key #$key\n";
			print "  mode $modes[$i]\n";
			if (defined $results[$i]) {
				print "  result $results[$i]\n";
			} else {
				print "  result [no trip]\n";
			}
			if (defined $expects[$i]) {
				print "  expect $expects[$i]\n";
			} else {
				print "  expect [no trip]\n";
			}
		}
	}
}

exit(main()) if (!defined caller);
