
容器化生成式AI会话应用：

RWKV-Runner是一个0.1b的大模型并提供RESTFul API对外提供在线推理服务，
ChatGPT-Next-Web是会话应用的webui。
RWKV-Runner与ChatGPT-Next-Web形成前后端分离架构的生成式AI会话应用，通过容器镜像部署到k8s集群中。

RWKV-Runner：https://github.com/josStorer/RWKV-Runner

ChatGPT-Next-Web：https://github.com/Yidadaa/ChatGPT-Next-Web

模型：

RWKV-4-World: https://huggingface.co/BlinkDL/rwkv-4-world/tree/main

RWKV-4-Raven: https://huggingface.co/BlinkDL/rwkv-4-raven/tree/main

ChatRWKV: https://github.com/BlinkDL/ChatRWKV

RWKV-LM: https://github.com/BlinkDL/RWKV-LM

RWKV-LM-LoRA: https://github.com/Blealtan/RWKV-LM-LoRA

MIDI-LLM-tokenizer: https://github.com/briansemrau/MIDI-LLM-tokenizer


1 生成docker镜像

1.1 准备一台有docker运行时的节点，联网

1.2 上传, 运行脚本

1.3 修改镜像tag，推送镜像到镜像仓库

2 应用部署

2.1 创建K8S集群（云上购买、自主搭建）

2.2 yaml部署RWKV-Runner、ChatGPT-Next-Web

2.3 RWKV-Runner容器内挂载模型文件

2.4 创建一个任务（Job），切换RWKV-Runner应用模型

3 访问ChatGPT-Next-Web的service地址测试应用

