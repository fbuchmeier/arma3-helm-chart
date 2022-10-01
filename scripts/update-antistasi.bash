#!/bin/bash

if ! [ -z $DEBUG ] ; then
	set -x
fi

mkdir -p /arma3/mpmissions
cd /arma3/mpmissions

backup=$(date +%F).mpmissions.tar.gz
workdir=$(mktemp -d)

version=$1
if [ -z $version ] ; then
	echo "USAGE: $0 antistasi-version
	See https://github.com/official-antistasi-community/A3-Antistasi/releases for current versions"
	exit 1
fi

antistasi=(Antistasi-Altis-VERSION.Altis Antistasi-Anizay-VERSION.tem_anizay Antistasi-CamLaoNam-VERSION.cam_lao_nam Antistasi-Chernarus-VERSION.chernarus_summer Antistasi-ChernarusWinter-VERSION.Chernarus_Winter Antistasi-Kunduz-VERSION.Kunduz Antistasi-Livonia-VERSION.Enoch Antistasi-Malden-VERSION.Malden Antistasi-Sahrani-VERSION.sara Antistasi-Takistan-VERSION.takistan Antistasi-Tembelan-Island-VERSION.Tembelan Antistasi-Virolahti-VERSION.vt7 Antistasi-WotP-VERSION.Tanoa)

for i in ${antistasi[@]} ; do
	dash_version=$(echo $version  | tr '.' '-')
	name=$(echo $i | sed "s/VERSION/$dash_version/").pbo
	curl -s --fail -L https://github.com/official-antistasi-community/A3-Antistasi/releases/download/$version/$name --output $workdir/$name
	[[ $? -ne 0 ]] && echo "Failed downloading $name"
	find . -name "$(echo $i | sed 's/VERSION.*//')*" -exec rm {} \;
	mv $workdir/$name $name
	echo "Succesfully updated to $name"
done

rm -fr ${workdir}

exit 0
