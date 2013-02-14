use strict;
use warnings;
use Test::More tests => 10;

BEGIN { use_ok 'String::jQuery' }

local $String::jQuery::NAME = '$';

sub iss ($$) {
    @_ = @_[0,1,1];
    goto \&is;
}

iss jQuery, '$';

iss jQuery('#foo')->val(), '$("#foo").val()';
iss jQuery('#foo')->val('aaa'), '$("#foo").val("aaa")';

iss jQuery(\'document'), '$(document)';

iss jQuery->ajax({ method => 'POST' }), '$.ajax({"method":"POST"})';

iss jQuery('body')->position().'left', '$("body").position().left';

iss jQuery('body')->click(sub { e => 'console.log(e); return false' }),
    '$("body").click(function (e) { console.log(e); return false })';

iss jQuery('a') . '', '$("a")';
iss '' . jQuery('a'), '$("a")';
