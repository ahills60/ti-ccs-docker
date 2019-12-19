FROM ubuntu:18.04

RUN ln -fs /usr/share/zoneinfo/Europe/London /etc/localtime
RUN sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
    apt update && \
    apt -y upgrade && \
    apt install -y apt-utils && \
    apt install -y autoconf libtool build-essential libc6-i386 libusb-0.1-4 libgconf-2-4 && \
    apt install -y software-properties-common python2.7 libpython2.7 && \
    apt install -y byobu curl git git-lfs htop man unzip vim wget
RUN mkdir /root/Downloads
RUN curl http://software-dl.ti.com/ccs/esd/CCSv9/CCS_9_2_0/exports/CCS9.2.0.00013_linux-x64.tar.gz --output /root/Downloads/CCS9.2.0.00013_linux-x64.tar.gz --silent && \
    tar xzf /root/Downloads/CCS9.2.0.00013_linux-x64.tar.gz --directory /root/Downloads/
RUN chmod +x /root/Downloads/CCS9.2.0.00013_linux-x64/ccs_setup_9.2.0.00013.bin && \
    /root/Downloads/CCS9.2.0.00013_linux-x64/ccs_setup_9.2.0.00013.bin --mode unattended --enable-components PF_MSP432,PF_CC2X --prefix /opt/ti/ccs920
RUN curl http://software-dl.ti.com/simplelink/esd/simplelink_msp432_sdk/2.40.00.10/simplelink_msp432p4_sdk_2_40_00_10.run --output /root/Downloads/simplelink_msp432p4_sdk_2_40_00_10.run --silent && \
    chmod +x /root/Downloads/simplelink_msp432p4_sdk_2_40_00_10.run
RUN /root/Downloads/simplelink_msp432p4_sdk_2_40_00_10.run --mode unattended --prefix /opt/ti/
RUN mkdir -p /home/build/workspace && \
    /opt/ti/ccs920/ccs/eclipse/eclipse -noSplash -data /home/build/workspace -application com.ti.common.core.initialize -rtsc.productDiscoverPath "/opt/ti/simplelink_msp432p4_sdk_2_40_00_10/;/opt/ti/xdctools_3_51_01_18_core/"
CMD ["/bin/bash"]
