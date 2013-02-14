package String::jQuery;
use strict;
use warnings;
use overload
    '""'  => 'TO_JSON',
    '&{}' => '__add_arguments',
    '.'   => '__chain_property',
    fallback => 1;

use 5.008_001;

use JSON;
use Storable qw(dclone);
use Exporter::Lite;

our $VERSION = '0.01';

our @EXPORT = qw(jQuery);

our $NAME = 'jQuery';
our $json = JSON->new->allow_nonref;

sub jQuery {
    return __PACKAGE__->__new(@_ ? [ $NAME, [ @_ ] ] : [ $NAME ]);
}

sub __new {
    my ($class, @chain) = @_;
    return bless \@chain, $class;
}

sub TO_JSON {
    my $self = shift;
    return join '.', map {
        my ($method, $args) = @$_;
        !$args ? $method : sprintf "$method(%s)", join ', ', map {
            if (ref $_ eq 'CODE') {
                my @args = $_->();
                my $func = pop @args;
                sprintf "function (%s) { $func }", join(', ', @args);
            } elsif (ref $_ eq 'SCALAR') {
                $$_;
            } else {
                $json->encode($_);
            }
        } @$args;
    } @$self;
}

sub __chain_property {
    my ($self, $prop, $is_lhs) = @_;
    return $self->TO_JSON unless length $prop;
    return $prop . $self->TO_JSON if $is_lhs;
    return $self->__chain([ $prop ]);
}

sub __chain {
    my ($self, $next) = @_;
    my $class = ref $self;
    return $class->__new(@$self, $next);
}

sub __add_arguments {
    my $self = shift;
    return sub {
        my @args = @_;
        if ($self->[-1]->[1]) {
            return $self->__chain([ '', \@args ]);
        } else {
            my $self = dclone $self;
            $self->[-1]->[1] = \@args;
            return $self;
        }
    };
}

sub AUTOLOAD {
    my $method = our $AUTOLOAD;
       $method =~ s/^(.+):://;
    if (ref $_[0]) {
        my $self = shift;
        return $self->__chain([ $method, \@_ ]);
    } else {
        return __PACKAGE__->__new([ $NAME ], [ $method, \@_ ]);
    }
}

sub DESTROY {
}

1;

__END__

=head1 NAME

String::jQuery - Easy generating jQuery expressions

=head1 SYNOPSIS

  use String::jQuery; # exports `jQuery`

  jQuery();                           # => 'jQuery()'
  jQuery('a');                        # => 'jQuery("a")'
  jQuery(\'document');                # => 'jQuery(document)'
  jQuery('a')->text();                # => 'jQuery("a').text()'
  jQuery('a')->text('xxx');           # => 'jQuery("a').text("xxx")'
  jQuery('a')->click(sub { e => 'return false' });
                                      # => 'jQuery("a").click(function (e) { return false })'
  jQuery('a').'length';               # => 'jQuery("a").length'
  jQuery->ajax({ method => 'POST' }); # => 'jQuery.ajax({"method:"POST"})'

=head1 DESCRIPTION

String::jQuery enables to build L<jQuery|http://jquery.com/>'s chained method call expressions
by writing Perl codes which are similar to the resulting codes you want.

Makes embedded jQuery snippets in Perl intuitive and readable.

=head1 AUTHOR

motemen E<lt>motemen@gmail.comE<gt>

=head1 SEE ALSO

L<HTML::JQuery>, which generates not an expression, but whole E<lt>scriptE<gt> tag

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
