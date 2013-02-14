# NAME

String::jQuery - Easy generating jQuery chained expression

# SYNOPSIS

    use String::jQuery; # expors `jQuery`

    jQuery();                           # => 'jQuery()'
    jQuery('a');                        # => 'jQuery("a")'
    jQuery(\'document');                # => 'jQuery(document)'
    jQuery('a')->text();                # => 'jQuery("a').text()'
    jQuery('a')->text('xxx');           # => 'jQuery("a').text("xxx")'
    jQuery('a')->click(sub { e => 'return false' });
                                        # => 'jQuery("a").click(function (e) { return false })'
    jQuery('a').'length';               # => 'jQuery("a").length'
    jQuery->ajax({ method => 'POST' }); # => 'jQuery.ajax({"method:"POST"})'

# DESCRIPTION

String::jQuery enables to build [jQuery](http://jquery.com/)'s chained method call expressions
by writing Perl codes which are similar to the resulting codes you want.

Makes embedded jQuery snippets in Perl intuitive and readable.

# AUTHOR

motemen <motemen@gmail.com>

# SEE ALSO

[HTML::JQuery](http://search.cpan.org/perldoc?HTML::JQuery), which generates not an expression, but whole <script> tag

# LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.