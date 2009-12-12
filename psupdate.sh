#! /bin/bash

# Config vars
# Diff files to use
patch_nomod = "nomod.diff"
patch_bb2 = "bb2_r18400.diff"
patch_magicbull = "magic_bulldozer_v3_and_force_r18400.diff"

echo "-------------------------------"
echo "| Publicserver update wrapper |"
echo "-------------------------------"
echo "This will attempt to run through the following commands;"
echo "update"
echo "patch -p0 < patches/$patch_nomod"
echo "patch -p0 < patches/$patch_bb2"
echo "patch -p0 < patches/$patch_magicbull"
echo "make bundle"
echo "cp -Rf bundle/* autopilot"
echo "update -w"
echo ""
read -p "Continue? (y/n) > " ans
if [[ "$ans" != "Y" && "$ans" != "Yes" && "$ans" != "y" && "$ans" != "yes" ]]; then
	echo ""
	echo "Aborting. No actions performed"
	exit 1
fi
echo ""
echo "Making sure we're in /home/openttd/svn-public directory"
cd /home/openttd/svn-public
echo "Running \"./update\""
./update
echo "If the update failed for some reason, abort now (auto continue in 10sec)"
read -t 10 -p "Abort? (y/n) [n] > " ans
if [[ "$ans" == "Y" || "$ans" == "Yes" || "$ans" == "y" || "$ans" == "yes" ]]; then
	echo ""
	echo "Aborting. update abort point"
	exit 1
fi
echo ""
echo "Applying $patch_nomod"
patch -p0 < patches/$patch_nomod
echo ""
read -t 10 -p "Continue? (y/n) [y] > " ans
if [[ "$ans" == "N" || "$ans" == "No" || "$ans" == "n" || "$ans" == "no" ]]; then
	echo ""
	echo "Aborting. patch $patch_nomod failed."
	echo "Running \"svn revert . -R\""
	svn revert . -R
	echo ""
	exit 1
fi
echo ""
echo "Applying $patch_bb2"
patch -p0 < patches/$patch_bb2
echo ""
read -t 10 -p "Continue? (y/n) [y] > " ans
if [[ "$ans" == "N" || "$ans" == "No" || "$ans" == "n" || "$ans" == "no" ]]; then
	echo ""
	echo "Aborting. patch $patch_bb2 failed."
	echo "Running \"svn revert . -R\""
	svn revert . -R
	echo ""
	exit 1
fi
echo ""
echo "Applying $patch_magicbull"
patch -p0 < patches/$patch_magicbull
echo ""
read -t 10 -p "Continue? (y/n) [y] > " ans
if [[ "$ans" == "N" || "$ans" == "No" || "$ans" == "n" || "$ans" == "no" ]]; then
	echo ""
	echo "Aborting. patch $patch_magicbull failed"
	echo "Running \"svn revert . -R\""
	svn revert . -R
	echo ""
	exit 1
fi
echo ""
echo "Making bundle"
make bundle
echo ""
echo "If make fails, abort now (no auto-continue)"
read -p "Abort? (y/n) [n] > " ans
if [[ "$ans" == "Y" || "$ans" == "Yes" || "$ans" == "y" || "$ans" == "yes" ]]; then
	echo ""
	echo "Aborting. \"make bundle\" abort point"
	echo ""
	echo "Reverting"
	svn revert . -R
	echo ""
	exit 1
fi
echo ""
echo "Copying bundle to autopilot"
cp -Rf bundle/* autopilot
echo ""
echo "Updating with -w"
./update -w
echo ""
echo "Script finished"
echo "You can now restart the PublicServer by;"
echo "Ctrl-A 0"
echo "exit (saves and quits)"
echo "If you are re-launching an existing game, issue:"
echo "  \"./autopilot.tcl load | tee -a logs/<gamenr>.log\""
echo "For loading a new game, issue:"
echo "  \"./autopilot.tcl load save/path_to/save.sav| tee logs/<gamenr>.log\""
