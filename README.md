# Install Apche Jena Fuseki
Version is 5.5.0

To install this version Java 17 is required.

## Install Java 17
```console
sudo apt update
sudo apt install openjdk-17-jdk -y
```

## Install Apache Jena Fuseki
### Download the archive
```console
cd /opt
sudo wget https://dlcdn.apache.org/jena/binaries/apache-jena-fuseki-5.5.0.tar.gz
```

### Extract the archive
```console
sudo tar -xvzf apache-jena-fuseki-5.5.0.tar.gz
sudo mv apache-jena-fuseki-5.5.0 fuseki
sudo chown -R $USER:$USER fuseki
```

### Enable lucene
We need to download some libraries. 
The following script downlaod the required JAR's file and copy into the lib folder of Fuseki:

```console
chmod +x get-lucene.sh
./get-lucene.sh
```

### Create and configure an empty persitent store
```console
mkdir -p /opt/fuseki/configuration
mkdir -p /opt/fuseki/datasets/oac
```

```console
nano /opt/fuseki/configuration/oac.ttl
```

```
PREFIX :        <#>
PREFIX fuseki:  <http://jena.apache.org/fuseki#>
PREFIX rdf:     <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX rdfs:    <http://www.w3.org/2000/01/rdf-schema#>
PREFIX ja:      <http://jena.hpl.hp.com/2005/11/Assembler#>
PREFIX tdb2:    <http://jena.apache.org/2016/tdb#>
PREFIX text:    <http://jena.apache.org/text#>

[] rdf:type fuseki:Server ;
   fuseki:services (
     :service
   ) .

:service rdf:type fuseki:Service ;
    fuseki:name "oac" ;
    fuseki:serviceQuery "sparql" ;
    fuseki:serviceUpdate "update" ;
    fuseki:serviceUpload "upload" ;
    fuseki:serviceReadGraphStore "get" ;
    fuseki:serviceReadWriteGraphStore "data" ;
    fuseki:dataset :dataset_text ;
    .

:dataset_text rdf:type text:TextDataset ;
    text:dataset   :dataset_tdb2 ;
    text:index     :indexLucene .

:dataset_tdb2 rdf:type  tdb2:DatasetTDB ;
    tdb2:location "/opt/fuseki/datasets/oac" ;
    .

:indexLucene a text:TextIndexLucene ;
    text:directory "Lucene" ;
    text:entityMap :entMap ;
    text:storeValues true ;
    text:langField "lang" ;
    text:analyzer [ a text:StandardAnalyzer ] .

:entMap a text:EntityMap ;
    text:entityField      "uri" ;
    text:defaultField     "text" ;
    text:langField        "lang" ;
    text:map (
        [ text:field "text" ; text:predicate rdfs:label ]
    ) .
```

```console
sudo chown -R $USER:$USER /opt/fuseki/datasets/oac
```

## Start the server

### Manually
```console
./fuseki-server --config /opt/fuseki/configuration/oac.ttl --port 3333
```

### Automatically
Using systemd, update the file /etc/systemd/system/fuseki.service to include the following line:
```
ExecStart=/opt/fuseki/fuseki-server --config /opt/fuseki/configuration/oac.ttl --port 3333
```

```console
sudo systemctl daemon-reload
sudo systemctl restart fuseki
```
