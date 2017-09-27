echo "--- Removing any pre-installed ffmpeg and x264"
apt-get -qq remove ffmpeg x264 libx264-dev

install_dependency() {
    echo "--- Installing dependency: $1"
    apt-get -y install $1
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
install_dependency libqt4-dev
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

mkdir -p opencv
cd opencv
wget https://github.com/Itseez/opencv/archive/3.1.0.zip
unzip 3.1.0.zip
cd opencv-3.1.0
mkdir build
cd build
cmake -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=/usr/local -D WITH_TBB=ON -D BUILD_NEW_PYTHON_SUPPORT=ON -D WITH_V4L=ON -D WITH_FFMPEG=OFF -D BUILD_opencv_python2=ON -D BUILD_opencv_python3=ON -D WITH_1394=OFF ..
make -j4
make install
sh -c 'echo "/usr/local/lib" > /etc/ld.so.conf.d/opencv.conf'
ldconfig
#cp /usr/src/app/opencv/opencv-3.1.0/build/lib/cv2.so /usr/src/app/lib/python2.7/site-packages/
echo "OpenCV" $version "ready to be used"
