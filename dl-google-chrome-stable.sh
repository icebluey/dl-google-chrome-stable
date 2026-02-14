#!/usr/bin/env bash
export PATH=$PATH:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin
TZ='UTC'; export TZ
/sbin/ldconfig
umask 022
cd "$(dirname "$0")"
_old_dir="$(pwd)"

#apt update -y -qqq
#apt install -y -qqq openssl
#apt install -y -qqq binutils
#apt install -y -qqq rpm
#apt install -y -qqq libxml2-utils
#apt install -y -qqq p7zip-full

_install_7z() {
    set -euo pipefail
    local _tmp_dir="$(mktemp -d)"
    cd "${_tmp_dir}"
    #_7zip_loc="$(wget -qO- 'https://www.7-zip.org/download.html' | grep -i '\-linux-x64.tar' | grep -i 'href="' | sed 's|"|\n|g' | grep -i '\-linux-x64.tar' | sort -V | tail -n 1)"
    #wget -q -c -t 9 -T 9 "https://www.7-zip.org/${_7zip_loc}"
    #tar -xof *.tar*
    #sleep 1
    #rm -f *.tar*
    #file 7zzs | sed -n -E 's/^(.*):[[:space:]]*ELF.*, not stripped.*/\1/p' | xargs --no-run-if-empty -I '{}' strip '{}'
    #rm -f 7z && mv 7zzs 7z
    wget -q -c -t 9 -T 9 'https://github.com/icebluey/7zip-zstd/releases/latest/download/7z.tar'
    wget -q -c -t 9 -T 9 'https://github.com/icebluey/7zip-zstd/releases/latest/download/7z.tar.sha256'
    sha256sum -c 7z.tar.sha256
    tar -xof 7z.tar
    rm -f /usr/bin/7z /usr/local/bin/7z
    install -v -c -m 0755 7z /usr/bin/7z
    cp -f /usr/bin/7z /usr/local/bin/7z
    /usr/bin/7z --version 2>/dev/null || true
    cd /tmp
    rm -fr "${_tmp_dir}"
}
_install_7z

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
cd "${_old_dir}"
_tmp_dir="$(mktemp -d)"
cp -a .xml "${_tmp_dir}"/.xml
cd "${_tmp_dir}"

rm -fr /tmp/_output
mkdir -p /tmp/_output/chrome/linux
mkdir /tmp/_output/chrome/windows

sleep 1
############################################################################
#
# Linux Version
#
############################################################################

# deb version
wget -c -t 9 -T 9 'https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb'
_chrome_deb_ver="$(dpkg-deb --info google-chrome-stable_current_amd64.deb | grep 'Version: ' | awk '{print $2}')"
sleep 1
mv -v -f google-chrome-stable_current_amd64.deb "google-chrome-stable_${_chrome_deb_ver}_amd64.deb"
sleep 1
sha256sum "google-chrome-stable_${_chrome_deb_ver}_amd64.deb" > "google-chrome-stable_${_chrome_deb_ver}_amd64.deb".sha256
mv -f *.deb* /tmp/_output/chrome/linux/
############################################################################

# rpm version
wget -c -t 9 -T 9 'https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm'
_chrome_rpm_ver="$(rpm -qp --info google-chrome-stable_current_x86_64.rpm 2>&1 | grep '^Version .*: ' | awk '{print $3}')"
_chrome_rpm_rel="$(rpm -qp --info google-chrome-stable_current_x86_64.rpm 2>&1 | grep '^Release .*: ' | awk '{print $3}')"
sleep 1
mv -v -f google-chrome-stable_current_x86_64.rpm "google-chrome-stable_${_chrome_rpm_ver}-${_chrome_rpm_rel}_x86_64.rpm"
sleep 1
sha256sum "google-chrome-stable_${_chrome_rpm_ver}-${_chrome_rpm_rel}_x86_64.rpm" > "google-chrome-stable_${_chrome_rpm_ver}-${_chrome_rpm_rel}_x86_64.rpm".sha256
mv -f *.rpm* /tmp/_output/chrome/linux/
############################################################################
#
# Windows Multiple User Version
#
############################################################################

# _chrome_win_ver='124.0.6367.79'

_new_uuid="$(cat /proc/sys/kernel/random/uuid | tr '[:lower:]' '[:upper:]')"

# Windows x64
wget -c -t 9 -T 9 "https://dl.google.com/tag/s/appguid%3D%7B8A69D345-D564-463C-AFF1-A69D9E530F96%7D%26iid%3D%7B${_new_uuid}%7D%26lang%3Den%26browser%3D4%26usagestats%3D0%26appname%3DGoogle%2520Chrome%26needsadmin%3Dprefers%26ap%3Dx64-stable-statsdef_1%26installdataindex%3Dempty/chrome/install/ChromeStandaloneSetup64.exe"
mkdir .win
/usr/bin/7z x ChromeStandaloneSetup64.exe -o.win/
_chrome_win_ver="$(strings .win/* 2>&1 | grep -i '<url codebase="http://dl.google.com/edgedl/chrome/install'  | sed 's|.*install/||g' | sed 's|/|\n|g' | grep '^[1-9]' | sort -V | tail -n 1)"
echo "chrome win x64 version: ${_chrome_win_ver}"
sleep 1
rm -fr .win
mv -v -f ChromeStandaloneSetup64.exe "google-chrome-stable_${_chrome_win_ver}-1_x64.exe"
sleep 1
openssl dgst -r -sha256 "google-chrome-stable_${_chrome_win_ver}-1_x64.exe" > "google-chrome-stable_${_chrome_win_ver}-1_x64.exe".sha256
_chrome_win_ver=''
mv -f *.exe* /tmp/_output/chrome/windows/

# Windows x86
wget -q -c -t 9 -T 9 "https://dl.google.com/tag/s/appguid%3D%7B8A69D345-D564-463C-AFF1-A69D9E530F96%7D%26iid%3D%7B${_new_uuid}%7D%26lang%3Den%26browser%3D4%26usagestats%3D0%26appname%3DGoogle%2520Chrome%26needsadmin%3Dprefers%26ap%3Dstable-arch_x86-statsdef_1%26installdataindex%3Dempty/chrome/install/ChromeStandaloneSetup.exe"
mkdir .win
/usr/bin/7z x ChromeStandaloneSetup.exe -o.win/
_chrome_win_ver="$(strings .win/* 2>&1 | grep -i '<url codebase="http://dl.google.com/edgedl/chrome/install'  | sed 's|.*install/||g' | sed 's|/|\n|g' | grep '^[1-9]' | sort -V | tail -n 1)"
echo "chrome win x86 version: ${_chrome_win_ver}"
sleep 1
rm -fr .win
mv -v -f ChromeStandaloneSetup.exe "google-chrome-stable_${_chrome_win_ver}-1_x86.exe"
sleep 1
openssl dgst -r -sha256 "google-chrome-stable_${_chrome_win_ver}-1_x86.exe" > "google-chrome-stable_${_chrome_win_ver}-1_x86.exe".sha256
_chrome_win_ver=''
_new_uuid=''

mv -f *.exe* /tmp/_output/chrome/windows/
############################################################################
#
# Windows Single User Version
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
mv -f *.exe* /tmp/_output/chrome/windows/
############################################################################

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
mv -f *.exe* /tmp/_output/chrome/windows/
############################################################################
echo
/bin/ls -la /tmp/_output/chrome/linux/
echo
/bin/ls -la /tmp/_output/chrome/windows/
echo
cd /tmp
rm -fr "${_tmp_dir}"
exit
