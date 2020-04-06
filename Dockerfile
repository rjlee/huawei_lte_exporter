FROM python:3

WORKDIR /usr/src/huwawei_lte_exporter

COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

CMD [ "python", "./huwawei_lte_exporter" ]