# huawei_lte_exporter

A promethus exporter for the Huawei series of 4G LTE routers, exporting various LTE signal strength measures e.g. rssi, snr etc ...  It should be compatible with a range of Huawei routers including B310, B315, B525 and B535.  A full range is listed at [huawei-lte-api](https://pypi.org/project/huawei-lte-api/).

## Example

![Grafana Dashboard Screenshot](/examples/screenshot.png "Grafana Dashboard Screenshot")

## Install

Follow the usual docker build and run flow.

Required environment variables:
* ROUTER_ADDRESS - IP address of the Huawei router on your network (typically '192.168.8.1')
* ROUTER_USER - Username to login to the router (typically 'admin')
* ROUTER_PASS - Password to login to the router (typically 'admin')
* PROM_PORT - Port to start the exporter on in the container

```
docker build -t huawei_lte_exporter .

export ROUTER_ADDRESS=192.168.8.1
export ROUTER_USER=admin
export ROUTER_PASS=admin
export PROM_PORT=8080

docker run -d -it -p $PROM_PORT:$PROM_PORT -e ROUTER_ADDRESS=$ROUTER_ADDRESS -e ROUTER_USER=$ROUTER_USER -e ROUTER_PASS=$ROUTER_PASS -e PROM_PORT=$PROM_PORT --name=hle huawei_lte_exporter
sleep 5
curl http://localhost:$PROM_PORT

HELP band The signal band the LTE connection is using
TYPE band gauge
band{deviceName="B535-232",iccid="111"} 1
HELP rsrp The average power received from a single Reference signal, and Its typical range is around -44dbm (good) to -140dbm(bad)
TYPE rsrp gauge
rsrp{deviceName="B535-232",iccid="111",band="3"} -98
HELP rsrq Indicates quality of the received signal, and its range is typically -19.5dB(bad) to -3dB (good)
TYPE rsrq gauge
rsrq{deviceName="B535-232",iccid="111",band="3"} -10.0
HELP rssi Represents the entire received power including the wanted power from the serving cell as well as all co-channel power and other sources of noise in dBm
TYPE rssi gauge
rssi{deviceName="B535-232",iccid="111",band="3"} -71
HELP sinr The signal-to-noise ratio of the given signal in dB
TYPE sinr gauge
rsrq{deviceName="B535-232",iccid="111",band="3"} 11
```

## Configure

### Prometheus

```
  - job_name: '4g'
    scrape_interval: 1m
    static_configs:
    - targets:
      - wopr.home:9910
```

### Grafana

Example dashboard [config](/examples/grafana.json)

Guage values taken from: https://wiki.teltonika-networks.com/view/Mobile_Signal_Strength_Recommendations

## Todo

