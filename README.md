# emu_build
dockerfile for building the emu classifier.

That is all :)

```
docker build --no-cache -t emu:latest .
docker exec -it emu bash
```

If you are building on an M1 mac make sure the docker experimental features are enabled and then use the following command:
```
docker buildx build --platform=linux/amd64 -t emu:latest .
```
