#!/bin/bash
mkdir -p rwkv-switch-model; cd rwkv-switch-model

cat > rwkv-switch-model.sh << "EOF"
#!/bin/bash

check_success() {
  status_code=$(
    curl -m 5 -s -o /dev/null -w %{http_code} http://rwkv-runner-svc/switch-model -X POST -H "Content-Type: application/json" -d '{"model":"/rwkv-runner-svc/models/'${MODEL_NAME}'","strategy":"cpu fp32"}'
  )
}
check_success 
echo "time：`date '+%Y%m%d %H:%M:%S'`--$status_code"
while [ $status_code -ne 200 ]
do
  sleep 5s
  check_success
  echo "time：`date '+%Y%m%d %H:%M:%S'`--$status_code"
done

EOF


cat > Dockerfile <<EOF
FROM quay.io/curl/curl:latest

COPY  rwkv-switch-model.sh /

CMD ["sh", "/rwkv-switch-model.sh"]
EOF

docker build --network host . -t rwkv-switch-model:1.0
