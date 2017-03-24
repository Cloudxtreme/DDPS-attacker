
# Readme

A few things has to be done In order to turn this template to your project. First,
replace this file with _a short description of your project_.

Next, as this is based on a git-hosted template you may want to remove the
templates history. You may find ``remove-git-history.sh`` useful, it is there
for your convenience.

Also, this template is twofold and has a _source_ (``src``) and _docs_ (``docs``)
directory structure, feel free to delete or modify to your harts desire.

The _docs_ directory contains a markdown based [text bundle](textbundle.org)
skeleton except for the _json_ file - and the ``assets`` directory has been
populated with individual directories for images and CSS stylesheets.

  - Link to [README for the docs directory](docs/README-docs.md)
  - Link to [README for the src directory](src/README.md)

There is a generic Makefile for creating _html_ and _pdf_ from _Markdown_ files.

There is also a generic Makefile In the ``src`` directory, and a few _Perl_,
_Bash_ and _C_ templates.

# License

Everything - software and documentation - requires a license. We have chosen to use the Apache version 2.0 license.

# Tokens
In order to use e.g. $Id$ tokens in text documents, the following has to be done:

	cat << EOF > .git/info/attributes 
	# see man gitattributes
	*.sh ident 
	*.pl ident
	*.c ident
	*.md ident
	EOF

This will replace ``$Id$`` with ``$Id:<40-digit SHA>$`` _on checkout of the file_. If the file exist ahead of
the change then do the following:

	$ echo '*.txt ident' >> .gitattributes
	$ echo '$Id$' > test.txt
	$ git commit -a -m "test"

	$ rm test.txt
	$ git checkout -- test.txt
	$ cat test.txt

See [this article](http://stackoverflow.com/questions/1792838/how-do-i-enable-ident-string-for-git-repos)
for further information.

I prefer [semantic versioning](http://semver.org) which in git may be done wit ``git tag useful``, e.g.:
the first version should be:

	$git push origin 1.0-1

Given a version number **MAJOR**.**MINOR**.**PATCH**, increment the:

  - **MAJOR** version when you make _incompatible API changes_,
  - **MINOR** version when you _add functionality in a backwards-compatible manner_, and
  - **PATCH** version when you make _backwards-compatible bug fixes_.

Additional labels for pre-release and build metadata are available as
extensions to the _MAJOR.MINOR.PATCH_ format.

Git tags (e.g. 12345) may be deleted this way:

	$git tag -d 12345
	$git push origin :refs/tags/12345


