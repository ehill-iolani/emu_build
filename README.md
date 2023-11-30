# emu_build
This is a dockerized version of the EMU classifier (https://gitlab.com/treangenlab/emu).
In addition to EMU, this image also contains seqtk (https://github.com/lh3/seqtk) for convenient .fastq to .fasta conversion within containers generated from this image.

## Installation
To build the docker image run the following command:
```
docker build --no-cache -t emu:latest .
```

If you are building on an M1 mac make sure the docker experimental features are enabled and then use the following command:
```
docker buildx build --platform=linux/amd64 -t emu:latest .
```

If you would like to pull the image directly from dockerhub run the following command:
```
docker pull ethill/emu:latest
```

## Usage
To run the docker image run the following command:
```
docker run -it --name=emu --volume=/path/to/your/data:/home/data emu:latest
```