#!/usr/bin/perl

#------------------------------------------------------------------------------------------
#
#	おそらく２ちゃんねる仕様に一番近いトリップテスター
#
#	-------------------------------------------------------------------------------------
#
#	This program made by windyakin ◆windyaking ( http://windyakin.net/ )
#
#	Last up date 2010.08.02
#
#------------------------------------------------------------------------------------------
use strict;
use warnings;

use CGI::Carp qw(fatalsToBrowser);
use CGI;
use Digest::SHA1 qw(sha1_base64);

our $ver = "20100802";

my $q = new CGI;

# クエリ整理
my $text = $q->param('text');
my @data = split( /\x0d?\x0a/, $text );
# キー表示パラメーター維持
our $echokey = $q->param('key');
my $check1 = " checked" if ( $echokey eq 1 );
# 生キー変換パラメーター維持
our $namakey = $q->param('nama');
my $check2 = " checked" if ( $namakey eq 1 );



print "Content-type: text/html\n\n";
print <<EOF;
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html lang="ja">
<body>

<pre>
EOF

# トリップ表示処理
if ( $namakey eq 1 ) {
	foreach ( @data ) { print trip( nama($_) )."\n" if ( $_ =~ /#(.+)$/ ); }
}
else {
	foreach ( @data ) { print trip($_)."\n" if ( $_ =~ /#(.+)$/ ); }
}

print <<EOF;
</pre>

<form method="post" action="./trip.cgi">
<input type="submit" value="テスト">
トリップキーを表\示<input type="checkbox" name="key" value="1"$check1>
生キーに変換<input type="checkbox" name="nama" value="1"$check2><br>
<textarea name="text" rows="10" style="width:700px;">
</textarea>
</form>

</body>
</html>
EOF


#------------------------------------------------------------------------------------------
#
#	トリップ変換用サブルーチン(新仕様･生キー変換対応)
#
#------------------------------------------------------------------------------------------
sub trip {
	
	my $key = shift;
	
	my ( $trip, $mark, $salt, $nama );
	
	$key = substr($key,index($key,'#')+1);
	
	# トリップキーの長さが12bytes以上なら新変換用に切り替え
	if ( length $key >= 12 ) {
		
		# 先頭文字列の取得
		$mark = substr( $key, 0, 1 );
		
		if ( $mark eq '#' || $mark eq '$' ) {
		
			if ( $key =~ m|^#([0-9a-zA-Z]{16})([./0-9A-Za-z]{0,2})$| ) {
				
				# 生キー変換
				$nama = $1;
				$salt = $2;
				
				if ( $nama =~ /^((..)+)80/ ) {
					
					# 0x80問題の再現用
					$nama = $1;
					$trip = substr( crypt( pack( 'H*', $nama ), "$salt.." ), -10 );
					
				}
				else {
					
					$trip = substr( crypt( pack( 'H*', $nama ), "$salt.." ), -10 );
					
				}
				
			}
			else {
				
				# 将来の拡張用
				$trip = '???';
				
			}
		}
		else {
			
			# SHA1(新仕様)トリップ
			$trip = substr( sha1_base64($key), 0, 12);
			$trip =~ tr/+/./;
			
		}
	}
	else {
		
		# 従来のトリップ生成方式
		
		# とりあえず一度生キーへ変換
		$nama = $key;
		$nama =~ s/(.)/unpack('H2', $1)/eg;
		
		if( $nama =~ /^((..)+)80/ ) {
			
			$nama = $1;
			$nama .= "0" x (16-length $nama);
			
			$salt = substr( pack( 'H*', $nama ).'H.', 1, 2 );
			$salt =~ s/[^\.-z]/\./go;
			$salt =~ tr/:;<=>?@[\\]^_`/ABCDEFGabcdef/;
			
			$trip = substr( crypt( pack( 'H*', $nama ), "$salt.." ), -10 );
			
		}
		else {
			
			$salt = substr( $key.'H.', 1, 2 );
			$salt =~ s/[^\.-z]/\./go;
			$salt =~ tr/:;<=>?@[\\]^_`/ABCDEFGabcdef/;
			$trip = substr( crypt( $key, $salt ), -10 );
			
		}
	}
	
	if ( $echokey eq 1 ) {
		
		# XSS対策っぽいものをしてみるテスト
		$key =~ s/&/&amp;/g;
		$key =~ s/</&lt;/g;
		$key =~ s/>/&gt;/g;
		$key =~ s/"/&quot;/g; #" # ←サクラエディタ対策(^_^;)
		
		return "◆".$trip." : #".$key;
		
	}
	else {
		return "◆".$trip;
	}
	
}

#------------------------------------------------------------------------------------------
#
#	生キー変換用サブルーチン
#
#------------------------------------------------------------------------------------------
sub nama {
	
	my $key = shift;
	
	$key = substr($key,index($key,'#')+1);
	
	if ( length $key <= 11 ){
		
		$key =~ s/(.)/unpack('H2', $1)/eg;
		# 足りなければ足す
		$key .= "0" x (16-length $key);
		# 多すぎれば削る
		$key = substr($key, 0, 16);
		
		my $salt = substr( pack( 'H*', $key ).'H.', 1, 2 );
		$salt =~ s/[^\.-z]/\./go;
		$salt =~ tr/:;<=>?@[\\]^_`/ABCDEFGabcdef/;
		
		return "##".$key.$salt;
	}
	else {
		return "#".$key;
	}
	
}
