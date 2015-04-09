mkdir -p /usr/src/initramfs/{bin,dev,etc,lib,lib64,mnt/root,proc,root,sbin,sys,usr/lib64}
cp -a /dev/{null,console,tty,sda3} /usr/src/initramfs/dev/
cp -a /bin/busybox /usr/src/initramfs/bin/busybox
cp -a init /usr/src/initramfs/init
chmod +x /usr/src/initramfs/init

cp -a /dev/{urandom,random} /usr/src/initramfs/dev
bash copy-recursive-ll.sh /sbin/cryptsetup /usr/src/initramfs

# install a shell
cd /usr/src/initramfs
ln bin/busybox bin/sh

# for a seperate file
cd /usr/src/initramfs
find . -print0 | cpio --null -ov --format=newc | gzip -9 > /boot/custom-initramfs.cpio.gz
