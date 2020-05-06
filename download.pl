#!/usr/bin/perl

use strict;
use warnings;
use LWP::Simple;
use Data::Dumper;
use Digest::MD5 qw/md5_hex/;
use Smart::Comments;
use Term::ANSIColor;

my @modules = ();
foreach my $letter ("A" .. "Z") { ### Evaluating (% done)
	push @modules, get_modules(myget("https://ctan.org/pkg/:$letter"));
}

my @file_downloads = ();
foreach my $module (sort { rand() <=> rand() } @modules) { ### Evaluating (% done)
	push @file_downloads, get_downloads(myget("https://ctan.org/pkg/$module"), $module);
}

foreach my $file (sort { rand() <=> rand() } @file_downloads) { ### Evaluating (% done)
	wget_file($file);
}

sub get_downloads {
	my $html = shift;
	my $module = shift;

	my @downloads = ();

	while ($html =~ m#<a href="(http://mirrors\.ctan\.org/macros/latex/contrib/[^"]*)">Download</a>#gism) {
		push @downloads, $1;
	}

	if(@downloads == 0) {
		print color("red")."No downloads found for $module".color("reset")."\n";
	} else {
		print color("green")."Download found for $module".color("reset")."\n";
	}

	return @downloads;
}

sub get_modules {
	my $html = shift;

	my @modules = ();

	while ($html =~ m#<a href="/pkg/(\w[^"]+)">#gism) {
		push @modules, $1;
	}

	return @modules;
}

sub myget {
	my $url = shift;

	my $cache = './cache';

	mkdir $cache unless -d $cache;

	my $cache_file = "$cache/".md5_hex($url);

	my $contents = '';

	if(!-e $cache_file) {
		$contents = get($url);
		open my $fh, '>', $cache_file;
		print $fh $contents;
		close $fh;
	} else {
		open my $fh, '<', $cache_file;
		while (<$fh>) {
			$contents .= $_;
		}
		close $fh;
	}

	return $contents;
}

sub wget_file {
	my $url = shift;

	my $filename = $url;
	$filename =~ s#.*/##g;

	my $download_folder = "./downloads";

	mkdir $download_folder unless -d $download_folder;

	my $download_path = "$download_folder/$filename";

	if(-e $filename) {
		print color("green")."Filename already exists".color("reset")."\n";
	} else {
		system("wget $url -O $download_path");
	}
}
