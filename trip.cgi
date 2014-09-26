#!/usr/bin/perl

#-------------------------------------------------------------------------------
#
#	おそらく２ちゃんねる仕様に一番近いトリップテスター
#
#	----------------------------------------------------------------------------
#
#	This program made by windyakin ◆windyaking ( http://windyakin.net/ )
#
#	Last up date 2014.09.26
#
#-------------------------------------------------------------------------------

use utf8;
use strict;

use lib '.';
use Encode;
use CGI;
use Crypt::UnixCrypt;
use Digest::SHA::PurePerl qw(sha1_base64);

our $VERSION = '20140926';
my $ISUTF8 = ('◆' eq "\x{25C6}");

sub main {
	my $query = CGI->new();
	
	# クエリ整理
	my $text = $query->param('text');
	my $mode = $query->param('mode');
	my $nama = $query->param('nama');
	my $kote = $query->param('kote');
	my $leave = $query->param('leave');
	$text = decode('utf8', $text) if (defined $text);
	$mode = 'net' if (!defined $mode || ($mode ne 'net' && $mode ne 'sc' &&
						$mode ne 'open' && $mode ne 'next' && $mode ne 'strb'));
	
	my $selectnet = ($mode eq 'net' ? ' selected' : '');
	my $selectsc = ($mode eq 'sc' ? ' selected' : '');
	my $selectopen = ($mode eq 'open' ? ' selected' : '');
	my $selectnext = ($mode eq 'next' ? ' selected' : '');
	my $selectstrb = ($mode eq 'strb' ? ' selected' : '');
	my $checknama = ($nama ? ' checked' : '');
	my $checkkote = ($kote ? ' checked' : '');
	my $checkleave = (!defined $text || $leave ? ' checked' : '');
	
	binmode(STDOUT);
	binmode(STDOUT, ':utf8') if ($ISUTF8);
	
	print "Content-type: text/html; charset=UTF-8\n\n";
	print <<EOT;
<!DOCTYPE html>
<html lang="ja">
<body>

EOT
	
	# トリップ変換/表示処理
	if (defined $text) {
		print "<pre>\n";
		
		my @lines = split(/\r?\n/, $text);
		foreach my $line (@lines) {
			if ($line =~ /#([\s\S]*)\z/) {
				my ($trip, $key1, $key2, $key, $type) = trip($1, $mode);
				
				$trip = sanitize($trip);
				$key = sanitize($key);
				$key1 = sanitize($key1) if (defined $key1);
				$key2 = sanitize($key2) if (defined $key2);
				
				print sanitize($`).' ' if ($kote);
				print "◆$trip : ";
				if ($nama && ($type eq '10trip' || $type eq '10nama')) {
					print "#$key2 #$key1\n";
				} else {
					print "#$key\n";
				}
			}
		}
		
		print "</pre><hr>\n\n";
	}
	
	print <<EOT;
<form method="post">
<input type="submit" value="テスト">
<select name="mode">
<option value="net"$selectnet>2ch.net</option>
<option value="sc"$selectsc>2ch.sc</option>
<option value="open"$selectopen>open2ch.net</option>
<option value="next"$selectnext>next2ch.net</option>
<option value="strb"$selectstrb>したらば</option>
</select>
<input type="checkbox" name="nama" id="nama" value="1"$checknama><label for="nama">生キー相互変換</label>
<input type="checkbox" name="kote" id="kote" value="1"$checkkote><label for="kote">コテハンも表示</label>
<input type="checkbox" name="leave" id="leave" value="1"$checkleave><label for="leave">テキストを残す</label>
<br>
EOT

	print '<textarea name="text" rows="10" style="width:700px;">';
	print sanitize($text) if ($leave);
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
#	トリップ生成 ※キーは内部コード(utf8)
#
#-------------------------------------------------------------------------------
sub trip {
	my ($key, $mode) = @_;
	
	my $trip = '???';
	my $key1 = undef;
	my $key2 = undef;
	my $type = 'unknown';
	
	my $_key = $key;
	
	# 事前置換処理
	if ($mode eq 'net' || $mode eq 'strb') {
		$_key =~ s/＃/#/g;
	}
	if ($mode eq 'open') {
		$_key =~ s/\t//g;
		$_key =~ s/</&lt;/g;
		$_key =~ s/>/&gt;/g;
		$_key =~ s/"/&quot;/g;
		$_key =~ s/'/&#39;/g;
		$_key =~ tr/■▲▼★●◆/□△▽☆○◇/;
	}
	if ($mode eq 'next') {
		$_key =~ s/&/&amp;/g;
		$_key =~ s/</&lt;/g;
		$_key =~ s/>/&gt;/g;
		$_key =~ s/"/&quot;/g;
		$_key =~ s/'/&#039;/g;
		$_key =~ tr/★◆/☆◇/;
	}
	if ($mode eq 'strb') {
		$_key =~ s/\t/ /g;
		$_key =~ s/</&lt;/g;
		$_key =~ s/>/&gt;/g;
		$_key =~ s/"/&quot;/g;
		$_key =~ tr/◆/◇/;
	}
	
	# 文字コード関連
	if ($mode eq 'net' || $mode eq 'sc' || $mode eq 'strb') {
		$_key = encode('cp932', $_key);
	}
	if ($mode eq 'open') {
		$_key = encode('sjis', $_key);
	}
	if ($mode eq 'next') {
		$_key = encode('utf8', $_key);
	}
	
	# 事前置換処理
	if ($mode eq 'sc') {
		$_key =~ s/\x81\x94/ #/;
	}
	
	# キー長が12bytes未満なら10桁トリップ
	if (length($_key) < 12 || $mode eq 'next' || $mode eq 'strb') {
		
		$type = '10trip';
		
		$key1 = $key;
		
		# 生キーに変換
		$key2 = key2nama($_key);
		
		# キーからソルトを決定
		my $salt = (length($_key) > 1 ? substr($_key, 1) : '');
		$salt = substr("${salt}H.", 0, 2);
		if ($mode eq 'net' || $mode eq 'sc' || $mode eq 'open' || $mode eq 'strb') {
			$salt =~ s/[^\x2e-\x7a]/\./go;
			$salt =~ tr/\x3a-\x40\x5b-\x60/A-Ga-f/;
		}
		if ($mode eq 'next') {
			$salt =~ s/[^\x21-\x7a]/\./go;
			$salt =~ tr/\x21-\x2d\x3a-\x40\x5b-\x60/n-zA-Ga-f/;
		}
		if (0) {
			# 無変換と同等
			#$salt =~ tr/\x00-\x2d\x3a-\x40\x5b-\x60\x7b-\x7f/G-Za-z3-9U-Z\.\/0-2/;
			#$salt =~ tr/\x80-\xb9\xba-\xff/G-Za-z\.\/0-9A-Za-z\.\/0-9A-F/;
		}
		
		# 0x80問題再現
		if ($mode eq 'net') {
			$_key =~ s/\x80[\x00-\xff]*$//;
		}
		
		# 10桁トリップ生成
		$trip = substr(crypt($_key, $salt), -10);
		
	# キー長が12bytes以上で生キー形式なら10桁トリップ
	} elsif ($_key =~ /^#([0-9a-zA-Z]{16})([\.\/0-9A-Za-z]{0,2})$/ ) {
		
		$type = '10nama';
		
		# 生キーからソルトを決定
		my $salt = substr("$2..", 0, 2);
		$salt =~ s/[^\x2e-\x7a]/\./go;
		$salt =~ tr/\x3a-\x40\x5b-\x60/A-Ga-f/;
		
		$key2 = "#$1$salt";
		
		# 生キーからキーを復元
		$_key = pack('H*', $1);
		
		# キーを正常化(sjis)
		$key1 = key2sjis($_key, $salt);
		# 文字コード関連
		$key1 = decode('cp932', $key1) if (defined $key1);
		
		# 0x80問題再現
		if ($mode eq 'net') {
			$_key =~ s/\x80[\x00-\xff]*$//;
		}
		
		# 10桁トリップ生成
		$trip = substr(crypt($_key, $salt), -10);
		
	# キー長が12bytes以上で先頭が$なら独自拡張/未定義
	} elsif ($_key =~ /^\$/) {
		
		$key1 = $key;
		
		# scなら15桁トリップ
		if ($mode eq 'sc') {
			$type = '15trip';
			
			# 15桁トリップ生成
			$trip = substr(sha1_base64($_key), 3, 15);
			$trip =~ tr/\/+/!./;
			
			# 2バイト目が半角カタカナならカタカナトリップ
			if ($_key =~ /^\$[\xa1-\xdf]/) { # [｡-ﾟ]
				$type = '15kana';
				$trip =~ tr/0-9A-Za-z.!/\xa1-\xdf!/;
				$trip = decode('cp932', $trip) if (defined $key1);
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
#	10桁キー→生キー変換 ※キーはバイト列
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
#	10桁キー正常化 ※キーはsjisバイト列
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
