#!/bin/bash
TAG=${1:-1.4.9}
MODEL=${2:-RWKV-4-World-0.1B-v1-20230520-ctx4096.pth}
mkdir -p RWKV-Runner/; cd RWKV-Runner
wget https://github.com/josStorer/RWKV-Runner/archive/refs/tags/v${TAG}.tar.gz
wget https://huggingface.co/BlinkDL/rwkv-4-world/resolve/main/${MODEL}
tar -zxvf v${TAG}.tar.gz
mv RWKV-Runner-${TAG} rwkv-runner

#change service addr
sed -i "s/127.0.0.1/0.0.0.0/g" rwkv-runner/backend-python/main.py

cat > Dockerfile <<EOF
FROM python:3.10.0
EXPOSE 8000

COPY rwkv-runner /rwkv-runner
WORKDIR /rwkv-runner

RUN apt-get update \\
    && apt-get -y install python3.10 python3-dev python3-pip \\
        &&python3 -m pip install torch torchvision torchaudio \\
            && python3 -m pip install -r /rwkv-runner/backend-python/requirements.txt \\
                && mkdir /rwkv-runner/models/ \\
                    && python3 -m pip cache purge
      
COPY ${MODEL} /rwkv-runner/models/ 
    
CMD ["python3", "/rwkv-runner/backend-python/main.py"]
EOF

docker build --network host . -t rwkv-runner:1.0
