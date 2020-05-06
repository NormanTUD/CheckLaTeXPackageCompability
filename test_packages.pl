#!/usr/bin/perl

use strict;
use warnings;
use LWP::Simple;
use Data::Dumper;
use Digest::MD5 qw/md5_hex/;
use Smart::Comments;
use Term::ANSIColor;
use File::Touch;
use File::Basename;

main();

sub main {
	my %zip_files = ();
	while (my $file = <downloads/*.zip>) {
		my $package = ($file =~ s#downloads/(.*)\.zip#$1#gr);
		$zip_files{$package} = $file;
	}

	my @packages_ok = ();
	foreach my $package (keys %zip_files) { ### Evaluating (% done)
		my $package_dir = "downloads/$package";
		if(contains_neccessary_files($package, $zip_files{$package}) || -d $package_dir) {
			if(!-d $package_dir) {
				system("unzip $zip_files{$package} -d $package_dir");
			}
			push @packages_ok, $package;
		} else {
			print color("red")."Does not contain neccessary files: $package".color("reset")."\n";
		}
	}

	my @combinations = ();
	my @combinations_failed = ();
	print "Testing Combinations\n";

	foreach my $mod_1 (@packages_ok) { ### Evaluating (% done)
		foreach my $mod_2 (@packages_ok) {
			if($mod_2 ne $mod_1) {
				if(!contains([$mod_1, $mod_2], @combinations)) {
					if(!test_combination($mod_1, $mod_2)) {
						push @combinations_failed, [$mod_1, $mod_2];
					}

					push @combinations, [$mod_1, $mod_2];
				}
			}
		}
	}

	foreach my $line (@combinations_failed) {
		print color("red")."$line->[0] - $line->[1] failed".color("reset")."\n";
	}
}

sub test_combination {
	my ($mod_1, $mod_2) = @_;

	if(has_tex_file($mod_1) && has_tex_file($mod_2)) {
		if(test_single($mod_1) && test_single($mod_2)) {
			my $testdir = "./tests_combinations";
			mkdir $testdir unless -d $testdir;

			my $thistest = "$testdir/$mod_1-$mod_2";
			mkdir $thistest unless -d $thistest;

			if (-e "$thistest/done") {
				print color("green")."TEST $mod_1-$mod_2 already done".color("reset")."\n";
			} else {
				my $contents = <<EOF;
\\documentclass{scrartcl}
\\usepackage{../../downloads/$mod_1/$mod_1/$mod_1}
\\usepackage{../../downloads/$mod_2/$mod_2/$mod_2}
\\begin{document}
hallo
\\end{document}
EOF

				open my $fh, '>', "$thistest/$mod_1-$mod_2.tex";
				print $fh $contents;
				close $fh;

				if(compile_latex_ok($thistest, "$thistest/$mod_1-$mod_2.tex")) {
					touch "$thistest/done";
					return 1;
				} else {
					touch "$thistest/not_ok";
					warn color("red")."Could not compile $mod_1, $mod_2".color("reset")."\n";;
				}
			}
		}
	}

	return 0;
}

sub test_single {
	my $mod = shift;

	my $testdir = "./tests_single";
	mkdir $testdir unless -d $testdir;

	my $thistest = "$testdir/$mod";
	mkdir $thistest unless -d $thistest;

	if (-e "$thistest/done") {
		print color("green")."TEST $mod already done".color("reset")."\n";
		return 1;
	} else {
		my $contents = <<EOF;
\\documentclass{scrartcl}
\\usepackage{../../downloads/$mod/$mod/$mod}
\\begin{document}
hallo
\\end{document}
EOF

		open my $fh, '>', "$thistest/$mod.tex";
		print $fh $contents;
		close $fh;

		if(compile_latex_ok($thistest, "$thistest/$mod.tex")) {
			touch "$thistest/done";
			return 1;
		} else {
			touch "$thistest/not_ok";
			warn color("red")."Could not compile $mod".color("reset")."\n";;
			return 0;
		}
	}
}

sub compile_latex_ok {
	my $folder = shift;
	my $filename = shift;

	my $basename = fileparse($filename, (".tex"));
	my $pdf = "$basename.pdf";

	my $command = "cd $folder; pdflatex -interaction=nonstopmode $basename 2>&1 > /dev/null";
	system $command;

	if(-e "$folder/$pdf") {
		print color("green")."$filename was compiled OK".color("reset")."\n";
		return 1;
	} else {
		print color("red")."$filename was NOT compiled".color("reset")."\n";
		return 0;
	}
}

sub contains_neccessary_files {
	my ($package, $file) = @_;

	my $lines_zipinfo = qx(zipinfo $file);

	#if ($lines_zipinfo =~ m#$package/$package\.(?:tex|sty|dtx)#) {
	if ($lines_zipinfo =~ m#$package/$package\.(?:tex)#) {
		return 1;
	} else {
		return 0;
	}
}

sub contains {
	my $values = shift;
	my @array = @_;

	foreach my $this_item (@array) {
		if(ref $this_item eq "ARRAYREF") {
			if(have_same_elements($this_item, \@array)) {
				return 1;
			}
		}
	}
	return 0;
}

sub have_same_elements {
	my ($arr1, $arr2) = @_;
	my %counts = ();
	$counts{$_} += 1 foreach (@$arr1);
	$counts{$_} -= 1 foreach (@$arr2);
	return !(grep { $_ != 0 } values %counts);
}


sub has_tex_file {
	my $mod = shift;

	if(-e "downloads/$mod/$mod/$mod.sty") {
		return 1;
	} else {
		return 0;
	}
}
