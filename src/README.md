
# Source

Edit on your local machine, deploy elsewhere. You may have the following options for software development:

  - develop using your favorite IDE (including vi and make) - deploy on identical OS
  - drag your IDE to the development target and develop there
  - use what ever is available on the target platform
  - edit local in your favorite IDE and test, debug and deploy on a target host
 
This is a setup for the last option. Use ``remote.sh`` to push - or fetch your code to the target platform.

	Edit locally, push source files to remote host, comile, test install etc.

	./remote.sh push [-v][-n] push | fetch | test | deploy
	-v: be verbose
	-n: dont actually do anything
	-g: do git commit
	-d: add version files (version.h and version.c)
	push:   push source from /Users/uninth/ownsky/src/project_template/src to usre@1.2.3.4:/path/to/some/source_upload_dir
	clean:	push source from /Users/uninth/ownsky/src/project_template/src to usre@1.2.3.4:/path/to/some/source_upload_dir AND DELETE EVERYTHING ELSE ON usre@1.2.3.4:/path/to/some/source_upload_dir
	fetch:  retch source from usre@1.2.3.4:/path/to/some/source_upload_dir to /Users/uninth/ownsky/src/project_template/src/download-1484321554
	make:  push (rsync) then ssh 'chdir && make what-ever'
	        The argument to make should be passed to make, e.g.:
	./remote.sh make test
	./remote.sh make target

	TARGETHOST:	usre@1.2.3.4
	UPLOADDIR:	/path/to/some/source_upload_dir
	TMPDIR:		...

See ``Makefile`` for further information - direct link to files:

(output from ``ls -1 | awk '{ print "  - [" $1 "](src/" $1 "): template / example source file" }'``):

  - [Makefile](src/Makefile): template / example source file
  - [README.md](src/README.md): template / example source file
  - [bash-inifile.sh](src/bash-inifile.sh): template / example source file
  - [common.sh](src/common.sh): template / example source file
  - [concat.c](src/concat.c): template / example source file
  - [daemonize.c](src/daemonize.c): template / example source file
  - [debug.h](src/debug.h): template / example source file
  - [install-sh](src/install-sh): template / example source file
  - [remote.sh](src/remote.sh): template / example source file
  - [rsync_exclude.txt](src/rsync_exclude.txt): template / example source file
  - [sendmail-to-smsgw.sh](src/sendmail-to-smsgw.sh): template / example source file
  - [srctoman](src/srctoman): template / example source file
  - [strsplit.c](src/strsplit.c): template / example source file
  - [template.c](src/template.c): template / example source file
  - [template.pl](src/template.pl): template / example source file
  - [template.sh](src/template.sh): template / example source file
  - [version.c](src/version.c): template / example source file

