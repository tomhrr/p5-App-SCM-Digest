package App::DVCS::Digest::DVCS::Git;

use strict;
use warnings;

use autodie;

sub new
{
    my ($class) = @_;

    my $res = system("git --version >/dev/null");
    if ($res != 0) {
        die "Unable to find git executable.";
    }

    my $self = {};
    bless $self, $class;
    return $self;
}

sub open_repository
{
    my ($self, $path) = @_;

    chdir $path;

    return 1;
}

sub branches
{
    my ($self) = @_;

    my @branches =
        grep { !/ -> / }
        map  { chomp; $_ }
            `git branch -r`;

    my @results;
    for my $branch (@branches) {
        my $commit = `git log $branch -1 --format="%H"`;
        chomp $commit;
        push @results, [ $branch => $commit ];
    }

    return \@results;
}

sub branch_name
{
    my ($self) = @_;

    my $branch = `git rev-parse --abbrev-ref HEAD`;
    chomp $branch;

    return $branch;
}

sub checkout
{
    my ($self, $branch) = @_;

    system("git checkout $branch >/dev/null 2>&1");

    return 1;
}

sub commits_from
{
    my ($self, $branch, $from) = @_;

    $self->checkout($branch);
    my @new_commits = map { chomp; $_ } `git rev-list $from..HEAD`;

    return \@new_commits;
}

sub show
{
    my ($self, $id) = @_;

    my @data = `git show -s $id`;

    return \@data;
}

sub show_all
{
    my ($self, $id) = @_;

    my @data = (`git show $id`);

    return \@data;
}

1;

__END__

=head1 NAME

App::DVCS::Digest::DVCS::Git

=head1 DESCRIPTION

Git L<App::DVCS::Digest::DVCS> implementation.

=cut
