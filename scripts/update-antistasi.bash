#!/bin/bash

if [ -n "${DEBUG}" ] ; then
	set -x
fi

mkdir -p /arma3/mpmissions
cd /arma3/mpmissions || exit 1
workdir=$(mktemp -d)

version=$1
if [ -z "${version}" ] ; then
	echo "USAGE: ${0} antistasi-version
	See https://github.com/official-antistasi-community/A3-Antistasi/releases for current versions"
	exit 1
fi

antistasi=(Antistasi-Altis-VERSION.Altis Antistasi-Anizay-VERSION.tem_anizay Antistasi-CamLaoNam-VERSION.cam_lao_nam Antistasi-Chernarus-VERSION.chernarus_summer Antistasi-ChernarusWinter-VERSION.Chernarus_Winter Antistasi-Kunduz-VERSION.Kunduz Antistasi-Livonia-VERSION.Enoch Antistasi-Malden-VERSION.Malden Antistasi-Sahrani-VERSION.sara Antistasi-Takistan-VERSION.takistan Antistasi-Tembelan-Island-VERSION.Tembelan Antistasi-Virolahti-VERSION.vt7 Antistasi-WotP-VERSION.Tanoa)

for i in "${antistasi[@]}" ; do

	# E.g. '2-5-5'
	dash_version=$(echo "${version}" | tr '.' '-')

	# E.g. 'Antistasi-Sahrani-2-5-5.sara.pbo'
	name=$(echo "${i}" | sed "s/VERSION/${dash_version}/").pbo

	if ! [ -f "${name}" ] ; then
		# Download mission
		curl -sS --fail -L "https://github.com/official-antistasi-community/A3-Antistasi/releases/download/${version}/${name}" --output "${workdir}/${name}"
		if [ $? -ne 0 ] ; then
			echo "Failed downloading ${name}"
			continue
		fi
		# Replace existing mission
		find . -name "$(echo "${i}" | sed 's/VERSION.*//')*" -exec rm {} \;
		mv "${workdir}"/"${name}" "${name}"

		echo "Succesfully updated to ${name}"
	else
		echo "${name} already present, nothing to do"
	fi
done

rm -fr "${workdir}"

exit 0
