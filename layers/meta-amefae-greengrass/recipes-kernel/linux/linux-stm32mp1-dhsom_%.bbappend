FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI_append = "file://fragment.cfg"

do_configure_append() {
    bbnote "attempting to use the fragment.cfg to bring in DOCKER kernel requirements"
    cat ${WORKDIR}/*.cfg >> ${B}/.config
}
