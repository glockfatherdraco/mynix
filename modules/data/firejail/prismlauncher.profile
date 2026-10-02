# Firejail profile for PrismLauncher

include globals.local
include prismlauncher.local

ignore noexec ${HOME}

noblacklist ${HOME}/.config/PrismLauncher
noblacklist ${HOME}/.local/share/PrismLauncher

include allow-java.inc
include disable-common.inc
include disable-devel.inc
include disable-interpreters.inc
include disable-programs.inc
include disable-shell.inc
include disable-xdg.inc

mkdir ${HOME}/.config/PrismLauncher
mkdir ${HOME}/.local/share/PrismLauncher
whitelist ${HOME}/.config/PrismLauncher
whitelist ${HOME}/.local/share/PrismLauncher

include whitelist-common.inc
include whitelist-runuser-common.inc
include whitelist-usr-share-common.inc
include whitelist-var-common.inc

caps.drop all
netfilter
nodvd
nogroups
nonewprivs
noroot
notv
nou2f
novideo
protocol unix,inet,inet6,netlink
seccomp
tracelog

disable-mnt
private-cache
private-dev
private-tmp
private-bin bash,sh,java,java-config,javaw,keytool,minecraft-launcher,prismlauncher,xdg-open,zenity,kdialog,gamemoderun,gamemoded

dbus-system none
dbus-user filter
dbus-user.talk org.freedesktop.portal.Desktop
dbus-user.talk org.freedesktop.notifications
dbus-user.talk com.feralinteractive.GameMode

restrict-namespaces

include prismlauncher.local
