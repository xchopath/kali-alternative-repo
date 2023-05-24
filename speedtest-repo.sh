#!/usr/bin/env bash

echo '  _         _ _     '
echo ' | | ____ _| (_)    '
echo ' | |/ / _` | | |    '
echo ' |   < (_| | | | _  '
echo ' |_|\_\__,_|_|_|[_] '
echo '  ALTERNATIVE REPO  '
echo ''

SCRIPT_PATH=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)

#if [[ $(whoami) != "root" ]]; then
#	echo "[ERROR] You are not root!"
#	exit
#fi

function download_speedtest() {
	REPO_URI="${1}"

	download_speed_lists=()
	for i in {1..10}
	do
		test_speed=$(curl -qfsS -w '%{speed_download}' -o /dev/null --url "${REPO_URI}" --max-time 10 --connect-timeout 10)
		download_speed_lists+=("${test_speed}")
	done

	slowest=$(printf "%s\n" "${download_speed_lists[@]}" | sort -V | head -1)
	echo "${slowest}"
}

checked_repos=()

echo "[INFO] Total repository: $(cat ${SCRIPT_PATH}/repositories.txt | wc -l)"
echo "[INFO] Speedtest download..."
for REPO_URL in $(cat ${SCRIPT_PATH}/repositories.txt)
do
	download_speed=$(download_speedtest "${REPO_URL}")
	#echo "[INFO] Repository \"${REPO_URL}\" (speed: ${download_speed})"
	checked_repos+=("${download_speed}|${REPO_URL}")
done
echo ""


recommendations="$(printf "%s\n" "${checked_repos[@]}" | sort -V -r | head -5)"

echo "[INFO] Top 5 recommendations:"

i=0
for recommendation in ${recommendations}
do
	((i++))
	SPEED=$(echo "${recommendation}" | awk -F '|' '{print $1}')
	URL=$(echo "${recommendation}" | awk -F '|' '{print $2}')
	echo " ${i}. ${URL} (download speed: ${SPEED})"
done