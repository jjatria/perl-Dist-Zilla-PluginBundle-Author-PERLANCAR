package Dist::Zilla::PluginBundle::Author::SHARYANTO;

use Moose;
with 'Dist::Zilla::Role::PluginBundle::Easy';

# VERSION

use Dist::Zilla::PluginBundle::Filter;

sub configure {
    my $self = shift;

    $self->add_bundle(Filter => {
        -bundle => '@Classic',
        -remove => [qw/PkgVersion PodVersion Readme/],
    });

    $self->add_plugins(
        'CheckChangeLog',
        'MetaJSON',
        'OurPkgVersion',
        'PodWeaver',
        'ReadmeFromPod',
        'Test::Compile',

        'Test::Rinci',
        'Rinci::Validate',

        [InstallRelease => {install_command => 'cpanm -n .'}],
        ['Run::Release' => {run => 'archive-perl-release %s'}],
    );
}

__PACKAGE__->meta->make_immutable;
no Moose;
1;
# ABSTRACT: Dist::Zilla like SHARYANTO when you build your dists

=for Pod::Coverage ^(configure)$

=head1 SYNOPSIS

 # dist.ini
 [@Author::SHARYANTO]

is equivalent to:

 [@Filter]
 bundle=@Classic
 remove=PkgVersion
 remove=PodVersion
 remove=Readme

 [CheckChangeLog]
 [MetaJSON]
 [OurPkgVersion]
 [PodWeaver]
 [ReadmeFromPod]
 [Test::Compile]
 [Test::Rinci]

 [InstallRelease]
 install_command=cpanm -n .

 [Run::Release]
 ;notexist_fatal = 0
 run=archive-perl-release %s


=head1 DESCRIPTION

The gist:

I avoid stuffs that might change line numbers (so I also always add # ABSTRACT
and POD at the end after '1;'). I still maintain dependencies and increase
version number manually.

I install my dists after release. I also archive them. The
C<archive-perl-release> is a script on my computer, you can get them from my
'scripts' github repo but the release process won't fail if the script does not
exist.

=cut
