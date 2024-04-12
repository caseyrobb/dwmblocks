#!/bin/bash

. ~/.local/bin/nord.sh

envFile=~/.config/redshift/env

[[ -f $envFile ]] || createEnv

. $envFile

changeValue=100

case $BLOCK_BUTTON in
    1) ACTION=toggle;;
    4) ACTION=increase;;
    5) ACTION=decrease;;
esac

[[ -z ${BLOCK_BUTTON+x} ]] && ACTION=temperature

createEnv() {
  mkdir -p ~/.config/redshift 2>/dev/null
  echo "REDSHIFT=off\nRESHIFT_TEMP=1700" >> $envFile
}

changeMode() {
  sed -i "s/REDSHIFT=$1/REDSHIFT=$2/g" $envFile 
  REDSHIFT=$2
  echo $REDSHIFT
}

changeTemp() {
  if [ "$2" -gt 1000 ] && [ "$2" -lt 25000 ]
  then
    sed -i "s/REDSHIFT_TEMP=$1/REDSHIFT_TEMP=$2/g" $envFile 
    redshift -P -O $((REDSHIFT_TEMP+changeValue))
  fi
}

case $ACTION in 
  toggle) 
    if [ "$REDSHIFT" = on ];
    then
      changeMode "$REDSHIFT" off
      redshift -x
    else
      changeMode "$REDSHIFT" on
      redshift -O "$REDSHIFT_TEMP"
    fi
    ;;
  increase)
    changeTemp $((REDSHIFT_TEMP)) $((REDSHIFT_TEMP+changeValue))
    ;;
  decrease)
    changeTemp $((REDSHIFT_TEMP)) $((REDSHIFT_TEMP-changeValue));
    ;;
  temperature)
    case $REDSHIFT in
      on)
        #echo -e "${FGBLACK} 󰛨 ${REDSHIFT_TEMP}K " 
        echo -e "󰛨 ${REDSHIFT_TEMP}K" 
        ;;
      off)
        #echo -e "${BGGREEN}${FGBLACK} 󰹏 off "
        echo -e "󰹏 off"
        ;;
    esac
    ;;
esac
