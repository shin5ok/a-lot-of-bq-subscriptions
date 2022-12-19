#!/usr/bin/env python

import os
import sys
import json
import time
import signal
from datetime import datetime
import uuid

project_id = os.environ.get("GOOGLE_CLOUD_PROJECT")
topic_id = os.environ.get("TOPIC_ID")
app_id = os.environ.get("APP_ID", topic_id)
sleep = os.environ.get("SLEEP", "1")
upto = os.environ.get("UPTO", "10")
extrastr = os.environ.get("EXTRASTR")

n: int = 0

def handler(sig, frame):
    print(f"###########[{app_id}] received signal: {sig}, total published message: {n}")
    time.sleep(1)
    sys.exit(0)


signal.signal(signal.SIGTERM, handler)
signal.signal(signal.SIGINT, handler)

def publish_messages(project_id: str, topic_id: str) -> None:
    """Publishes multiple messages to a Pub/Sub topic."""
    from google.cloud import pubsub_v1

    publisher = pubsub_v1.PublisherClient()
    # The `topic_path` method creates a fully qualified identifier
    # in the form `projects/{project_id}/topics/{topic_id}`
    topic_path = publisher.topic_path(project_id, topic_id)

    global n
    # while True:
    for n in range(1, int(upto)):
        # data_str = f"Message number {n}"
        # data = data_str.encode("utf-8")

        data = dict(
            id=str(uuid.uuid4()),
            name="foo" ,
            extrabool=True,
            timestamp=datetime.now().strftime("%Y-%m-%dT%H:%M:%S")
        )

        if extrastr:
            data['extrastr'] = "Extra String"

        senddata = json.dumps(data).encode("utf-8")
        print(senddata)
        future = publisher.publish(topic_path, senddata)
        print(future.result())
        n += 1
        time.sleep(float(sleep))

    print(f"Published messages to {topic_path}. Total count was {n}.")

if __name__ == "__main__":
    publish_messages(project_id, topic_id)

    sys.exit(0)
