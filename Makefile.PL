use inc::Module::Install;

name 'String-jQuery';
all_from 'lib/String/jQuery.pm';

tests 't/*.t';
author_tests 'xt';

test_requires 'Test::More';

auto_set_repository;
auto_include_deps;

readme_from 'lib/String/jQuery.pm';

WriteAll;
