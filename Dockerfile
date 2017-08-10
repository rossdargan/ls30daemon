FROM perl:latest

MAINTAINER Ross Dargan dockermaintainer@the-dargans.co.uk

#ENV ALARMADDRESS=192.168.1.30:23

EXPOSE 1681

# RUN curl -L http://cpanmin.us | perl - App::cpanminus

WORKDIR /var/

RUN git clone https://github.com/nickandrew/LS30.git

WORKDIR /var/LS30

ENV PERLLIB $PERLLIB:/var/LS30/lib

ENV LS30_SERVER=127.0.0.1:1681

RUN cpanm Date::Format AnyEvent

#RUN groupadd -r alarmuser && useradd -r -g alarmuser alarmuser

#USER  alarmuser

ENTRYPOINT ["bin/alarm-daemon.pl"]

CMD ["-h", "192.168.86.30:23", "0.0.0.0:1681"]

HEALTHCHECK CMD ./bin/dt.pl  | grep date/time || exit 1
