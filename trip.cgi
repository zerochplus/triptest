#!/usr/bin/perl

#-------------------------------------------------------------------------------
#
#	おそらく２ちゃんねる仕様に一番近いトリップテスター
#
#	----------------------------------------------------------------------------
#
#	This program made by windyakin ◆windyaking ( http://windyakin.net/ )
#
#	Last up date 2014.10.01
#
#-------------------------------------------------------------------------------

use utf8;
use strict;

use lib '.';
use Encode;
use CGI;
use Crypt::UnixCrypt;
use Digest::SHA::PurePerl qw(sha1_base64);

our $VERSION = '20141001';
my @modes = qw(net sc open next strb vips 0chp bban machi patio 4chan ebbs atchs);

sub main {
	my $query = CGI->new();
	
	
	# クエリ整理
	my $text = $query->param('text');
	my $mode = $query->param('mode');
	my $nama = $query->param('nama');
	my $kote = $query->param('kote');
	my $leave = $query->param('leave');
	$text = decode('utf8', $text) if (defined $text);
	$mode = 'net' if (!defined $mode);
	$mode = 'net' if (!grep { $_ eq $mode } @modes);
	
	my %select = ();
	foreach my $m (@modes) {
		$select{$m} = ($mode eq $m ? ' selected' : '');
	}
	my %check = ();
	$check{'nama'} = ($nama ? ' checked' : '');
	$check{'kote'} = ($kote ? ' checked' : '');
	$check{'leave'} = (!defined $text || $leave ? ' checked' : '');
	
	binmode(STDOUT);
	binmode(STDOUT, ':utf8');
	
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
			if ($line =~ /#(.*)$/so) {
				my ($trip, $key1, $key2, $key, $type) = trip($1, $mode);
				
				$trip = sanitize($trip);
				$key = sanitize($key);
				$key1 = sanitize($key1) if (defined $key1);
				$key2 = sanitize($key2) if (defined $key2);
				
				print sanitize($`).' ' if ($kote);
				if (!defined $trip || $type eq 'notrip') {
					print '[no trip] : ';
				} else {
					print "◆$trip : ";
				}
				if ($nama && ($type eq '10trip' || $type eq '10nama')) {
					if (!defined $key2) {
						print "#$key1\n";
					} elsif (!defined $key1) {
						print "#$key2\n";
					} else {
						print "#$key2 #$key1\n";
					}
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
<option value="net"$select{'net'}>2ch.net</option>
<option value="sc"$select{'sc'}>2ch.sc</option>
<option value="open"$select{'open'}>open2ch.net</option>
<option value="next"$select{'next'}>next2ch.net</option>
<option value="vips"$select{'vips'}>VIP Service</option>
<option value="bban"$select{'bban'}>blogban</option>
<option value="strb"$select{'strb'}>したらば</option>
<option value="machi"$select{'machi'}>まちBBS</option>
<option value="4chan"$select{'4chan'}>4chan</option>
<option value="atchs"$select{'atchs'}>\@chs</option>
<option value="ebbs"$select{'ebbs'}>ebbs.jp</option>
<option value="0chp"$select{'0chp'}>0ch+系</option>
<option value="patio"$select{'patio'}>WEB PATIO系</option>
</select>
<input type="checkbox" name="kote" id="kote" value="1"$check{'kote'}><label for="kote">コテハンも表示</label>
<input type="checkbox" name="leave" id="leave" value="1"$check{'leave'}><label for="leave">テキストを残す</label>
<input type="checkbox" name="nama" id="nama" value="1"$check{'nama'}><label for="nama">生キー相互変換</label>
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
	$str =~ s/&/&amp;/go;
	$str =~ s/</&lt;/go;
	$str =~ s/>/&gt;/go;
	$str =~ s/"/&quot;/go;
	$str =~ s/'/&#39;/go;
	return $str;
}

#-------------------------------------------------------------------------------
#
#	トリップ生成 ※キーは内部コードまたはバイト列
#
#-------------------------------------------------------------------------------
sub trip {
	my ($key, $mode) = @_;
	
	die if (!grep { $_ eq $mode } @modes);
	
	my $trip = undef;
	my $key1 = undef;
	my $key2 = undef;
	my $type = 'unknown';
	
	my $_key = str2key($key, $mode);
	
	# 空キー不可
	if (length($_key) == 0 &&
	    ($mode eq 'sc' || $mode eq 'strb' || $mode eq 'machi' ||
	     $mode eq '4chan' || $mode eq 'atchs')) {
		
		$type = 'notrip';
		$key1 = $key;
		$trip = undef;
		
	# patioなら11桁トリップ
	} elsif ($mode eq 'patio') {
		
		$type = '11trip';
		
		$key1 = $key;
		
		# デフォルト設定のソルト
		my $salt = 'ab';
		
		# 11桁トリップ生成
		$trip = substr(crypt($_key, $salt), -11);
		
	# 10桁only掲示板 または キー長が12bytes未満なら10桁トリップ
	} elsif (length($_key) < 12 ||
	    $mode eq 'next' || $mode eq 'strb' || $mode eq 'machi' ||
	    $mode eq '4chan' || $mode eq 'ebbs' || $mode eq 'atchs') {
		
		$type = '10trip';
		
		$key1 = $key;
		
		# キーからソルトを決定
		my $salt = '..';
		if ($mode eq 'net' || $mode eq 'vips' || $mode eq '0chp') {
			$salt = (length($_key) > 1 ? substr($_key, 1) : '');
			$salt = substr("${salt}H.", 0, 2);
		} elsif ($mode eq 'open' || $mode eq 'bban') {
			$salt = substr("${_key}H.G", 1, 2);
		} elsif ($mode eq 'next' || $mode eq 'ebbs') {
			$salt = substr("${_key}H.q", 1, 2);
		} elsif ($mode eq 'sc' || $mode eq 'strb' || $mode eq 'machi' ||
		         $mode eq '4chan' || $mode eq 'atchs') {
			# 空キー不可のため未確認(影響なし)
			$salt = substr("${_key}H.G", 1, 2);
		}
		if ($mode eq 'net' || $mode eq 'sc' || $mode eq 'open' || 
		    $mode eq 'strb' || $mode eq 'vips' || $mode eq '0chp' ||
		    $mode eq 'bban' || $mode eq 'machi' || $mode eq '4chan' ||
		    $mode eq 'atchs') {
			$salt =~ s/[^\x2e-\x7a]/\./go;
			$salt =~ tr/\x3a-\x40\x5b-\x60/A-Ga-f/;
		} elsif ($mode eq 'next' || $mode eq 'ebbs') {
			# [\x21-\x2d]の置換なし
			$salt =~ s/[^\x21-\x7a]/\./go;
			$salt =~ tr/\x21-\x2d\x3a-\x40\x5b-\x60/n-zA-Ga-f/;
		} else {
			# 参考: 無変換と同等(実装依存？)
			$salt =~ tr/\x00-\x2d\x3a-\x40\x5b-\x60\x7b-\x7f/G-Za-z3-9U-Z\.\/0-2/;
			$salt =~ tr/\x80-\xb9\xba-\xff/G-Za-z\.\/0-9A-Za-z\.\/0-9A-F/;
		}
		
		# 生キーに変換
		if ($mode eq 'net' || $mode eq 'sc' || $mode eq 'open' || 
		    $mode eq 'vips' || $mode eq '0chp' || $mode eq 'bban') {
			$key2 = substr($_key, 0, 8);
			$key2 =~ s/(.)/unpack('H2', $1)/ego;
			$key2 .= '0' x (16 - length($key2));
			$key2 = "#$key2$salt";
		}
		
		$_key =~ s/\x00.*$//so;
		# 0x80問題再現
		if ($mode eq 'net' || $mode eq '0chp') {
			$_key =~ s/\x80.*$//so;
		}
		
		# 10桁トリップ生成
		$trip = substr(crypt($_key, $salt), -10);
		
	# キー長が12bytes以上で生キー形式なら10桁トリップ
	} elsif ($_key =~ /^#([0-9a-zA-Z]{16})([\.\/0-9A-Za-z]{0,2})$/so ) {
		
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
		
		$_key =~ s/\x00.*$//so;
		# 0x80問題再現
		if ($mode eq 'net' || $mode eq '0chp') {
			$_key =~ s/\x80.*$//so;
		}
		
		# 10桁トリップ生成
		$trip = substr(crypt($_key, $salt), -10);
		
	# キー長が12bytes以上で先頭が$なら独自拡張/未定義
	} elsif ($_key =~ /^\$/so) {
		
		$key1 = $key;
		
		# scなら15桁トリップ
		if ($mode eq 'sc') {
			$type = '15trip';
			
			# 15桁トリップ生成
			$trip = substr(sha1_base64($_key), 3, 15);
			$trip =~ tr/\/+/!./;
			
			# 2バイト目が半角カタカナならカタカナトリップ
			if ($_key =~ /^\$[\xa1-\xdf]/so) { # [｡-ﾟ]
				$type = '15kana';
				$trip =~ tr/0-9A-Za-z.!/\xa1-\xdf!/;
				$trip = decode('cp932', $trip) if (defined $key1);
			}
			
		} else {
			$trip = '???';
		}
		
	# キー長が12bytes以上で先頭が#なら未定義
	} elsif ($key =~ /^#/so) {
		
		$key1 = $key;
		
		$trip = '???';
		
	# キー長が12bytes以上でどれでもなければ12桁トリップ
	} else {
		
		$type = '12trip';
		
		$key1 = $key;
		
		# 12桁トリップ生成
		$trip = substr(sha1_base64($_key), 0, 12);
		$trip =~ tr/+/./;
		
	}
	
	return ($trip, $key1, $key2, $key, $type, $_key);
}

#-------------------------------------------------------------------------------
#
#	10桁キー正常化 ※キーはsjisバイト列
#
#-------------------------------------------------------------------------------
sub key2sjis {
	my ($key, $salt) = @_;
	
	$key =~ s/\x00+$//so;
	
	my $salt2 = (length($key) > 1 ? substr($key, 1) : '');
	$salt2 = substr("${salt2}H.", 0, 2);
	$salt2 =~ s/[^\.-z]/\./go;
	$salt2 =~ tr/:;<=>?@[\\]^_`/ABCDEFGabcdef/;
	
	if ($salt2 eq $salt) {
		if ($key =~ /^(?:[\x20-\x7e\xa1-\xdf]|[\x81-\x9f\xe0-\xfc][\x40-\x7e\x80-\xfc])*([\x81-\x9f\xe0-\xfc]?)$/so) {
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

#-------------------------------------------------------------------------------
#
#	キーの事前処理
#
#-------------------------------------------------------------------------------
sub str2key {
	my ($key, $mode) = @_;
	
	# 事前置換処理
	if ($mode eq 'next' || $mode eq 'bban' || $mode eq 'ebbs' ||
	    $mode eq 'atchs') {
		$key =~ s/\s+$//so;
	} elsif ($mode eq 'strb' || $mode eq 'machi') {
		$key =~ s/ +$//so;
	}
	if ($mode eq 'net') {
		$key =~ s/＃/#/go;
	} elsif ($mode eq 'open') {
		$key =~ s/\t//go;
		$key =~ s/</&lt;/go;
		$key =~ s/>/&gt;/go;
		$key =~ s/"/&quot;/go;
		$key =~ s/'/&#39;/go;
		$key =~ tr/■▲▼★●◆/□△▽☆○◇/;
	} elsif ($mode eq 'next') {
		$key =~ s/&/&amp;/go;
		$key =~ s/</&lt;/go;
		$key =~ s/>/&gt;/go;
		$key =~ s/"/&quot;/go;
		$key =~ s/'/&#039;/go;
		$key =~ tr/★◆/☆◇/;
	} elsif ($mode eq 'strb') {
		$key =~ s/\t/ /go;
		$key =~ s/</&lt;/go;
		$key =~ s/>/&gt;/go;
		$key =~ s/"/&quot;/go;
		$key =~ s/◆/◇/go;
		$key =~ s/＃/#/go;
	} elsif ($mode eq 'vips') {
		$key =~ s/</&lt;/go;
		$key =~ s/>/&gt;/go;
		$key =~ s/"/&quot;/go;
		$key =~ s/'/&#39;/go;
	} elsif ($mode eq '0chp') {
		$key =~ s/＃/#/o;		# 1回のみ(名前全体)
	} elsif ($mode eq 'machi') {
		$key =~ s/&/&amp/go;	# セミコロンなし
		$key =~ s/</&lt;/go;
		$key =~ s/>/&gt;/go;
		$key =~ s/"/&quot;/go;
	} elsif ($mode eq 'patio') {
		$key =~ s/&/&amp;/go;
		$key =~ s/</&lt;/go;
		$key =~ s/>/&gt;/go;
		$key =~ s/"/&quot;/go;
		$key =~ s/'/&#39;/go;
	} elsif ($mode eq '4chan') {
		$key =~ s/&/&amp;/go;
		$key =~ s/</&lt;/go;
		$key =~ s/>/&gt;/go;
		$key =~ s/"/&amp;quot;/go;
	} elsif ($mode eq 'ebbs') {
		$key =~ s/&/&amp;/go;
		$key =~ s/</&amp;lt;/go;
		$key =~ s/>/&amp;gt;/go;
		$key =~ s/"/&quot;/go;
		$key =~ s/'/&#039;/go;
	} elsif ($mode eq 'atchs') {
		$key =~ s/&/&amp;/go;
		$key =~ s/</&lt;/go;
		$key =~ s/>/&gt;/go;
		$key =~ s/"/&quot;/go;
		$key =~ s/'/&#039;/go;
		$key =~ tr/★◆/☆◇/;
	}
	
	# 文字コード関連
	if (!utf8::is_utf8($key)) {
		
	} elsif ($mode eq 'net' || $mode eq 'sc' || $mode eq 'strb' || 
	         $mode eq 'vips' || $mode eq '0chp' || $mode eq 'bban' ||
	         $mode eq 'machi' || $mode eq 'patio' || $mode eq '4chan' ||
	         $mode eq 'ebbs') {
		$key = encode('cp932', $key);
	} elsif ($mode eq 'open') {
		$key = encode('sjis', $key);
	} elsif ($mode eq 'next') {
		$key = encode('utf8', $key);
	} elsif ($mode eq 'atchs') {
		my $utf8 = encode('utf8', $key);
		my $utf8sjis = 0;
		my $sjissjis = 0;
		my $eucjpsjis = 0;
		my $key_utf8sjis = encode('sjis', $key, sub { $utf8sjis++; '?' });
		my $key_sjissjis = decode('sjis', $utf8, sub { $sjissjis++; '?' });
		my $key_eucjpsjis = decode('eucjp', $utf8, sub { $eucjpsjis++; '?' });
		if ($utf8sjis <= $sjissjis && $utf8sjis <= $eucjpsjis) {
			$key = $key_utf8sjis;
		} elsif ($sjissjis <= $utf8sjis && $sjissjis <= $eucjpsjis) {
			$key = encode('sjis', $key_sjissjis);
		} elsif ($eucjpsjis <= $utf8sjis && $eucjpsjis <= $sjissjis) {
			$key = encode('sjis', $key_eucjpsjis);
		}
	} else {
		$key = encode('cp932', $key);
	}
	
	# 事前置換処理
	if ($mode eq 'sc') {
		$key =~ s/\x81\x94/ #/o;		# s/＃/ #/ 1回のみ(名前全体)
	} elsif ($mode eq 'machi') {
		$key =~ s/\x81\x9f/\x81\x9e/go;	# s/◆/◇/g
		$key =~ s/\x81\x94/#/go;		# s/＃/#/g
	} elsif ($mode eq 'patio') {
		$key =~ s/\x81\x9f/\x81\x9e/go;	# s/◆/◇/g
	}
	
	return $key;
}

exit(main()) if (!defined caller);
1;
