#!/usr/bin/env python

import hvac
import sys
import os
import traceback
import logging

# Authentication
client = hvac.Client(
    url = os.environ['VAULT_ADDR'],
    token = os.environ["VAULT_TOKEN"]
)

# Listing
list_response = client.secrets.kv.v2.list_secrets(
    path='hvac',
    #path='kv/hvac',
)
print('The following paths are available under "hvac" prefix: {keys}'.format(
    keys=','.join(list_response['data']['keys']),
))
