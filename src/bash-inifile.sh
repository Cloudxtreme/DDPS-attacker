#!/bin/bash
#
#	$Header: /opt/UNImsp/lib/RCS/bash-inifile.sh,v 1.1 2010/08/27 13:49:10 root Exp root $
#
#	REQUIRES
#	* bash 3 or newer
#	* gawk (at least on opensolaris)
#   $Header: /opt/UNImsp/lib/RCS/bash-inifile.sh,v 1.1 2010/08/27 13:49:10 root Exp root $
#
#	Small change to satisfy OS X awk:
#	The line
#		\$1 ~ /^[[:alnum:]\._]+\$/ {
#	has been replaced with
#		\$1 ~ /^[\._[:alnum:]]+\$/ {
#
#	fixes problems with default osx awk
#	doesn't fix problems with opensolaris awk
#	so gawk is *still required*
#
#   bash-inifile.sh - parse ini files using bash/awk
#   Version 1.0
#
#   Copyright (c) 2007 Juergen Hoetzel <juergen@hoetzel.info>
#
#   This program is free software; you can redistribute it and/or modify
#   it under the terms of the GNU General Public License as published by
#   the Free Software Foundation; either version 2 of the License, or
#   (at your option) any later version.
#
#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with this program; if not, write to the Free Software
#   Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, 
#   USA.
#

#   Example usage:
#   
#   source bash-inifile.sh || exit 1
#   
#   ini_load "/etc/php.ini"
#   echo -e "Sections:\n"
#   for section in `ini_get_sections`;do
#       echo -e "\t" $section
#   done
#   
#   
#   for section in "PHP" "Verisign Payflow Pro" "mail function"; do
#       echo -e "\nContent of [${section}] Section:\n"
#       for key in `ini_get_keys "${section}"`;do
#   	echo -e "\t$key="`ini_get_value "${section}" $key`
#       done
#   done

#   Notes
# 
#   Section names are mapped to global arrays using prefix
#   INI_PREFIX as start of the variable name ->
#
#      It is not possible to parse multiple .ini concurrently files if
#      they use the same section names.
#   
#      all sections names have to be mapped to valid bash variables,
#      so internally these sections are the same:
#         [Section 1]
#         [Section.2]


# prefix for all global variables
INI_PREFIX=bash_inifile_

function ini_load {

	# without theese the rest won't work
	REQUIRED="gawk gsed gfind"
	REQUIRED="gawk"

	for tool in ${REQUIRED}; do
		if ! type $tool >/dev/null 2>&1; then
			echo "ERROR: \"$tool\" required but not found. Check \$PATH or install \"$tool\"."
			exit 2
		fi
	done

	# assert type foo &>/dev/null && echo "foo() found." || echo "foo() not found."

	# Older versions of bash does not handle the ini lib, stop here
	assert "${BASH_VERSINFO[0]} -gt 2" "ERROR: bash version 3 required, this is ${BASH_VERSION}. Please upgrade"

	GAWK_VERSION="`gawk --version| sed -e '/^GNU Awk/!d; s/.* //; s/\..*//'`"
	assert "${GAWK_VERSION} -gt 2" "ERROR: GNU awk version 3 required, this is ${GAWK_VERSION}. Please upgrade"

    # param1 inifile
    local tmpfile=`(mktemp "${TMPDIR-/tmp}/bash_inifileXXXXXXXX") 2>/dev/null || echo ${TMPDIR-/tmp}/bash_inifile$$`
    gawk -v INI_PREFIX=${INI_PREFIX} -f - "$1" >$tmpfile <<EOF

# default global section
BEGIN {
  FS="[[:space:]]*=[[:space:]]*"
  section="globals";
}

{
 # kill comments 
 sub(/;.*/, "");
}

/^\[[^\]]+\]$/ {
 section=substr(\$0, 2, length(\$0) -2);
 # map section to valid shell variables
 gsub(/[^[[:alnum:]]/, "_", section)
 printf "%s%s_keys=()\n", INI_PREFIX, section, INI_PREFIX, section
 printf "%s%s_values=()\n", INI_PREFIX, section, INI_PREFIX, section
}

\$1 ~ /^[\._[:alnum:]]+\$/ {
 # remove trail/head single/double quotes
 gsub(/(^[\"\']|[\'\"]\$)/, "", \$2);
 # escape inside single quotes 
 gsub(/\47/, "'\"'\"'", \$2);
 printf "%s%s_keys=(\"\${%s%s_keys[@]}\" '%s')\n", INI_PREFIX, section, INI_PREFIX, section, \$1
 printf "%s%s_values=(\"\${%s%s_values[@]}\" '%s')\n", INI_PREFIX, section, INI_PREFIX, section, \$2
}
EOF

while read line ; do
    eval $line
done  <${tmpfile}

rm ${tmpfile}

}

function ini_get_value {
    # param1 section
    # param2 key
    
    # map section to valid bash variable like in awk parsing
    local section=${1//[![:alnum:]]/_}
    local keyarray=${INI_PREFIX}${section}_keys[@]
    local valuearray=${INI_PREFIX}${section}_values[@]
    local keys=("${!keyarray}")
    local values=("${!valuearray}")
    for (( i=0; i<${#keys[@]}; i++ )); do
	if [[ "${keys[$i]}" = "$2" ]]; then
	    echo "${values[$i]}"
	    return 0
	fi
    done
    return 1
}

function ini_get_sections {
    eval local prefix_arrays=\${!$INI_PREFIX\*}
    for varname in $prefix_arrays; do
	# grep for key arrays
	local arrayname=${varname#${INI_PREFIX}}
	# strip trailing keys suffix
	if [[ ${arrayname%*_keys} != ${arrayname} ]]; then
	    echo ${arrayname%*_keys}
	fi
    done
}

function ini_get_keys {
    #param1 section
    # map section to valid bash variable like in awk parsing
    local section=${1//[![:alnum:]]/_}
    local keyarray=${INI_PREFIX}${section}_keys[@]
    local keys=("${!keyarray}")
    echo ${keys[@]}
}

#
# Sort-of assert fra mit lille arsenal af bash funktioner
#

assert () {
# purpose     : If condition false then exit from script with appropriate error message.
# arguments   : 
# return value: 
# see also    : e.g.: condition="$a -lt $b"; assert "$condition" "explaination"

    E_PARAM_ERR=98 
    E_ASSERT_FAILED=99 
    if [ -z "$2" ]; then        #  Not enough parameters passed to assert() function. 
        return $E_PARAM_ERR     #  No damage done. 
    fi  
    if [ ! "$1" ]; then 
   	# Give name of file and line number. 
        echo "Assertion failed:  \"$1\" File \"${BASH_SOURCE[1]}\", line ${BASH_LINENO[0]}"
		echo "	$2"
        exit $E_ASSERT_FAILED 
    # else 
    #   return 
    #   and continue executing the script. 
    fi  
}

