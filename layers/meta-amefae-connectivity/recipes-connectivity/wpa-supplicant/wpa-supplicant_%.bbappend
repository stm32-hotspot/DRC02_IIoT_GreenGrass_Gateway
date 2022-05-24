SUMMARY = "custom wireless recipe"
DESCRIPTION = "Recipe created by bitbake-layers for wireless manipulation"

FILESEXTRAPATHS_prepend := "${THISDIR}/:"
FILES_${PN} += "/lib/systemd/network/ /lib/systemd/network/51-wireless.network"

SRC_URI += "file://wpa_supplicant-wlan0.conf file://51-wireless.network"

SYSTEMD_AUTO_ENABLE = "enable"
SYSTEMD_SERVICE_${PN}_append = " wpa_supplicant@wlan0.service  "

do_install_append () {
    install -d ${D}/etc/wpa_supplicant/
    install -D -m 600 ${WORKDIR}/wpa_supplicant-wlan0.conf ${D}/etc/wpa_supplicant/

    install -d ${D}/lib/systemd/network/
    install -D -m 600 ${WORKDIR}/51-wireless.network ${D}/lib/systemd/network/
}
