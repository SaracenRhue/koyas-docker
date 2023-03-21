FROM nvidia/cuda:12.1.0-base-ubuntu22.04

# Update package repositories and install dependencies
RUN apt update
RUN DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC apt-get -y install tzdata. 
RUN apt install -y sudo wget git python3 python3-pip python3-venv mesa-libGL
# Add a new user
RUN useradd -ms /bin/bash user && \
    echo "user:password" | chpasswd&& \
    echo "user ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

RUN mkdir /home/user/kohya_ss && \
    chown -R user:user /home/user/kohya_ss && \
    chmod -R +rwx /home/user/kohya_ss

USER user
WORKDIR /home/user/
#COPY setup.sh ./

VOLUME /home/user/kohya_ss/


# Expose port 7860
ENV PORT=7860
EXPOSE 7860

CMD cd kohya_ss && bash bash ubuntu_setup.sh && .\venv\Scripts\activate && .\tools\cudann_1.8_install.py && python lora_gui.py
