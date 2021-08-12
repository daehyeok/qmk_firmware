FROM qmkfm/base_container

VOLUME /qmk_firmware
WORKDIR /qmk_firmware

RUN wget http://packs.download.atmel.com/Atmel.ATmega_DFP.1.7.374.atpack -O atmega.zip
RUN unzip -j -d /usr/lib/avr/lib/avr5/ atmega.zip  \
    gcc/dev/atmega328pb/avr5/crtatmega328pb.o  \
    gcc/dev/atmega328pb/avr5/libatmega328pb.a
RUN unzip -j -d /usr/lib/avr/include/avr/ atmega.zip include/avr/iom328pb.h

COPY . .
# COPY *.patch .
RUN  patch /usr/lib/avr/include/avr/io.h io.h.patch
RUN  patch /usr/lib/avr/include/avr/power.h power.h.patch

#CMD make all:default
