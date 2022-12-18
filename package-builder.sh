#!/bin/sh

if [[ -z $1  ]]; then
	echo "-------------------------------------"
	echo "Usage: <package-name> <architecture>"
	echo "-------------------------------------"
	echo "You must specify a package name and an architecture."
	echo "Achitecture options are \"32\" for 32 bit and \"64\" for 64 bit"
	echo "-------------------------------------"
	echo "64 bit package names are:"
	ls x86_64/ | sed 's/ /\n/g'
	echo "-------------------------------------"
	echo "32 bit package names are:"
	ls i686/ | sed 's/.i686//g'
	exit 1
fi

# install some build dependencies
<<<<<<< HEAD
sudo dnf -y install mock pykickstart fedpkg libvirt

# add current user to 'mock' build group
sudo usermod -a -G mock $USER
=======
sudo dnf -y install wget cpio mock pykickstart fedpkg libvirt fedora-packager rpmdevtools
>>>>>>> bfb7e56 (update 64 to latest release)

# turn selinux off if it's enabled
sudo setenforce 0

# make a destination folder for our packages
mkdir -p packages

<<<<<<< HEAD
# enter the repository of the package to build:
if [[ "$2" == "32" ]]; then
	BUILDARCH="i386"
	cd i686/$1.i686
else
	BUILDARCH="x86_64"
	cd x86_64/$1
fi

# create a fedora srpm from the spec sheet
fedpkg --release f36 srpm

# build the package
mock -r /etc/mock/fedora-36-$BUILDARCH.cfg --enable-network --rebuild *.src.rpm

# cleanup our source rpm
rm *.src.rpm

# move the package to our main folder
cd ../../
if [[ "$BUILDARCH" == "i386" ]]; then
	sudo mv /var/lib/mock/fedora-36-i686/result/*.rpm packages/
else
	sudo mv /var/lib/mock/fedora-36-$BUILDARCH/result/*.rpm packages/
fi

# cleanup our source rpm (again)
rm packages/*.src.rpm
=======
# Setup tree
mkdir -p SOURCES
mkdir -p SPECS
mkdir -p SRPMS
mkdir -p BUILD
mkdir -p BUILDROOT

# enter the repository of the package to build:
if [[ "$2" == "32" ]]; then
	export BUILDARCH="i686"
	cd i686/$1.i686
else
	export BUILDARCH="x86_64"
	cd x86_64/$1
fi



# build the package
rpmbuild -bb --define "_srcrpmdir $(pwd)/../../packages " --undefine=_disable_source_fetch  --target="$BUILDARCH" *.spec --define "_topdir $(pwd)/../.." --define "_rpmdir $(pwd)/../../packages"


# enter main dir

cd ../../

# Clean
rm -r BUILD
rm -r BUILDROOT

# Move rpms to packages

mv packages/x86_64/* packages/ || echo 'not a 64 bit package , this is ok!'

mv packages/i686/* packages/ || echo 'not a 32 bit package , this is ok!'

>>>>>>> bfb7e56 (update 64 to latest release)

# re-enable selinux if needed
sudo setenforce 1

<<<<<<< HEAD
# cleanup
mock -r /etc/mock/fedora-36-x86_64.cfg --scrub=all
mock -r /etc/mock/fedora-36-i386.cfg --scrub=all

=======
>>>>>>> bfb7e56 (update 64 to latest release)
