use utf8;
use strict;
use Encode;

sub main {
	# 31 32 33 34 : 1234 / 1234 / 1234
	test('31 32 33 34', '31 32 33 34');	# as ascii
	# E3 81 82 E3 81 84 : あい / 縺ゅ＞ / ?や?
	test('E3 81 82 E3 81 84', '82 A0 82 A2');	# from utf8 to sjis
	# EF BD B1 EF BD B2 : ｱｲ / ?ｱ?ｲ / 鐔縁讐
	test('EF BD B1 EF BD B2', 'E8 5C 89 8F 8F 51');	# from eucjp to sjis
	
	# E4 BF A1 E8 BB BD : 信軽 / 菫｡霆ｽ / 篆∴蚕
	test('E4 BF A1 E8 BB BD', '90 4D 8C 79');	# from utf8 to sjis
	test('E8 8F AB EF BD A1 E9 9C 86 EF BD BD', 'E4 BF A1 E8 BB BD');	# from utf8 to sjis
	test('E7 AF 86 E2 88 B4 E8 9A 95', 'E2 BD 81 88 8E 5C');	# from utf8 to sjis
	# EB A7 A8 E3 B9 AD : 맨㹭 / ?ｨ羯ｭ / 襷?広
	test('EB A7 A8 E3 B9 AD', '3F A8 E3 B9 AD');	# as sjis
	# E5 AD A5 EB B0 B4 : 孥밴 / 蟄??ｴ / 絖ル梓
	test('E5 AD A5 EB B0 B4', 'E3 4C 83 8B 88 B2');	# from eucjp to sjis
	test('E7 B5 96 E3 83 AB E6 A2 93', 'E3 4C 83 8B 88 B2');	# from utf8 to sjis
	# E5 B3 B1 E3 A2 BE : 峱㢾 / 蟲ｱ罎ｾ / 絣宴⊂
	test('E5 B3 B1 E3 A2 BE', 'E3 52 89 83 81 BC');	# from eucjp to sjis
	test('E8 9F B2 EF BD B1 E7 BD 8E EF BD BE', 'E5 B3 B1 E3 A2 BE');	# from utf8 to sjis
	test('E7 B5 A3 E5 AE B4 E2 8A 82', 'E3 52 89 83 81 BC');	# from utf8 to sjis
	# E7 BC BA E5 BF B3 : 缺忳 / 郛ｺ蠢ｳ / 膽阪審
	test('E7 BC BA E5 BF B3', 'E7 BC BA E5 BF B3');	# as utf8
	test('E9 83 9B EF BD BA E8 A0 A2 EF BD B3', 'E7 BC BA E5 BF B3');	# from utf8 to sjis
	test('E8 86 BD E9 98 AA E5 AF A9', 'E4 5B 8D E3 90 52');	# from utf8 to sjis
	# E6 AD A3 E8 B9 AE : 正蹮 / 豁｣雹ｮ / 罩ｈ庚
	test('E6 AD A3 E8 B9 AE', 'E6 AD A3 E8 B9 AE');	# as utf8
	test('E8 B1 81 EF BD A3 E9 9B B9 EF BD AE', 'E6 AD A3 E8 B9 AE');	# from utf8 to sjis
	test('E7 BD A9 EF BD 88 E5 BA 9A', 'E3 AB 82 88 8D 4D');	# from utf8 to sjis
	# E6 A4 BB E4 BE AA : 椻侪 / 讀ｻ萓ｪ / 罎私妾
	test('E6 A4 BB E4 BE AA', 'E6 A4 BB E4 BE AA');	# as utf8
	test('E8 AE 80 EF BD BB E8 90 93 EF BD AA', 'E6 A4 BB E4 BE AA');	# from utf8 to sjis
	test('E7 BD 8E E7 A7 81 E5 A6 BE', 'E3 A2 8E 84 8F A8');	# from utf8 to sjis
	# E5 AA BE E9 A1 B6 : 媾顶 / 蟐ｾ鬘ｶ / 紵冗ゞ
	test('E5 AA BE E9 A1 B6', 'E5 AA BE E9 A1 B6');	# as utf8
	test('E8 9F 90 EF BD BE E9 AC 98 EF BD B6', 'E5 AA BE E9 A1 B6');	# from utf8 to sjis
	test('E7 B4 B5 E5 86 97 E3 82 9E', 'E3 49 8F E7 81 55');	# from utf8 to sjis
	# E3 B6 BD EC B9 AA : 㶽칪 / 羝ｽ?ｪ / 禧曙巧
	test('E3 B6 BD EC B9 AA', 'E2 55 8F 8C 8D 49');	# from eucjp to sjis
	test('E7 A6 A7 E6 9B 99 E5 B7 A7', 'E2 55 8F 8C 8D 49');	# from utf8 to sjis
	# EC B9 A8 E5 A4 BB : 침夻 / ?ｨ螟ｻ / 豺?せ
	test('EC B9 A8 E5 A4 BB', '3F A8 E5 A4 BB');	# as sjis
	# E7 B4 A6 E5 BC A9 : 紦弩 / 邏ｦ蠑ｩ / 膣?而
	test('E7 B4 A6 E5 BC A9', 'E7 B4 A6 E5 BC A9');	# as utf8
	test('E9 82 8F EF BD A6 E8 A0 91 EF BD A9', 'E7 B4 A6 E5 BC A9');	# from utf8 to sjis
	
	return 0;
}

sub test {
	my ($str, $expect) = @_;
	$str =~ s/([0-9A-F]{2}) ?/chr hex $1/egi;
	$expect =~ s/([0-9A-F]{2}) ?/chr hex $1/egi;
	print 'string: '.str2hex($str)."\n";
	my $result = enc($str);
	if ($result ne $expect) {
		print '  result: '.str2hex($result)."\n";
		print '  expect: '.str2hex($expect)."\n";
		return 0;
	}
	return 1;
}

sub str2hex {
	my ($str) = @_;
	$str =~ s/(.)/sprintf('%02X ', ord($1))/ge;
	$str =~ s/ $//;
	return $str;
}

sub enc {
	my ($utf8) = @_;
	
	my $str = decode('utf8', $utf8);
	
	my $utf8sjis = 0;
	my $sjissjis = 0;
	my $eucjpsjis = 0;
	
	encode('sjis', $str, sub { $utf8sjis++; '' });
	decode('sjis', $utf8, sub { $sjissjis++; '' });
	decode('eucjp', $utf8, sub { $eucjpsjis++; '' });
	
	if ($utf8sjis <= $sjissjis && $utf8sjis <= $eucjpsjis) {
		return encode('sjis', $str);
	}
	if ($sjissjis <= $utf8sjis && $sjissjis <= $eucjpsjis) {
		return encode('sjis', decode('sjis', $utf8));
	}
	if ($eucjpsjis <= $utf8sjis && $eucjpsjis <= $sjissjis) {
		return encode('sjis', decode('eucjp', $utf8));
	}
	
	# unreachable
	return $utf8;
}

exit(main()) if (!defined caller);
