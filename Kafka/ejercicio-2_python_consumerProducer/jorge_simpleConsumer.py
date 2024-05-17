#!/usr/bin/env python


import json

from kafka import KafkaConsumer

consumer = KafkaConsumer('simple-topic',
                         group_id='Jorge-group',
                         bootstrap_servers=['3.255.126.123:9092'],
                         auto_offset_reset='earliest')

consumer.subscribe(['simple-topic'])

for message in consumer:
  # message value and key are raw bytes -- decode if necessary!
  # e.g., for unicode: `message.value.decode('utf-8')`
  print("%s:%d:%d: key=%s value=%s" % (message.topic, message.partition,
                                       message.offset,
                                       message.key.decode('utf-8'),
                                       message.value.decode('utf8')))
