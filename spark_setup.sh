#!/usr/bin/bash 
#OBS bash strictmode
set -oue pipefail

# Create JDK directory in ~/.local/share
JDK_PATH="$HOME/.local/share/jdk/17"

#OBS mkdir -p: creates directories recursively
mkdir -p "$JDK_PATH" 

# Download JDK17 from archive
# for 11: https://builds.openlogic.com/downloadJDK/openlogic-openjdk/11.0.22+7/openlogic-openjdk-11.0.22+7-linux-x64.tar.gz
JDK_FILE='openlogic-openjdk-17.0.10+7-linux-x64'
URL="https://builds.openlogic.com/downloadJDK/openlogic-openjdk/17.0.10+7/${JDK_FILE}.tar.gz"
JDK_ARCHIVE="$JDK_PATH/$JDK_FILE.tar.gz"
wget --no-check-certificate -O "$JDK_ARCHIVE" "$URL"

#OBS set trap for context manage commands at the end of the script -> cleanup
trap 'rm -f $JDK_ARCHIVE' EXIT
# Decompress file to a path
#OBS extract verbose gzip file
tar -C "$JDK_PATH" -xvzf "$JDK_ARCHIVE"
# set JAVA_HOME in .bashrc
echo "export JAVA_HOME=$JDK_PATH/$JDK_FILE/bin" >> "$HOME/.bashrc"

# Create spark directory
SPARK_PATH="$HOME/.local/share/spark"
mkdir -p "$SPARK_PATH"
SPARK_FILE='spark-3.5.1-bin-hadoop3'
SPARK_ARCHIVE="$SPARK_PATH/$SPARK_FILE"

# Download Spark
SPARK_URL="https://downloads.apache.org/spark/spark-3.5.1/spark-3.5.1-bin-hadoop3.tgz"
wget --no-check-certificate -O "$SPARK_ARCHIVE" "$SPARK_URL"
trap 'rm -f $SPARK_ARCHIVE' EXIT
tar -C "$SPARK_PATH" -xvzf "$SPARK_ARCHIVE"

echo "export SPARK_HOME=$SPARK_PATH/$SPARK_FILE" >> "$HOME/.bashrc"
echo "export PATH=$PATH:$SPARK_HOME/bin" >> "$HOME/.basrc"

