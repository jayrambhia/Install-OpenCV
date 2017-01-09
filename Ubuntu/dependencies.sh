#!/bin/bash

echo "--- Removing any pre-installed ffmpeg and x264"
sudo apt-get -qq remove ffmpeg x264 libx264-dev

function install_dependency {
    echo "--- Installing dependency: $1"
    sudo apt-get -y install $1
}

install_dependency libopencv-dev
install_dependency build-essential
install_dependency checkinstall
install_dependency cmake
install_dependency pkg-config
install_dependency yasm
install_dependency libtiff5-dev
install_dependency libjpeg-dev
install_dependency libjasper-dev
install_dependency libavcodec-dev
install_dependency libavformat-dev
install_dependency libswscale-dev
install_dependency libdc1394-22-dev
install_dependency libxine2-dev
install_dependency libgstreamer0.10-dev
install_dependency libgstreamer-plugins-base0.10-dev
install_dependency libv4l-dev
install_dependency python-dev
install_dependency python-numpy
install_dependency libtbb-dev
install_dependency libqt5x11extras5
install_dependency libqt5opengl5
install_dependency libqt5opengl5-dev
install_dependency libgtk2.0-dev
install_dependency libfaac-dev
install_dependency libmp3lame-dev
install_dependency libopencore-amrnb-dev
install_dependency libopencore-amrwb-dev
install_dependency libtheora-dev
install_dependency libvorbis-dev
install_dependency libxvidcore-dev
install_dependency x264
install_dependency v4l-utils
#install_dependency ffmpeg
install_dependency unzip
