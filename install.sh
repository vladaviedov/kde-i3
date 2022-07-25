#!/bin/bash
I3=$HOME/.config/i3
SYSTEMD_USER=$HOME/.config/systemd/user
BIN_LOCAL=/usr/local/bin
XSESSIONS=/usr/share/xsessions
ESC_HOME=${HOME//\//\\\/}

# sudo or doas
if command -v sudo &> /dev/null
then
	ASROOT=sudo
else
	if command -v doas &> /dev/null
	then
		ASROOT=doas
	else
		echo "Install failed: neither sudo nor doas are installed"
		exit 1
	fi
fi

# Check for executables
if ! command -v i3 &> /dev/null
then
	echo "warning: i3 not installed"
fi
if ! command -v startplasma-x11 &> /dev/null
then
	echo "warning: plasma is not installed"
fi

# Copy config if doesn't exist
if [ ! -f $I3/config-kde ]
then
	echo "~/.config/i3/config-kde does not exist"
	if [ ! -f $I3/config ]
	then
		if ! command -v i3-config-wizard
		then
			echo "Unable generate config file: i3-config-wizard not installed"	
			exit 1
		fi
		i3-config-wizard
	fi

	# Copy normal config
	if [ cp $I3/config $I3/config-kde ]
	then
		echo "~/.config/i3/config copied"
	else
		echo "failed to copy i3 config"
		exit 1
	fi
fi

# Install service
cp files/plasma-i3.service $SYSTEMD_USER
sed -i "/ExecStart/ s/HOME/$ESC_HOME/" $SYSTEMD_USER/plasma-i3.service

# Install enabler script
$ASROOT cp files/startplasma-i3 $BIN_LOCAL
$ASROOT chmod 755 $BIN_LOCAL/startplasma-i3

# Make xsession
$ASROOT cp files/plasma-i3.desktop $XSESSIONS

echo "Installation Successful"
