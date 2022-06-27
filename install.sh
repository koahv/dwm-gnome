#!/bin/bash

PREFIX="/usr"
PATH_DWM_GNOME="$PREFIX/bin/dwm-gnome"
PATH_DWM_GNOME_DESKTOP="$PREFIX/share/applications/dwm-gnome.desktop"
PATH_DWM_GNOME_SESSION="$PREFIX/share/gnome-session/sessions/dwm-gnome.session"
PATH_DWM_GNOME_XSESSION="$PREFIX/share/xsessions/dwm-gnome.desktop"
PATH_GNOME_SESSION_DWM="$PREFIX/bin/gnome-session-dwm"
PATH_DOCS="$PREFIX/share/docs/dwm-gnome"
PATH_LICENSE="$PREFIX/share/licenses/dwm-gnome"


ChooseMainOption() {

	echo; echo "Select an option"; echo

	echo "1 - Install session config"
    echo "2 - Install dwm"
	echo "3 - Uninstall session config"
    echo "4 - Uninstall dwm"
    echo "5 - Exit"
    echo

	read OPTION;

	case $OPTION in

		1) install_session;;
        2) install_dwm;;
        3) uninstall_session;;
        4) uninstall_dwm;;
        5) exit 0;;

    esac
}


install_session() {

    read -p "Install session config? (Y/y)" -n 1 -r; echo

    if [[ $REPLY =~ ^[Yy]$ ]]; then

    	read -p "Enter Linux user " USER1; echo

	    read -p "Is $USER1 correct? (Y/y)" -n 1 -r; echo

    	if [[ $REPLY =~ ^[Yy]$ ]]; then

            echo "Authentication required to install configurations..."

            sudo sed -i "s/USER/$USER1/" session/dwm-gnome

            sudo install -D config/bg/M2020G2.jpg /home/$USER1/
	    	sudo install -D config/dmenu-status/time /home/$USER1/
            sudo install -m0644 -D session/dwm-gnome-xsession.desktop $PATH_DWM_GNOME_XSESSION
            sudo install -m0644 -D session/dwm-gnome.desktop $PATH_DWM_GNOME_DESKTOP
	        sudo install -m0644 -D session/dwm-gnome.session $PATH_DWM_GNOME_SESSION
	        sudo install -m0755 -D session/dwm-gnome $PATH_DWM_GNOME
	        sudo install -m0755 -D session/gnome-session-dwm $PATH_GNOME_SESSION_DWM
	        sudo install -m0644 -D README.md $PATH_DOCS/README.md
	        sudo install -m0644 -D LICENSE.txt $PATH_LICENSE/LICENSE

            echo "Done"

            ChooseMainOption

        else

		    install_session

        fi


    else

        ChooseMainOption

    fi

}


uninstall_session() {

    read -p "Uninstall? (Y/y)" -n 1 -r; echo

    if [[ $REPLY =~ ^[Yy]$ ]]; then

        rm -f $PATH_DWM_GNOME
	    rm -f $PATH_DWM_GNOME_DESKTOP
	    rm -f $PATH_DWM_GNOME_SESSION
	    rm -f $PATH_DWM_GNOME_XSESSION
	    rm -f $PATH_GNOME_SESSION_DWM
	    rm -rf $PATH_DOCS
	    rm -rf $PATH_LICENSE

        echo "Done"

        ChooseMainOption

    else

        ChooseMainOption

    fi

}


install_dwm() {

    read -p "Install dwm? (Y/y)" -n 1 -r; echo

    if [[ $REPLY =~ ^[Yy]$ ]]; then

        echo "Authentication required to install dwm and dependencies"

        sudo pacman -S base-devel make libxinerama freetype2 libxft sed dmenu feh geoip geoip-database bind xorg-server xorg-xsetroot

        (cd dwm; sudo make clean install)

        echo "Done"

        ChooseMainOption

    else

	    ChooseMainOption

    fi

}



uninstall_dwm() {

    read -p "Uninstall dwm? (Y/y)" -n 1 -r; echo

    if [[ $REPLY =~ ^[Yy]$ ]]; then

        echo "Authentication required to uinstall dwm"

        (cd dwm; sudo make uninstall)

        echo "Done"

        ChooseMainOption

    else

	    ChooseMainOption

    fi

}


ChooseMainOption
