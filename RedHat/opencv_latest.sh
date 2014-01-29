sudo yum -y install wget
. `dirname $0`/../get_latest_version_download_file.sh
if [ $? -ne 0 ]; then
	exit $?;
fi
echo "Installing OpenCV" $version
mkdir -p OpenCV
cd OpenCV
echo "Installing Dependencies"
sudo yum -y install http://dl.fedoraproject.org/pub/epel/6/i386/epel-release-6-8.noarch.rpm
set -e
sudo yum -y groupinstall "Development Tools"
sudo yum -y install unzip opencv opencv-devel gtk2-devel
if [ ! -f $downloadfile ]; then
	echo "Downloading OpenCV" $version
	wget -O $downloadfile http://sourceforge.net/projects/opencvlibrary/files/opencv-unix/$version/$downloadfile/download
fi
if [ ! -d opencv-$version ]; then
	echo "Installing OpenCV" $version
	echo $downloadfile | grep ".zip"
	if [ $? -eq 0 ]; then
		unzip $downloadfile
	else
		tar -xvf $downloadfile
	fi
fi
cd opencv-$version
cmake --version | grep " 2.6"
if [ $? -eq 0 ]; then
	# Delete lines beginning with string(MD5 based on incompatibility with cmake 2.6.  See 
	# http://answers.opencv.org/question/24095/building-opencv-247-on-centos-6/
	sed  -i '/string(MD5/d' cmake/cl2cpp.cmake
fi
mkdir -p build
cd build
cmake -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=/usr/local ..
make -j 4
sudo make install
sudo sh -c 'echo "/usr/local/lib" > /etc/ld.so.conf.d/opencv.conf'
sudo ldconfig
echo "OpenCV" $version "ready to be used"
