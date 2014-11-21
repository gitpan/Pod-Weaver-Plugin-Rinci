package Perinci::CmdLine::Base::Patch::DumpOnRun;

our $DATE = '2014-11-21'; # DATE
our $VERSION = '0.18'; # VERSION

use 5.010001;
use strict;
no warnings;

use Data::Dump;
use Module::Patch 0.19 qw();
use base qw(Module::Patch);

our %config;

sub _dump {
    print "# BEGIN DUMPOBJ $config{-tag}\n";
    dd @_;
    print "# END DUMPOBJ $config{-tag}\n";
}

sub patch_data {
    return {
        v => 3,
        patches => [
            {
                action      => 'replace',
                sub_name    => 'run',
                code        => sub { my $self = shift; _dump($self); exit 0 },
            },
        ],
        config => {
            -tag => {
                schema  => 'str*',
                default => 'TAG',
            },
        },
   };
}

1;
# ABSTRACT: Patch Perinci::CmdLine::Base to dump object + exit on run()

__END__

=pod

=encoding UTF-8

=head1 NAME

Perinci::CmdLine::Base::Patch::DumpOnRun - Patch Perinci::CmdLine::Base to dump object + exit on run()

=head1 VERSION

This document describes version 0.18 of Perinci::CmdLine::Base::Patch::DumpOnRun (from Perl distribution Pod-Weaver-Plugin-Rinci), released on 2014-11-21.

=for Pod::Coverage ^(patch_data)$

=head1 HOMEPAGE

Please visit the project's homepage at L<https://metacpan.org/release/Pod-Weaver-Plugin-Rinci>.

=head1 SOURCE

Source repository is at L<https://github.com/perlancar/perl-Pod-Weaver-Plugin-Perinci>.

=head1 BUGS

Please report any bugs or feature requests on the bugtracker website L<https://rt.cpan.org/Public/Dist/Display.html?Name=Pod-Weaver-Plugin-Rinci>

When submitting a bug or request, please include a test-file or a
patch to an existing test-file that illustrates the bug or desired
feature.

=head1 AUTHOR

perlancar <perlancar@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2014 by perlancar@cpan.org.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
