use inc::Module::Install;

name 'String-jQuery';
all_from 'lib/String/jQuery.pm';

tests 't/*.t';
author_tests 'xt';

requires 'JSON';
requires 'Storable';
requires 'Exporter::Lite';

test_requires 'Test::More';

auto_set_repository;
auto_include_deps;

readme_markdown_from 'lib/String/jQuery.pm';

if ($Module::Install::AUTHOR) {
    require File::Copy;
    File::Copy::mv('README.mkdn', 'README.md');
}

WriteAll;
