#!/usr/bin/env bash
export PATH=$PATH:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin
TZ='UTC'; export TZ

umask 022

#apt update -y -qqq
#apt install -y -qqq rpm
#apt install -y -qqq p7zip-full
#apt install -y -qqq libxml2-utils

cd /tmp
mkdir .install_7z
cd .install_7z
wget -c -t 9 -T 0 'https://www.7-zip.org/a/7z2407-linux-x64.tar.xz'
mkdir .ext
tar -xof 7z*.tar.xz -C .ext/
[[ -f .ext/7zzs ]] && rm -vf /bin/7z
install -v -c -m 0755 .ext/7zzs /bin/7z
sleep 1
cd ..
rm -fr .install_7z
cp -f /bin/7z /usr/local/bin/

/sbin/ldconfig

#https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
#https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm

#_channel=stable
#"https://dl.google.com/linux/chrome/deb/pool/main/g/google-chrome-${_channel}/google-chrome-${_channel}_${_ver}-1_amd64.deb"

#curl -s https://dl.google.com/linux/chrome/rpm/stable/x86_64/repodata/other.xml.gz | gzip -df

# 32bit
#https://dl.google.com/release2/chrome/acxtykw3lrl7l6si2hbydovmvqrq_98.0.4758.102/98.0.4758.102_chrome_installer.exe
# 64bit
#https://dl.google.com/release2/chrome/nf5ognz3picdt5dg3wh2iowgkq_98.0.4758.102/98.0.4758.102_chrome_installer.exe

#https://dl.google.com/tag/s/appguid%3D%7B8A69D345-D564-463C-AFF1-A69D9E530F96%7D%26iid%3D%7BF757ABC6-8B46-CEBD-1287-EA1EDD5554C4%7D%26lang%3Den%26browser%3D4%26usagestats%3D0%26appname%3DGoogle%2520Chrome%26needsadmin%3Dprefers%26ap%3Dx64-stable-statsdef_1%26installdataindex%3Dempty/chrome/install/ChromeStandaloneSetup64.exe

# x64
#https://dl.google.com/tag/s/appguid%3D%7B8A69D345-D564-463C-AFF1-A69D9E530F96%7D%26iid%3D%7B78DACABA-F9A3-54FC-37F4-BD6745294251%7D%26lang%3Den%26browser%3D4%26usagestats%3D0%26appname%3DGoogle%2520Chrome%26needsadmin%3Dprefers%26ap%3Dx64-stable-statsdef_1%26installdataindex%3Dempty/chrome/install/ChromeStandaloneSetup64.exe

# x86
#https://dl.google.com/tag/s/appguid%3D%7B8A69D345-D564-463C-AFF1-A69D9E530F96%7D%26iid%3D%7B78DACABA-F9A3-54FC-37F4-BD6745294251%7D%26lang%3Den%26browser%3D4%26usagestats%3D0%26appname%3DGoogle%2520Chrome%26needsadmin%3Dprefers%26ap%3Dstable-arch_x86-statsdef_1%26installdataindex%3Dempty/chrome/install/ChromeStandaloneSetup.exe

# lang=en lang=zh-CN lang=zh-TW
# lang=en&browser=4&usagestats=1&appname=Google Chrome&needsadmin=prefers&ap=x64-stable-statsdef_1&installdataindex=defaultbrowser/chrome/install/ChromeStandaloneSetup64.exe"
# lang=en&browser=4&usagestats=0&appname=Google Chrome&needsadmin=prefers&ap=x64-stable-statsdef_1&installdataindex=empty/chrome/install/ChromeStandaloneSetup64.exe"
# "https://dl.google.com/tag/s/installdataindex/update2/installers/ChromeStandaloneSetup.exe"
# "https://dl.google.com/tag/s/installdataindex/update2/installers/ChromeStandaloneSetup64.exe"
# "https://dl.google.com/tag/s/lang=en&installdataindex/update2/installers/ChromeStandaloneSetup64.exe"
# "https://dl.google.com/tag/s/lang=en&installdataindex=empty/chrome/install/ChromeStandaloneSetup64.exe"
# "https://dl.google.com/tag/s/lang=en&installdataindex=defaultbrowser/chrome/install/ChromeStandaloneSetup64.exe"

#https://dl.google.com/
#https://www.google.com/dl/
#https://edgedl.me.gvt1.com/edgedl/
#https://redirector.gvt1.com/edgedl/

set -e

_tmp_dir="$(mktemp -d)"
cp -a .xml "${_tmp_dir}"/.xml
cd "${_tmp_dir}"

wget -q -c -t 9 -T 9 'https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb'
wget -q -c -t 9 -T 9 'https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm'
sleep 1

_chrome_deb_ver="$(dpkg-deb --info google-chrome-stable_current_amd64.deb | grep 'Version: ' | awk '{print $2}')"
sleep 1
mv -v -f google-chrome-stable_current_amd64.deb "google-chrome-stable_${_chrome_deb_ver}_amd64.deb"
sleep 1
sha256sum "google-chrome-stable_${_chrome_deb_ver}_amd64.deb" > "google-chrome-stable_${_chrome_deb_ver}_amd64.deb".sha256

_chrome_rpm_ver="$(rpm -qp --info google-chrome-stable_current_x86_64.rpm 2>&1 | grep '^Version .*: ' | awk '{print $3}')"
_chrome_rpm_rel="$(rpm -qp --info google-chrome-stable_current_x86_64.rpm 2>&1 | grep '^Release .*: ' | awk '{print $3}')"
sleep 1
mv -v -f google-chrome-stable_current_x86_64.rpm "google-chrome-stable_${_chrome_rpm_ver}-${_chrome_rpm_rel}_x86_64.rpm"
sleep 1
sha256sum "google-chrome-stable_${_chrome_rpm_ver}-${_chrome_rpm_rel}_x86_64.rpm" > "google-chrome-stable_${_chrome_rpm_ver}-${_chrome_rpm_rel}_x86_64.rpm".sha256

############################################################################

# _chrome_win_ver='124.0.6367.79'

_new_uuid="$(cat /proc/sys/kernel/random/uuid | tr '[:lower:]' '[:upper:]')"

# x64
wget -q -c -t 9 -T 9 "https://dl.google.com/tag/s/appguid%3D%7B8A69D345-D564-463C-AFF1-A69D9E530F96%7D%26iid%3D%7B${_new_uuid}%7D%26lang%3Den%26browser%3D4%26usagestats%3D0%26appname%3DGoogle%2520Chrome%26needsadmin%3Dprefers%26ap%3Dx64-stable-statsdef_1%26installdataindex%3Dempty/chrome/install/ChromeStandaloneSetup64.exe"
sleep 1
mkdir .win
7z x ChromeStandaloneSetup64.exe -o.win/
_chrome_win_ver="$(strings .win/* 2>&1 | grep -i '<url codebase="http://dl.google.com/edgedl/chrome/install'  | sed 's|.*install/||g' | sed 's|/|\n|g' | grep '^[1-9]' | sort -V | tail -n 1)"
echo "${_chrome_win_ver}"
sleep 1
rm -fr .win
mv -v -f ChromeStandaloneSetup64.exe "google-chrome-stable_${_chrome_win_ver}-1_x64.exe"
sleep 1
openssl dgst -r -sha256 "google-chrome-stable_${_chrome_win_ver}-1_x64.exe" > "google-chrome-stable_${_chrome_win_ver}-1_x64.exe".sha256
_chrome_win_ver=''

# x86
wget -q -c -t 9 -T 9 "https://dl.google.com/tag/s/appguid%3D%7B8A69D345-D564-463C-AFF1-A69D9E530F96%7D%26iid%3D%7B${_new_uuid}%7D%26lang%3Den%26browser%3D4%26usagestats%3D0%26appname%3DGoogle%2520Chrome%26needsadmin%3Dprefers%26ap%3Dstable-arch_x86-statsdef_1%26installdataindex%3Dempty/chrome/install/ChromeStandaloneSetup.exe"
sleep 1
mkdir .win
7z x ChromeStandaloneSetup.exe -o.win/
_chrome_win_ver="$(strings .win/* 2>&1 | grep -i '<url codebase="http://dl.google.com/edgedl/chrome/install'  | sed 's|.*install/||g' | sed 's|/|\n|g' | grep '^[1-9]' | sort -V | tail -n 1)"
echo "${_chrome_win_ver}"
sleep 1
rm -fr .win
mv -v -f ChromeStandaloneSetup.exe "google-chrome-stable_${_chrome_win_ver}-1_x86.exe"
sleep 1
openssl dgst -r -sha256 "google-chrome-stable_${_chrome_win_ver}-1_x86.exe" > "google-chrome-stable_${_chrome_win_ver}-1_x86.exe".sha256
_chrome_win_ver=''

_new_uuid=''

############################################################################
#
# Single User Version
#
############################################################################

_query_file='.xml/query-stable-x64.xml'
#_chrome_win_arch="$(echo ${_query_file} | awk -F/ '{print $NF}' | cut -d- -f3 | sed 's|\.xml.*||g')"
_chrome_win_arch='x64'
curl -s -X POST -H "Content-Type: text/xml" -H "Accept: text/xml" -d @"${_query_file}" 'https://tools.google.com/service/update2' |  xmllint --format - >"${_query_file}".formatted
_chrome_installer_name="$(grep ' name="[0-9]' "${_query_file}".formatted | sed 's|"|\n|g' | grep '^[1-9].*\.exe$')"
_chrome_installer_ver="$(echo ${_chrome_installer_name} | cut -d_ -f1)"
_url_codebase="$(grep 'codebase="https://dl.google.com/release2/chrome/' "${_query_file}".formatted | sed 's|"|\n|g' | grep '^https://')"
wget -q -c -t 9 -T 9 "${_url_codebase}/${_chrome_installer_name}"
sleep 1
mv -v -f "${_chrome_installer_name}" "google-chrome-stable-singleuser_${_chrome_installer_ver}-1_${_chrome_win_arch}.exe"
sleep 1
openssl dgst -r -sha256 "google-chrome-stable-singleuser_${_chrome_installer_ver}-1_${_chrome_win_arch}.exe" > "google-chrome-stable-singleuser_${_chrome_installer_ver}-1_${_chrome_win_arch}.exe".sha256

_query_file='.xml/query-stable-x86.xml'
#_chrome_win_arch="$(echo ${_query_file} | awk -F/ '{print $NF}' | cut -d- -f3 | sed 's|\.xml.*||g')"
_chrome_win_arch='x86'
curl -s -X POST -H "Content-Type: text/xml" -H "Accept: text/xml" -d @"${_query_file}" 'https://tools.google.com/service/update2' |  xmllint --format - >"${_query_file}".formatted
_chrome_installer_name="$(grep ' name="[0-9]' "${_query_file}".formatted | sed 's|"|\n|g' | grep '^[1-9].*\.exe$')"
_chrome_installer_ver="$(echo ${_chrome_installer_name} | cut -d_ -f1)"
_url_codebase="$(grep 'codebase="https://dl.google.com/release2/chrome/' "${_query_file}".formatted | sed 's|"|\n|g' | grep '^https://')"
wget -q -c -t 9 -T 9 "${_url_codebase}/${_chrome_installer_name}"
sleep 1
mv -v -f "${_chrome_installer_name}" "google-chrome-stable-singleuser_${_chrome_installer_ver}-1_${_chrome_win_arch}.exe"
sleep 1
openssl dgst -r -sha256 "google-chrome-stable-singleuser_${_chrome_installer_ver}-1_${_chrome_win_arch}.exe" > "google-chrome-stable-singleuser_${_chrome_installer_ver}-1_${_chrome_win_arch}.exe".sha256

sleep 2
rm -fr /tmp/_output/chrome
mkdir -p /tmp/_output/chrome
cp -a * /tmp/_output/chrome/
cd /tmp
rm -fr "${_tmp_dir}"

exit

