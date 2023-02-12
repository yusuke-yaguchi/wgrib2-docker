build
```
docker build -t wgrib2:latest .
```

usage
```
docker run -v $(pwd):/root/ wgrib2:latest -version
docker run -v $(pwd):/root/ wgrib2:latest xxx.grib2 -csv-
```