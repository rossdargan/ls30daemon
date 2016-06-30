FROM perl:latest

MAINTAINER Ross Dargan dockermaintainer@the-dargans.co.uk

ENV ALARMADDRESS=192.168.1.30:23

EXPOSE 1681

# RUN curl -L http://cpanmin.us | perl - App::cpanminus

COPY ./LS30 /var/LS30/

WORKDIR /var/LS30/

ENV PERLLIB $PERLLIB:/var/LS30/lib

RUN cpanm Date::Format AnyEvent

#RUN groupadd -r alarmuser && useradd -r -g alarmuser alarmuser

#USER  alarmuser

ENTRYPOINT ["bin/alarm-daemon.pl"]

CMD ["-h", $ALARMADDRESS, "0.0.0.0:1681"]


