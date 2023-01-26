function measure(){
	echo "✨ Initializing measure ..."
	
	# Initializing args
	apk1=$1
	apk2=$2
	measureFlow=$3
	setupFlow=${4:-""}
	iteration="${5:-3}" # 5th arg, default value : 3
	packageName=$(grep -oE 'appId:\s*(.*)' $measureFlow | awk '{print $2}')
	timestamp=$(date +"%Y%m%d-%H%M%S")
	gfxInfoDir="gfxinfo-$timestamp"
	apk1GfxDir="$gfxInfoDir/$apk1-gfxinfo"
	apk2GfxDir="$gfxInfoDir/$apk2-gfxinfo"

	# Printing args
	echo "-----------------------------------"
	echo "➡️ APK 1 : $apk1"
	echo "➡️ APK 2 : $apk2"
	echo "➡️ Measure Flow : $measureFlow"
	echo "➡️ Setup Flow : ${setupFlow:-"(not given)"}"
	echo "➡️ Iteration: $iteration"
	echo "➡️ Package Name: $packageName"
	echo "➡️ gfxInfo dir: $gfxInfoDir"
	echo "-----------------------------------"

	# Confirming existing APK removal
	read shouldUninstall\?"❓ Do you want to uninstall '$packageName' first ? (y/N): "
	if [[ "$shouldUninstall" == "y" ]]; then
		echo "🗑 Uninstalling '$packageName'"
		adb -d uninstall $packageName
	fi

	# Installing first APK
	echo "🪄 Installing '$apk1' ..."
	adb -d install $apk1

	# Checking if setup flow given, else confirming measure flow start
	if [ -z "$setupFlow" ]; then
		read null\?"❓ Press ENTER to start the flow on '$apk1'"
	else
		if [[ "$shouldUninstall" == "y" ]]; then
			maestro test $setupFlow
		fi
	fi

	# Measuring APK1
	mkdir -p "$apk1GfxDir"
	for i in {1..$iteration}
	do
		adb shell dumpsys gfxinfo $packageName reset
		echo "♺ Iteration $i/$iteration"
		maestro test $measureFlow
		adb shell dumpsys gfxinfo $packageName > "$apk1GfxDir/iteration-$i.txt"
	done

	# Uninstalling APK 1 since measurement is done
	echo "🗑 Uninstalling '$packageName'"
	adb -d uninstall $packageName

	# Installing second APK
	echo "🪄 Installing APK 2 ..."
	adb -d install $apk2
	
	# Checking if setup flow given, else confirming measure flow start
	if [ -z "$setupFlow" ]; then
		read null\?"❓ Press ENTER to start the flow on '$apk2'"
	else
		maestro test $setupFlow
	fi

	# Measuring APK2
	mkdir -p "$apk2GfxDir"
	for i in {1..$iteration}
	do
		adb shell dumpsys gfxinfo $packageName reset
		echo "♺ Iteration $i/$iteration"
		maestro test $measureFlow
		adb shell dumpsys gfxinfo $packageName > "$apk2GfxDir/iteration-$i.txt"
	done

	# Averaging gfx data
	echo "🧮 Averaging gfxdata..."
	cd "$apk1GfxDir"
	gfx-avg > gfx-avg.txt
	cd "../../$apk2GfxDir"
	gfx-avg > gfx-avg.txt
	cd ../..

	echo "✅ Done!"
}