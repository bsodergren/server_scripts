#! /bin/bash

__PROJECT_NAME="USB Add Device"

__INC_LIB_DIR="/home/pi/bin/inc"



if [[ "${ACTION}" = add &&  ${DEVNAME} =~ "ttyUSB0" ]]

then

    source  "${__INC_LIB_DIR}/header.sh"
    main.log "Action " ${ACTION}
    main.log "DevName " ${DEVNAME}


    	main.log "Adding a new MLSC Box device"

 	run_cmd "/home/pi/bin/build_mlsc.sh -u -n"
 	main.log "done"
fi





#sudo nano /etc/udev/rules.d/test.rules
#pi@lights:~ $ sudo udevadm control --reload-rule
#pi@lights:~ $ sudo udevadm trigger
#pi@lights:~ $

