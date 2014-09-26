#!/usr/bin/perl

#-------------------------------------------------------------------------------
#
#	おそらく２ちゃんねる仕様に一番近いトリップテスター
#
#	----------------------------------------------------------------------------
#
#	This program made by windyakin ◆windyaking ( http://windyakin.net/ )
#
#	Last up date 2014.09.25
#
#-------------------------------------------------------------------------------

use utf8;
use strict;

use lib '.';
use CGI;
use Crypt::UnixCrypt;
use Digest::SHA::PurePerl qw(sha1_base64);

our $VERSION = '20140925';

sub main {
	my $query = CGI->new();
	
	# クエリ整理
	my $text = $query->param('text'); # ※sjisバイト列のまま扱う
	my $sc = $query->param('sc');
	my $check1 = ($sc ? ' checked' : '');
	my $nama = $query->param('nama');
	my $check2 = ($nama ? ' checked' : '');
	my $leave = $query->param('leave');
	my $check3 = (!defined $text || $leave ? ' checked' : '');
	my $kote = $query->param('kote');
	my $check4 = ($kote ? ' checked' : '');
	
	binmode(STDOUT);
	binmode(STDOUT, ':encoding(cp932)');
	
	print "Content-type: text/html; charset=Shift_JIS\n\n";
	print <<EOT;
<!DOCTYPE html>
<html lang="ja">
<body>

EOT
	
	# トリップ変換/表示処理
	if (defined $text) {
		print "<pre>\n";
		
		binmode(STDOUT);
		
		open(my $lines, '<', \$text);
		while (<$lines>) {
			my $line = $_;
			$line =~ s/\r?\n\z//;
			
			if ($line =~ /#([\x00-\xff]*)\z/) {
				my ($trip, $key1, $key2, $key, $type) = trip($1, $sc);
				
				$trip = sanitize($trip);
				$key = sanitize($key1) if (defined $key1);
				$key2 = sanitize($key2) if (defined $key2);
				
				print sanitize($`).' ' if ($kote);
				print "\x81\x9f$trip : ";
				if ($nama && ($type eq '10trip' || $type eq '10nama')) {
					print "#$key2 #$key1\n";
				} else {
					print "#$key\n";
				}
			}
		}
		close($lines);
		
		binmode(STDOUT);
		binmode(STDOUT, ':encoding(cp932)');
		
		print "</pre><hr>\n\n";
	}
	
	print <<EOT;
<form method="post">
<input type="submit" value="テスト">
<input type="checkbox" name="sc" id="sc" value="1"$check1><label for="sc">.sc仕様</label>
<input type="checkbox" name="nama" id="nama" value="1"$check2><label for="nama">生キー相互変換</label>
<input type="checkbox" name="kote" id="kote" value="1"$check4><label for="kote">コテハンも表示</label>
<input type="checkbox" name="leave" id="leave" value="1"$check3><label for="leave">テキストを残す</label>
<br>
EOT

	print '<textarea name="text" rows="10" style="width:700px;">';
	if ($leave) {
		binmode(STDOUT);
		print $text;
		binmode(STDOUT);
		binmode(STDOUT, ':encoding(cp932)');
	}
	print "</textarea>\n";
	
	print <<EOT;
</form>

</body>
</html>
EOT
	
	return 0;
}

#-------------------------------------------------------------------------------
#
#	文字列無毒化
#
#-------------------------------------------------------------------------------
sub sanitize {
	my ($str) = @_;
	$str =~ s/&/&amp;/g;
	$str =~ s/</&lt;/g;
	$str =~ s/>/&gt;/g;
	return $str;
}

#-------------------------------------------------------------------------------
#
#	トリップ生成 ※sjisバイト列
#
#-------------------------------------------------------------------------------
sub trip {
	my ($key, $sc) = @_;
	
	my $trip = '???';
	my $key1 = undef;
	my $key2 = undef;
	my $type = 'unknown';
	
	my $_key = $key;
	if ($sc) {
		$_key =~ s/\x81\x94/ #/;
	} else {
		while ($_key =~ s/^((?:[\x20-\x7e\xa1-\xdf]|[\x81-\x9f\xe0-\xfc][\x40-\x7e\x80-\xfc])*?)\x81\x94/$1#/) { }
	}
	
	# キー長が12bytes未満なら10桁トリップ
	if (length($_key) < 12) {
		
		$type = '10trip';
		
		$key1 = $key;
		
		# 生キーに変換
		$key2 = key2nama($_key);
		
		# キーからソルトを決定
		my $salt = (length($_key) > 1 ? substr($_key, 1) : '');
		$salt = substr("${salt}H.", 0, 2);
		$salt =~ s/[^\.-z]/\./go;
		$salt =~ tr/:;<=>?@[\\]^_`/ABCDEFGabcdef/;
		
		# 0x80問題再現
		if (!$sc) {
			$_key =~ s/\x80[\x00-\xff]*$//;
		}
		
		# 10桁トリップ生成
		$trip = substr(crypt($_key, $salt), -10);
		
	# キー長が12bytes以上で生キー形式なら10桁トリップ
	} elsif ($_key =~ /^#([0-9a-zA-Z]{16})([\.\/0-9A-Za-z]{0,2})$/ ) {
		
		$type = '10nama';
		
		# 生キーあるいはキーからソルトを決定
		my $salt = substr("$2..", 0, 2);
		$salt =~ s/[^\.-z]/\./go;
		$salt =~ tr/:;<=>?@[\\]^_`/ABCDEFGabcdef/;
		
		$key2 = "#$1$salt";
		
		# 生キーからキーを復元
		$_key = pack('H*', $1);
		
		# キーを正常化(sjis)
		$key1 = key2sjis($_key, $salt);
		
		# 0x80問題再現
		if (!$sc) {
			$_key =~ s/\x80[\x00-\xff]*$//;
		}
		
		# 10桁トリップ生成
		$trip = substr(crypt($_key, $salt), -10);
		
	# キー長が12bytes以上で先頭が$なら15桁トリップ
	} elsif ($_key =~ /^\$/) {
		
		$key1 = $key;
		
		if ($sc) {
			$type = '15trip';
			
			# 15桁トリップ生成
			$trip = substr(sha1_base64($_key), 3, 15);
			$trip =~ tr/\/+/!./;
			
			# 2バイト目が半角カタカナならカタカナトリップ
			if ($_key =~ /^\$[\xa1-\xdf]/) { # [｡-ﾟ]
				$type = '15kana';
				$trip =~ tr/0-9A-Za-z.!/\xa1-\xdf!/;
			}
		} else {
			$trip = '???';
		}
		
	# キー長が12bytes以上で先頭が#なら未定義
	} elsif ($key =~ /^#/) {
		
		$key1 = $key;
		
		$trip = '???';
		
	# キー長が12bytes以上でどれでもなければなら12桁トリップ
	} else {
		
		$type = '12trip';
		
		$key1 = $key;
		
		# 12桁トリップ生成
		$trip = substr(sha1_base64($_key), 0, 12);
		$trip =~ tr/+/./;
		
	}
	
	return ($trip, $key1, $key2, $key, $type);
}

#-------------------------------------------------------------------------------
#
#	10桁キー→生キー変換 ※sjisバイト列
#
#-------------------------------------------------------------------------------
sub key2nama {
	my ($key) = @_;
	
	$key = substr($key, 0, 8);
	
	my $salt = (length($key) > 1 ? substr($key, 1) : '');
	$salt = substr("${salt}H.", 0, 2);
	$salt =~ s/[^\.-z]/\./go;
	$salt =~ tr/:;<=>?@[\\]^_`/ABCDEFGabcdef/;
	
	$key =~ s/([\x00-\xff])/unpack('H2', $1)/eg;
	
	$key .= '0' x (16 - length($key));
	
	return "#$key$salt";
}

#-------------------------------------------------------------------------------
#
#	10桁キー正常化 ※sjisバイト列
#
#-------------------------------------------------------------------------------
sub key2sjis {
	my ($key, $salt) = @_;
	
	$key =~ s/\x00+$//;
	
	my $salt2 = (length($key) > 1 ? substr($key, 1) : '');
	$salt2 = substr("${salt2}H.", 0, 2);
	$salt2 =~ s/[^\.-z]/\./go;
	$salt2 =~ tr/:;<=>?@[\\]^_`/ABCDEFGabcdef/;
	
	if ($salt2 eq $salt) {
		if ($key =~ /^(?:[\x20-\x7e\xa1-\xdf]|[\x81-\x9f\xe0-\xfc][\x40-\x7e\x80-\xfc])+([\x81-\x9f\xe0-\xfc]?)$/) {
			if ($1 eq '') {
				return $key;
			} elsif (length($key) == 8) {
				$key .= ($1 eq "\x87" ? "\x80" : "\xa0");
				return $key;
			}
		}
	}
	
	return undef;
}

exit(main()) if (!defined caller);
1;
