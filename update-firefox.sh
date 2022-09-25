#!/bin/bash
echo 'Limpando ambiente'
rm -rf firefox-*
rm -rf firefox/
echo 'Baixando o a ultimas versao do Mozilla Firefox....'
URL_BASE='https://ftp.mozilla.org/pub/firefox/releases/'
curl -s $URL_BASE > ./versions_firefox.txt
VERSION_FIREFOX=$(sed 's/<[^>]*>//g' versions_firefox.txt | sed '/^[[:space:]]*$/d' |  sed "s/[[:space:]]//g" | sed '/[[:alpha:]]/d' | sort | grep -E "^[0-9][0-9][0-9].[0-9].[0-9]/$" | sort | tail -n 1 | sed "s/[\/]$//")
URL_BASE_FILE=$URL_BASE$VERSION_FIREFOX'/linux-x86_64/en-US/firefox-'$VERSION_FIREFOX'.tar.bz2'
wget $URL_BASE_FILE
NAME_FILE_FIREFOX='firefox-'$VERSION_FIREFOX'.tar.bz2'

echo 'Fechando o Mozilla Firefox...'
pids_firefox=( $(pgrep -f 'firefox') )
for pid in "${pids_firefox[@]}"; do
  if [[ $pid != $$ ]]; then
    kill "$pid"
  fi
done

echo 'Atualizando o Mozilla Firefox ....'
sudo rm -rf /opt/firefox

# extrair o firefox
tar -xf $NAME_FILE_FIREFOX
sudo cp -r firefox/ /opt

echo 'limpando arquivos de instalacao'
rm $NAME_FILE_FIREFOX
rm -rf firefox/
# Para adicionar o atalho ao firefox, bsata descomentar essas proximas linhas
echo 'Adicionar atalho para o Mozilla Firefox,,,,'
# cp firefox-stable.desktop ~/.local/share/applications
