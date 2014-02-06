# Dan Walkes
# 2014-01-29
# Call this script after configuring variables:
# version - the version of OpenCV to be installed
# downloadfile - the name of the OpenCV download file
# dldir - the download directory (optional, if not specified creates an OpenCV directory in the working dir)
if [[ -z "$version" ]]; then
        echo "Please define version before calling `basename $0` or use a wrapper like opencv_latest.sh"
        exit 1
fi
if [[ -z "$downloadfile" ]]; then
        echo "Please define downloadfile before calling `basename $0` or use a wrapper like opencv_latest.sh"
        exit 1
fi
if [[ -z "$dldir" ]]; then
        dldir=OpenCV
fi
echo "Installing OpenCV" $version
mkdir $dldir
cd $dldir
echo "Removing any pre-installed ffmpeg and x264"
sudo apt-get -qq remove ffmpeg x264 libx264-dev
echo "Installing Dependenices"
sudo apt-get -qq install libopencv-dev build-essential checkinstall cmake pkg-config yasm libtiff4-dev libjpeg-dev libjasper-dev libavcodec-dev libavformat-dev libswscale-dev libdc1394-22-dev libxine-dev libgstreamer0.10-dev libgstreamer-plugins-base0.10-dev libv4l-dev python-dev python-numpy libtbb-dev libqt4-dev libgtk2.0-dev libfaac-dev libmp3lame-dev libopencore-amrnb-dev libopencore-amrwb-dev libtheora-dev libvorbis-dev libxvidcore-dev x264 v4l-utils ffmpeg unzip
echo "Downloading OpenCV" $version
wget -O $downloadfile http://sourceforge.net/projects/opencvlibrary/files/opencv-unix/$version/$downloadfile/download
echo "Installing OpenCV" $version
echo $downloadfile | grep ".zip"
if [ $? -eq 0 ]; then
	unzip $downloadfile
else
	tar -xvf $downloadfile
fi
cd opencv-$version
mkdir build
cd build
cmake -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=/usr/local -D WITH_TBB=ON -D BUILD_NEW_PYTHON_SUPPORT=ON -D WITH_V4L=ON -D INSTALL_C_EXAMPLES=ON -D INSTALL_PYTHON_EXAMPLES=ON -D BUILD_EXAMPLES=ON -D WITH_QT=ON -D WITH_OPENGL=ON ..
make -j 4
sudo make install
sudo sh -c 'echo "/usr/local/lib" > /etc/ld.so.conf.d/opencv.conf'
sudo ldconfig
echo "OpenCV" $version "ready to be used"
