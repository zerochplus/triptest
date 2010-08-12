#!/usr/bin/perl

#------------------------------------------------------------------------------------------
#
#	�����炭�Q�����˂�d�l�Ɉ�ԋ߂��g���b�v�e�X�^�[
#
#	-------------------------------------------------------------------------------------
#
#	This program made by windyakin ��windyaking ( http://windyakin.net/ )
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

# �N�G������
my $text = $q->param('text');
my @data = split( /\x0d?\x0a/, $text );
# �L�[�\���p�����[�^�[�ێ�
our $echokey = $q->param('key');
my $check1 = " checked" if ( $echokey eq 1 );
# ���L�[�ϊ��p�����[�^�[�ێ�
our $namakey = $q->param('nama');
my $check2 = " checked" if ( $namakey eq 1 );



print "Content-type: text/html\n\n";
print <<EOF;
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html lang="ja">
<body>

<pre>
EOF

# �g���b�v�\������
if ( $namakey eq 1 ) {
	foreach ( @data ) { print trip( nama($_) )."\n" if ( $_ =~ /#(.+)$/ ); }
}
else {
	foreach ( @data ) { print trip($_)."\n" if ( $_ =~ /#(.+)$/ ); }
}

print <<EOF;
</pre>

<form method="post" action="./trip.cgi">
<input type="submit" value="�e�X�g">
�g���b�v�L�[��\\��<input type="checkbox" name="key" value="1"$check1>
���L�[�ɕϊ�<input type="checkbox" name="nama" value="1"$check2><br>
<textarea name="text" rows="10" style="width:700px;">
</textarea>
</form>

</body>
</html>
EOF


#------------------------------------------------------------------------------------------
#
#	�g���b�v�ϊ��p�T�u���[�`��(�V�d�l����L�[�ϊ��Ή�)
#
#------------------------------------------------------------------------------------------
sub trip {
	
	my $key = shift;
	
	my ( $trip, $mark, $salt, $nama );
	
	$key = substr($key,index($key,'#')+1);
	
	# �g���b�v�L�[�̒�����12bytes�ȏ�Ȃ�V�ϊ��p�ɐ؂�ւ�
	if ( length $key >= 12 ) {
		
		# �擪������̎擾
		$mark = substr( $key, 0, 1 );
		
		if ( $mark eq '#' || $mark eq '$' ) {
		
			if ( $key =~ m|^#([0-9a-zA-Z]{16})([./0-9A-Za-z]{0,2})$| ) {
				
				# ���L�[�ϊ�
				$nama = $1;
				$salt = $2;
				
				if ( $nama =~ /^((..)+)80/ ) {
					
					# 0x80���̍Č��p
					$nama = $1;
					$trip = substr( crypt( pack( 'H*', $nama ), "$salt.." ), -10 );
					
				}
				else {
					
					$trip = substr( crypt( pack( 'H*', $nama ), "$salt.." ), -10 );
					
				}
				
			}
			else {
				
				# �����̊g���p
				$trip = '???';
				
			}
		}
		else {
			
			# SHA1(�V�d�l)�g���b�v
			$trip = substr( sha1_base64($key), 0, 12);
			$trip =~ tr/+/./;
			
		}
	}
	else {
		
		# �]���̃g���b�v��������
		
		# �Ƃ肠������x���L�[�֕ϊ�
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
		
		# XSS�΍���ۂ����̂����Ă݂�e�X�g
		$key =~ s/&/&amp;/g;
		$key =~ s/</&lt;/g;
		$key =~ s/>/&gt;/g;
		$key =~ s/"/&quot;/g; #" # ���T�N���G�f�B�^�΍�(^_^;)
		
		return "��".$trip." : #".$key;
		
	}
	else {
		return "��".$trip;
	}
	
}

#------------------------------------------------------------------------------------------
#
#	���L�[�ϊ��p�T�u���[�`��
#
#------------------------------------------------------------------------------------------
sub nama {
	
	my $key = shift;
	
	$key = substr($key,index($key,'#')+1);
	
	if ( length $key <= 11 ){
		
		$key =~ s/(.)/unpack('H2', $1)/eg;
		# ����Ȃ���Α���
		$key .= "0" x (16-length $key);
		# ��������΍��
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
