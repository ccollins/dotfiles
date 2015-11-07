if test ! $(which ansible)
then
    brew install ansible > /tmp/ansible-install.log
fi

if test ! $(which wget)
then
    brew install wget > /tmp/wget-install.log
fi
