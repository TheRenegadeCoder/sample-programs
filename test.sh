#!/bin/bash
echo "#############################"
echo "# DOWNLOADING DOCKER IMAGES #"
echo "#############################"
python -um samplerunner download
echo ""

echo "#################"
echo "# RUNNING TESTS #"
echo "#################"
exec python -um samplerunner test
