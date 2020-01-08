#!/system/bin/sh
  echo 1 > /sys/module/sec/parameters/recovery_done		#tony
if ! applypatch -c EMMC:recovery:5316608:a5ee0be935a2b672319829d409872c9db260b107; then
  log -t recovery "Installing new recovery image"
  applypatch -b /system/etc/recovery-resource.dat EMMC:boot:4530176:70a99c43df7a2431fdd450b0243beac539dc86c7 EMMC:recovery a5ee0be935a2b672319829d409872c9db260b107 5316608 70a99c43df7a2431fdd450b0243beac539dc86c7:/system/recovery-from-boot.p && log -t recovery "Installing new recovery image: succeeded" || log -t recovery "Installing new recovery image: failed"
  if applypatch -c EMMC:recovery:5316608:a5ee0be935a2b672319829d409872c9db260b107; then		#tony
	echo 0 > /sys/module/sec/parameters/recovery_done		#tony
        log -t recovery "Install new recovery image completed"
        
  if applysig /system/etc/recovery.sig recovery; then
    sync
    log -t recovery "Apply recovery image signature completed"
  else
    log -t recovery "Apply recovery image signature fail!!"
  fi

    
  else
	echo 2 > /sys/module/sec/parameters/recovery_done		#tony
        log -t recovery "Install new recovery image not completed"
  fi
else
  echo 0 > /sys/module/sec/parameters/recovery_done              #tony
  log -t recovery "Recovery image already installed"
fi
