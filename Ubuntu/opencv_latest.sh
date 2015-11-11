#!/bin/bash
. `dirname $0`/../get_latest_version_download_file.sh
if [ $? -ne 0 ]; then
    exit $?;
fi
. `dirname $0`/opencv_install.sh
