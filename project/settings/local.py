import sys

from common import *
from . import secret

DEBUG = True
TEMPLATE_DEBUG = DEBUG

ALLOWED_HOSTS = '*'

SECRET_KEY = secret('SECRET_KEY')

if 'test' in sys.argv:
    DATABASES = {
        'default': {
            'ENGINE': 'django.db.backends.sqlite3',
        }
    }
else:
    DATABASES = {
        'default': {
            'ENGINE': 'django.db.backends.postgresql_psycopg2',
            'NAME': secret('DB_NAME'),
            'USER': secret('DB_USER'),
            'PASSWORD': secret('DB_PASS'),
            'HOST': '127.0.0.1',
            'PORT': '5432',
        }
    }
