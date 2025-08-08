#!/bin/bash
mkdir -p /opt/fuseki/lib
cd /opt/fuseki/lib

wget https://repo1.maven.org/maven2/org/apache/jena/jena-text/5.5.0/jena-text-5.5.0.jar
wget https://repo1.maven.org/maven2/org/apache/lucene/lucene-core/8.11.4/lucene-core-8.11.4.jar
wget https://repo1.maven.org/maven2/org/apache/lucene/lucene-analyzers-common/8.11.4/lucene-analyzers-common-8.11.4.jar