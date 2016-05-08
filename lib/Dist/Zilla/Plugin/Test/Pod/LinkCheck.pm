# vim: set ts=2 sts=2 sw=2 expandtab smarttab:
use strict;
use warnings;

package Dist::Zilla::Plugin::Test::Pod::LinkCheck;
# ABSTRACT: Add author tests for POD links

use Moose;
extends 'Dist::Zilla::Plugin::InlineFiles';
with 'Dist::Zilla::Role::PrereqSource';

sub register_prereqs {
  my $self = shift;

  $self->zilla->register_prereqs(
    {
        type  => 'requires',
        phase => 'develop',
    },
    'Test::Pod::LinkCheck' => '0',
  );
}

__PACKAGE__->meta->make_immutable;
no Moose;

1;

=for Pod::Coverage
register_prereqs

=head1 SYNOPSIS

  # dist.ini
  [Test::Pod::LinkCheck]

=head1 DESCRIPTION

This is an extension of L<Dist::Zilla::Plugin::InlineFiles>
providing the following files:

  xt/author/pod-linkcheck.t - a standard Test::Pod::LinkCheck test

You can skip the test by setting
C<$ENV{SKIP_POD_LINKCHECK}>.

=head1 INSTALLING

B<NOTE> You may need to update your L<CPANPLUS> index
before L<Test::Pod::LinkCheck> will work (or in my case even install).
Using the C<x> command at the C<cpanp> prompt did the trick for me.

Read more in L<Test::Pod::LinkCheck/NOTES>.

=head1 SEE ALSO

=for :list
* L<Test::Pod::LinkCheck>

=cut

__DATA__
___[ xt/author/pod-linkcheck.t ]___
#!perl

use strict;
use warnings;
use Test::More;

foreach my $env_skip ( qw(
  SKIP_POD_LINKCHECK
) ){
  plan skip_all => "\$ENV{$env_skip} is set, skipping"
    if $ENV{$env_skip};
}

eval "use Test::Pod::LinkCheck";
if ( $@ ) {
  plan skip_all => 'Test::Pod::LinkCheck required for testing POD';
}
else {
  Test::Pod::LinkCheck->new->all_pod_ok;
}
