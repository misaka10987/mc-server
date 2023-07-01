#!/bin/bash
source ./config.sh
./java/8/bin/java -Xmx${memory}M -jar ./forge-1.12.2/server.jar
