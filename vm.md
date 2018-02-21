# Virtual Machines, Dockers and Other Containers

<A name="QemuKvm"></A>

## VirtualBox
- advantage easy to install, use, and understand
- drawback: heavyweight app, uses Qt on Ubuntu
- slower than necessary when local, extremely sluggish over X display-back

## QEMU-KVM
- [Howto](http://www.ubuntubuzz.com/2016/05/how-to-install-kvm-with-gui-virt-manager-in-ubuntu.html) for installing QEMU-KVM
- Displaying a VM over remote link (logging in from home):
    * `ssh -X -l myLoginName myHostOrIP`
    * To display back from Ubuntu to home Machine:
        1. enable X display-back application (VNC, etc.)
        1. `dbus-launch virt-manager`   
