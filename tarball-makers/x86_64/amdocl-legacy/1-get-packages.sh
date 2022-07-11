# please define the major , minor & rhel version of the packages you want 

major=22.10.2
minor=1411481
rhel_major=9.0
rhel_minor=9

#

echo "pulling required packages off repo.radeon.com"

mkdir ./rpms

cd ./rpms

wget http://repo.radeon.com/amdgpu/22.10.2/rhel/"$rhel_major"/proprietary/x86_64/opencl-legacy-amdgpu-pro-icd-"$major"-"$minor".el"$rhel_minor".x86_64.rpm

wget http://repo.radeon.com/amdgpu/22.10.2/rhel/"$rhel_major"/proprietary/x86_64/ocl-icd-amdgpu-pro-"$major"-"$minor".el"$rhel_minor".x86_64.rpm