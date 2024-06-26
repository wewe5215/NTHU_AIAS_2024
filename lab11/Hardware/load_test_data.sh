if [ -n "$1" ]
then
    if [ "$1" = "Emulator" ]
    then
        cp Emulator/Test\ asm/inst.asm ./src/main/resource/inst.asm
        cp Emulator/Test\ asm/inst.hex ./src/main/resource/inst.hex
	    cp Emulator/Test\ asm/data.hex ./src/main/resource/data.hex
    fi
else
    echo "[Error] usage should be: ./test_data.sh <which Test program> (Emulator/(-s) <inst code>)"
fi