FROM loopbackkr/pytorch:1.11.0-cuda11.3-cudnn8

WORKDIR /workspace

ARG USERNAME=user
ARG USER_UID=1000
ARG USER_GID=$USER_UID

# Create the user
RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
    #
    # [Optional] Add sudo support. Omit if you don't need to install software after connecting.
    && apt update \
    && apt install -y sudo \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

RUN apt update &&\
    apt install -y\
        wget\
        libgl1-mesa-glx\
        libglib2.0-0

COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt
