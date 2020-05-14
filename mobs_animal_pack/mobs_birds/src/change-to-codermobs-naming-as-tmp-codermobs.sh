#!/bin/bash

customDie() {
    echo
    echo
    echo "ERROR:"
    echo "$1"
    echo
    exit 1
}

if [ ! -d ../models ]; then
    customDie "ERROR: Nothing done since no ../models"
fi
if [ ! -d ../textures ]; then
    customDie "ERROR: Nothing done since no ../textures"
fi

pushd ..

if [ -d /tmp/codermobs ]; then
    rm -Rf /tmp/codermobs || customDie "Cannot remove old /tmp/codermobs"
fi
mkdir /tmp/codermobs
# cp init.lua /tmp/codermobs/bird.lua || customDie "Cannot copy init.lua to /tmp/codermobs"
cp -R src /tmp/codermobs/
mkdir /tmp/codermobs/models
mkdir /tmp/codermobs/textures

pushd models || customDie "Cannot cd models"
cp mobs_birds_gull.b3d "/tmp/codermobs/models/codermobs_gull.b3d"
cp mobs_birds_thrush.b3d "/tmp/codermobs/models/codermobs_thrush.b3d"
popd

pushd textures || customDie "Cannot cd textures"
cp animal_gull_mesh.png "/tmp/codermobs/textures/codermobs_gull_white.png"
cp gull_black.png "/tmp/codermobs/textures/codermobs_gull_black.png"
cp gull_gray.png "/tmp/codermobs/textures/codermobs_gull_gray.png"
cp gull_grayblue.png "/tmp/codermobs/textures/codermobs_gull_bluegray.png"
cp bird_blueish.png "/tmp/codermobs/textures/codermobs_bird_blue.png"
cp bird_brown.png "/tmp/codermobs/textures/codermobs_bird_brown.png"
cp bird_gray.png "/tmp/codermobs/textures/codermobs_bird_gray.png"
cp bird_grayblue.png "/tmp/codermobs/textures/codermobs_bird_bluegray.png"
cp bird_red.png "/tmp/codermobs/textures/codermobs_bird_red.png"
cp bird_redish.png "/tmp/codermobs/textures/codermobs_bird_redish.png"
popd

#cd ../models
#mv mobs_birds_thrush.b3d        codermobs_thrush.b3d
#mv mobs_birds_gull.b3d          codermobs_gull.b3d
#cd ../textures
#mv mobs_birds_bird_blue.png     codermobs_bird_blue.png
#mv mobs_birds_bird_brown.png    codermobs_bird_brown.png
#mv mobs_birds_bird_gray.png     codermobs_bird_gray.png
#mv mobs_birds_bird_bluegray.png codermobs_bird_bluegray.png
#mv mobs_birds_bird_red.png      codermobs_bird_red.png
#mv mobs_birds_bird_redish.png   codermobs_bird_redish.png
#mv mobs_birds_gull_white.png    codermobs_gull_white.png
#mv mobs_birds_gull_black.png    codermobs_gull_black.png
#mv mobs_birds_gull_gray.png     codermobs_gull_gray.png
#mv mobs_birds_gull_bluegray.png codermobs_gull_bluegray.png

echo "Now manually run:"
echo "diff \$my_bucket_game/mods/codermobs/codermobs /tmp/codermobs"
echo
echo "#or"
echo
echo "meld \$my_bucket_game/mods/codermobs/codermobs /tmp/codermobs"
echo "# * then turn off 'Same' and 'New' buttons, making sure 'Modified' is on."
