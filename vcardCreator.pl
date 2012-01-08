#!/usr/bin/perl
use strict;
use warnings;

use Tie::Handle::CSV;

my $group = "SKSp12";

sub trim($)
{
	my $string = shift;
	$string =~ s/^\s+//;
	$string =~ s/\s+$//;
	return $string;
}

my $fh = Tie::Handle::CSV->new('contacts.csv', header => 1);

while (my $csv_line = <$fh>) {
	## vcard header
	print "BEGIN:VCARD\n";
	print "VERSION:3.0\n";

	## Name
	if (trim($csv_line->{'Mellemnavn'}) eq "") {
		print "FN:" . trim($csv_line->{'Fornavn'}) . " " . trim($csv_line->{'Efternavn'}) . "\n";
	} else {
		print "FN:" . trim($csv_line->{'Fornavn'}) . " " . trim($csv_line->{'Mellemnavn'}) . " " . trim($csv_line->{'Efternavn'}) . "\n";
	}
	print "N:" . trim($csv_line->{'Efternavn'}) . ";" . trim($csv_line->{'Fornavn'}) . ";" . trim($csv_line->{'Mellemnavn'}) . ";;\n";

	## Email
	print "EMAIL;TYPE=INTERNET;TYPE=HOME:" . trim($csv_line->{'Mail'}) . "\n";

	## Phono
	my $phone = $csv_line->{'Mobil'};
	$phone =~ s/\s+//g;
	$phone =~ s/(\d\d)(\d\d)(\d\d)(\d\d)/$1 $2 $3 $4/;
	print "TEL;TYPE=CELL:+45 " . $phone . "\n";

	## Address
	print "ADR;TYPE=HOME:;;" . trim($csv_line->{'Adresse'}) . ";" . trim($csv_line->{'By'}) . ";;" . trim($csv_line->{'Postnr.'}) . ";\n";

	## Company, category and vcard end
	print "ORG:" . trim($csv_line->{'Grp. nr.'}) . " " . trim($csv_line->{'Grp.navn'}) . "\n";
	print "CATEGORIES:" . $group . "\n";
	print "END:VCARD\n";
}

close $fh;
