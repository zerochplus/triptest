#!/usr/bin/perl

#------------------------------------------------------------------------------------------
#
#	�����炭�Q�����˂�d�l�Ɉ�ԋ߂��g���b�v�e�X�^�[
#
#	-------------------------------------------------------------------------------------
#
#	This program made by windyakin ��windyaking ( http://windyakin.net/ )
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

# �N�G������
my $text = $q->param('text') || '';
my @data = split( /\x0d?\x0a/, $text );
# �L�[�\���p�����[�^�[�ێ�
my $echokey = $q->param('key') || '';
my $check1 = ( $echokey ? ' checked' : '' );
# ���L�[�ϊ��p�����[�^�[�ێ�
my $namakey = $q->param('nama') || '';
my $check2 = ( $namakey ? ' checked' : '' );



print "Content-type: text/html; charset=Shift_JIS\n\n";
print <<EOT;
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html lang="ja">
<body>

<pre>
EOT

# �g���b�v�\������
foreach ( @data ) {
	print trip( ( $namakey ? nama($_) : $_ ), $echokey ) . "\n" if ( $_ =~ /#/ );
}

print <<EOT;
</pre>

<form method="post" action="$cginame">
<input type="submit" value="�e�X�g">
�g���b�v�L�[��\\��<input type="checkbox" name="key" value="1"$check1>
���L�[�ɕϊ�<input type="checkbox" name="nama" value="1"$check2><br>
<textarea name="text" rows="10" style="width:700px;">
</textarea>
</form>

</body>
</html>
EOT


#------------------------------------------------------------------------------------------
#
#	�g���b�v�ϊ��p�T�u���[�`��(�V�d�l����L�[�ϊ��Ή�)
#
#------------------------------------------------------------------------------------------
sub trip {
	
	my $key = shift;
	my $echokey = shift || 0;
	
	my ( $trip, $mark, $salt, $nama, $key2 );
	
	$key = substr( $key, index( $key, '#' ) + 1 );
	
	# �g���b�v�L�[�̒�����12bytes�ȏ�Ȃ�V�ϊ��p�ɐ؂�ւ�
	if ( length $key >= 12 ) {
		
		# �擪������̎擾
		$mark = substr( $key, 0, 1 );
		
		if ( $mark eq '#' || $mark eq '$' ) {
		
			if ( $key =~ m|^#([0-9a-zA-Z]{16})([\./0-9A-Za-z]{0,2})$| ) {
				
				$key2 = pack( 'H*', $1 );
				$salt = substr( $2 . '..', 0, 2 );
				$salt =~ s/[^\.-z]/\./go;
				$salt =~ tr/:;<=>?@[\\]^_`/ABCDEFGabcdef/;
				
				# 0x80���Č�
				$key2 =~ s/\x80[\x00-\xff]*$//;
				
				$trip = substr( crypt( $key2, $salt ), -10 );
			}
			else {
				
				# �����̊g���p
				$trip = '???';
				
			}
		}
		else {
			
			# SHA1(�V�d�l)�g���b�v
			$trip = substr( sha1_base64($key), 0, 12 );
			$trip =~ tr/+/./;
			
		}
	}
	else {
		
		# �]���̃g���b�v��������
		
		$key2 = $key;
		$salt = (length $key > 1 ? substr( $key, 1 ) : '');
		$salt = substr( $salt . 'H.', 0, 2 );
		$salt =~ s/[^\.-z]/\./go;
		$salt =~ tr/:;<=>?@[\\]^_`/ABCDEFGabcdef/;
		
		# 0x80���Č�
		$key2 =~ s/\x80[\x00-\xff]*$//;
		
		$trip = substr( crypt( $key2, $salt ), -10 );
		
	}
	
	if ( $echokey eq 1 ) {
		
		# XSS�΍���ۂ����̂����Ă݂�e�X�g
		$key =~ s/&/&amp;/g;
		$key =~ s/</&lt;/g;
		$key =~ s/>/&gt;/g;
		$key =~ s/"/&quot;/g; #" # ���T�N���G�f�B�^�΍�(^_^;)
		
		return "��$trip : #$key";
		
	}
	else {
		return "��$trip";
	}
	
}

#------------------------------------------------------------------------------------------
#
#	���L�[�ϊ��p�T�u���[�`��
#
#------------------------------------------------------------------------------------------
sub nama {
	
	my $key = shift;
	
	$key = substr( $key, index( $key, '#' ) + 1 );
	
	if ( length $key <= 11 ){
		
		# ��������΍��
		$key = substr( $key, 0, 8 );
		
		my $salt = (length $key > 1 ? substr( $key, 1 ) : '');
		$salt = substr( $salt . 'H.', 0, 2 );
		$salt =~ s/[^\.-z]/\./go;
		$salt =~ tr/:;<=>?@[\\]^_`/ABCDEFGabcdef/;
		
		$key =~ s/(.)/unpack( 'H2', $1 )/eg;
		
		# ����Ȃ���Α���
		$key .= '0' x ( 16 - length $key );
		
		return "##$key$salt";
	}
	else {
		return "#$key";
	}
	
}
