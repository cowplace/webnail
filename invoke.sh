#!/bin/bash
export PATH="${HOME}/.rbenv/bin:${PATH}"
eval "$(rbenv init -)"
cd "${HOME}/webnail"

export DISPLAY=:99
if [ -f lock ]
then
	ps -ef | grep webkit | grep -v grep | awk '{print "kill",$2}' | sh
	exit 1
fi
touch lock
mv *.jpg img
rm img/*.jpg
bundle exec ruby test_capture_save.rb 2>&1 | tee -a `date '+%Y-%m-%d'`.log
rm lock
