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

my_pass = 'Hashi123'
my_path = 'hvac/my-secret-password'

# Writing a secret
try:
    create = client.secrets.kv.v2.create_or_update_secret(
        path=my_path,
        #path='hvac',
        secret = dict(password=my_pass)
    )
    print('Secret written successfully.')

except Exception as e:
    logging.error(traceback.format_exc())
    print('Secret written error.')


# Reading a secret
read = client.secrets.kv.read_secret_version(path=my_path)
password = read['data']['data']['password']

if password != my_pass:
    sys.exit('unexpected password')
else:
    print('Access granted!')

# Listing
list_response = client.secrets.kv.v2.list_secrets(
    path='hvac/',
)
print('The following paths are available under "hvac" prefix: {keys}'.format(
    keys=','.join(list_response['data']['keys']),
))
