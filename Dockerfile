FROM arm64v8/ubuntu:22.04
WORKDIR /root/

RUN apt -y update \
&& apt -y upgrade \
&& apt -y install build-essential \
&& apt -y install gfortran \
&& apt -y install wget

# download latest wgrib2
RUN wget https://www.ftp.cpc.ncep.noaa.gov/wd51we/wgrib2/wgrib2.tgz.v3.1.1 \
&& tar xvfz wgrib2.tgz.v3.1.1

# edit makefile
RUN cd grib2/ \
&& sed -i -e "s/#export CC=gcc/export CC=gcc/g" makefile \
&& sed -i -e "s/#export FC=gfortran/export FC=gfortran/g" makefile \
&& sed -i -e "860 s/.\/configure/.\/configure --build=arm/g" makefile \
&& sed -i -e "936 s/.\/configure/.\/configure --build=arm/g" makefile

# build
RUN cd grib2/ \
&& make


FROM arm64v8/ubuntu:22.04
WORKDIR /root/
RUN apt -y update \
&& apt -y upgrade \
&& apt -y install gfortran

COPY --from=0 /root/grib2/wgrib2/wgrib2 /usr/local/bin/wgrib2
ENTRYPOINT ["wgrib2"]
