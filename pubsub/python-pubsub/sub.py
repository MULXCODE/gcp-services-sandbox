# Copyright 2019 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the 'License');
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an 'AS IS' BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

import time
import datetime
import json

from google.cloud import pubsub_v1
from file_writer import file_writer

# https://cloud.google.com/pubsub/docs/pull#pubsub-pull-messages-async-python
project_id = "forseti-security-new"
subscription_name = "pubsub-sub"

subscriber = pubsub_v1.SubscriberClient()
# The `subscription_path` method creates a fully qualified identifier
# in the form `projects/{project_id}/subscriptions/{subscription_name}`
subscription_path = subscriber.subscription_path(
    project_id, subscription_name)

# callback to process the message
# Message {
#   data: '{ "sender": "entry-point" }'
#   attributes: {}
# }
def callback(message):
    print('Received message: {}'.format(message))
    message.ack()
    fw = file_writer()
    js = json.loads('{}'.format(message.data))
    print(js["sender"])

    ts = time.time()
    st = datetime.datetime.fromtimestamp(ts).strftime('%Y-%m-%d %H:%M:%S')

    fw.write(js["sender"] + "," + st)

subscriber.subscribe(subscription_path, callback=callback)

# The subscriber is non-blocking. We must keep the main thread from
# exiting to allow it to process messages asynchronously in the background.
print('Listening for messages on {}'.format(subscription_path))
while True:
    time.sleep(60)