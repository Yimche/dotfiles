whitelist ~/Documents/uni
whitelist ~/Pictures
whitelist ~/.config/dunst
blacklist ~/Desktop
include /etc/firejail/firefox-developer-edition.profile


dbus-user filter
dbus-user.call org.freedesktop.Notifications=org.freedesktop.Notifications.*@/org/freedesktop/Notifications
dbus-user.broadcast org.freedesktop.Notifications=org.freedesktop.Notifications.*@/org/freedesktop/Notifications
