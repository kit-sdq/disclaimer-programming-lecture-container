FROM ubuntu:latest

RUN apt-get update && apt-get install -y locales && rm -rf /var/lib/apt/lists/* \
    && localedef -i de_DE -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
ENV LANG de_DE.utf8
RUN apt-get update && apt-get install -y openjdk-11-jdk-headless maven git
RUN git clone https://github.com/kit-sdq/disclaimer-programming-lecture-generation.git
RUN cd disclaimer-programming-lecture-generation && mvn verify 


EXPOSE 8080/tcp

ENTRYPOINT java -jar disclaimer-programming-lecture-generation/target/disclaimer.generation-0.0.1-SNAPSHOT.jar