if [ ! -d ../models ]; then
  echo "no ../models"
  exit 1
fi
if [ ! -d ../textures ]; then
  echo "no ../textures"
  exit 1
fi

cd ../models
# mv mobs_birds_thrush.b3d mobs_birds_thrush.b3d
mv animal_gull.b3d       mobs_birds_gull.b3d
cd ../textures
mv bird_blueish.png      mobs_birds_bird_blue.png      # note naming pattern change
mv bird_brown.png        mobs_birds_bird_brown.png
mv bird_gray.png         mobs_birds_bird_gray.png
mv bird_grayblue.png     mobs_birds_bird_bluegray.png  # note naming pattern change
mv bird_red.png          mobs_birds_bird_red.png
mv bird_redish.png       mobs_birds_bird_redish.png
mv animal_gull_mesh.png  mobs_birds_gull_white.png     # note naming pattern change
mv gull_black.png        mobs_birds_gull_black.png
mv gull_gray.png         mobs_birds_gull_gray.png
mv gull_grayblue.png     mobs_birds_gull_bluegray.png  # note naming pattern change
# rm ../etc/gull-oldUVLayout.blend
# mv ../uvtest-64x64.png $HOME/ownCloud/Resources/Pictures/Maps/
