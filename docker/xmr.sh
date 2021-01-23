#! /bin/sh
# author: tcbaby

cat > /etc/xmrig/config.json << eof
{
    "api": {
        "id": null,
        "worker-id": null
    },
    "http": {
        "enabled": false,
        "host": "127.0.0.1",
        "port": 0,
        "access-token": null,
        "restricted": true
    },
    "autosave": true,
    "background": false,
    "colors": true,
    "randomx": {
        "init": -1,
        "mode": "auto",
        "1gb-pages": false,
        "rdmsr": true,
        "wrmsr": true,
        "numa": true
    },
    "cpu": {
        "enabled": true,
        "huge-pages": true,
        "hw-aes": null,
        "priority": null,
        "memory-pool": false,
        "yield": true,
        "asm": true,
        "argon2-impl": null,
        "astrobwt-max-size": 550,
        "astrobwt-avx2": false,
        "argon2": [0],
        "astrobwt": [-1],
        "cn": [
            [1, 0]
        ],
        "cn-heavy": [
            [1, 0]
        ],
        "cn-lite": [
            [1, 0]
        ],
        "cn-pico": [
            [2, 0]
        ],
        "cn/gpu": [0],
        "defyx": [0],
        "rx": [0],
        "rx/wow": [0],
        "cn/0": false,
        "cn-lite/0": false,
        "rx/arq": "rx/wow",
        "rx/keva": "rx/wow"
    },
    "opencl": {
        "enabled": false,
        "cache": true,
        "loader": null,
        "platform": "AMD",
        "adl": true,
        "cn/0": false,
        "cn-lite/0": false
    },
    "cuda": {
        "enabled": false,
        "loader": null,
        "nvml": true,
        "cn/0": false,
        "cn-lite/0": false
    },
    "donate-level": 0,
    "donate-over-proxy": 0,
    "log-file": null,
    "pools": [
        {
            "algo": null,
            "coin": null,
            "url": "pool.supportxmr.com:3333",
            "user": "48grhft7eZG1CuMPooph6wamVcaHmTnkFWHHsRZhR3Jj11hEVRFVAVM3iDaTYGjBc7XNVA3VBR1v5fgjR83kepzDNLZhvTG",
            "pass": "tcbaby:cbtan@foxmail.com",
            "rig-id": null,
            "nicehash": false,
            "keepalive": false,
            "enabled": true,
            "tls": false,
            "tls-fingerprint": null,
            "daemon": false,
            "socks5": null,
            "self-select": null
        }
    ],
    "print-time": 60,
    "health-print-time": 60,
    "retries": 5,
    "retry-pause": 5,
    "syslog": false,
    "tls": {
        "enabled": false,
        "protocols": null,
        "cert": null,
        "cert_key": null,
        "ciphers": null,
        "ciphersuites": null,
        "dhparam": null
    },
    "user-agent": null,
    "verbose": 0,
    "watch": true,
    "algo-perf": {
        "cn/1": 25.6915225982666,
        "cn/2": 25.6915225982666,
        "cn/r": 25.6915225982666,
        "cn/fast": 51.3830451965332,
        "cn/half": 51.3830451965332,
        "cn/xao": 25.6915225982666,
        "cn/rto": 25.6915225982666,
        "cn/rwz": 34.25536346435547,
        "cn/zls": 34.25536346435547,
        "cn/double": 12.8457612991333,
        "cn/gpu": 4.583151340484619,
        "cn-lite/1": 106.77965545654297,
        "cn-heavy/0": 15.76132869720459,
        "cn-heavy/tube": 15.76132869720459,
        "cn-heavy/xhv": 15.76132869720459,
        "cn-pico": 664.0343627929688,
        "cn-pico/tlo": 0.0,
        "rx/0": 29.111793518066408,
        "rx/wow": 28.908554077148439,
        "rx/loki": 29.111793518066408,
        "defyx": 173.2707977294922,
        "rx/arq": 108.12157440185547,
        "rx/sfx": 0.0,
        "rx/keva": 0.0,
        "argon2/chukwa": 2026.4814453125,
        "argon2/wrkz": 0.0,
        "astrobwt": 32.53560256958008
    },
    "rebench-algo": false,
    "bench-algo-time": 10
}
eof

docker pull snowdream/xmr
docker -d run --name xmr --restart=always --network host \ 
    -v /etc/xmrig/config.json:/etc/xmrig/config.json -e CPU_USAGE=95  snowdream/xmr
