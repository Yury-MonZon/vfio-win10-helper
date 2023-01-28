# vfio-win10-helper
GPU passthrough Win10 helper

These little scripts can fix your black screen after VM shutdown.

How is works:
On shutdown - it disables GPU driver
On startup - guess what? It does the opposite thing :-D

Installation
0. Make a snapshot of your VM and run it.
1. Run dump_device_list.cmd 
2. Open devices.txt file in your preferred text editor and find (ctrl+F) you GPU card and it's devices (audio, usb, etc).
3. Put your InstanceId's into enable.cmd and disable.cmd. Currently, my id's for NVIDIA 1060 are there. Don't forget to save.
4. Run install_scripts.cmd. It will open gpedit. 
   Do those stepss:
   - Now go to Computer Configuration\Windows Settings\Scripts(Startup/Shutdown).
   - Double click on Startup, Add, select enable.cmd file.
   - Do the same for Shutdown.
5. Shutdown your VM and if you see your screen flicker - congrats! 
Now you can enjoy your GPU passthrough setup without rebooting after VM shutdown.
