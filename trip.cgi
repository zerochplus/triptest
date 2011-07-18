#!/usr/bin/perl

#------------------------------------------------------------------------------------------
#
#	おそらく２ちゃんねる仕様に一番近いトリップテスター
#
#	-------------------------------------------------------------------------------------
#
#	This program made by windyakin ◆windyaking ( http://windyakin.net/ )
#
#	Last up date 2011.07.18
#
#------------------------------------------------------------------------------------------
use strict;

#use CGI::Carp qw(fatalsToBrowser);
use CGI;
use Digest::SHA1 qw(sha1_base64);

our $ver = '20110718';
our $cginame = ( @_ = split( /[\\\/]/, $0 ) )[$#_];

my $q = new CGI;

# クエリ整理
my $text = $q->param('text') || '';
my @data = split( /\x0d?\x0a/, $text );
# キー表示パラメーター維持
my $echokey = $q->param('key') || '';
my $check1 = ( $echokey ? ' checked' : '' );
# 生キー変換パラメーター維持
my $namakey = $q->param('nama') || '';
my $check2 = ( $namakey ? ' checked' : '' );



print "Content-type: text/html; charset=Shift_JIS\n\n";
print <<EOT;
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html lang="ja">
<body>

<pre>
EOT

# トリップ表示処理
foreach ( @data ) {
	print trip( ( $namakey ? nama($_) : $_ ), $echokey ) . "\n" if ( $_ =~ /#/ );
}

print <<EOT;
</pre>

<form method="post" action="$cginame">
<input type="submit" value="テスト">
トリップキーを表\示<input type="checkbox" name="key" value="1"$check1>
生キーに変換<input type="checkbox" name="nama" value="1"$check2><br>
<textarea name="text" rows="10" style="width:700px;">
</textarea>
</form>

</body>
</html>
EOT


#------------------------------------------------------------------------------------------
#
#	トリップ変換用サブルーチン(新仕様･生キー変換対応)
#
#------------------------------------------------------------------------------------------
sub trip {
	
	my $key = shift;
	my $echokey = shift || 0;
	
	my ( $trip, $mark, $salt, $nama, $key2 );
	
	$key = substr( $key, index( $key, '#' ) + 1 );
	
	# トリップキーの長さが12bytes以上なら新変換用に切り替え
	if ( length $key >= 12 ) {
		
		# 先頭文字列の取得
		$mark = substr( $key, 0, 1 );
		
		if ( $mark eq '#' || $mark eq '$' ) {
		
			if ( $key =~ m|^#([0-9a-zA-Z]{16})([\./0-9A-Za-z]{0,2})$| ) {
				
				$key2 = pack( 'H*', $1 );
				$salt = substr( $2 . '..', 0, 2 );
				$salt =~ s/[^\.-z]/\./go;
				$salt =~ tr/:;<=>?@[\\]^_`/ABCDEFGabcdef/;
				
				# 0x80問題再現
				$key2 =~ s/\x80[\x00-\xff]*$//;
				
				$trip = substr( crypt( $key2, $salt ), -10 );
			}
			else {
				
				# 将来の拡張用
				$trip = '???';
				
			}
		}
		else {
			
			# SHA1(新仕様)トリップ
			$trip = substr( sha1_base64($key), 0, 12 );
			$trip =~ tr/+/./;
			
		}
	}
	else {
		
		# 従来のトリップ生成方式
		
		$key2 = $key;
		$salt = (length $key > 1 ? substr( $key, 1 ) : '');
		$salt = substr( $salt . 'H.', 0, 2 );
		$salt =~ s/[^\.-z]/\./go;
		$salt =~ tr/:;<=>?@[\\]^_`/ABCDEFGabcdef/;
		
		# 0x80問題再現
		$key2 =~ s/\x80[\x00-\xff]*$//;
		
		$trip = substr( crypt( $key2, $salt ), -10 );
		
	}
	
	if ( $echokey eq 1 ) {
		
		# XSS対策っぽいものをしてみるテスト
		$key =~ s/&/&amp;/g;
		$key =~ s/</&lt;/g;
		$key =~ s/>/&gt;/g;
		$key =~ s/"/&quot;/g; #" # ←サクラエディタ対策(^_^;)
		
		return "◆$trip : #$key";
		
	}
	else {
		return "◆$trip";
	}
	
}

#------------------------------------------------------------------------------------------
#
#	生キー変換用サブルーチン
#
#------------------------------------------------------------------------------------------
sub nama {
	
	my $key = shift;
	
	$key = substr( $key, index( $key, '#' ) + 1 );
	
	if ( length $key <= 11 ){
		
		# 多すぎれば削る
		$key = substr( $key, 0, 8 );
		
		my $salt = (length $key > 1 ? substr( $key, 1 ) : '');
		$salt = substr( $salt . 'H.', 0, 2 );
		$salt =~ s/[^\.-z]/\./go;
		$salt =~ tr/:;<=>?@[\\]^_`/ABCDEFGabcdef/;
		
		$key =~ s/(.)/unpack( 'H2', $1 )/eg;
		
		# 足りなければ足す
		$key .= '0' x ( 16 - length $key );
		
		return "##$key$salt";
	}
	else {
		return "#$key";
	}
	
}
