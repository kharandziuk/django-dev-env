import sys

from common import *
from . import secret

DEBUG = True
TEMPLATE_DEBUG = True

ALLOWED_HOSTS = ('multiad.dev.djangostars.com',)

SECRET_KEY = secret('SECRET_KEY')

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql_psycopg2',
        'NAME': secret('DB_NAME'),
        'USER': secret('DB_USER'),
        'PASSWORD': secret('DB_PASS'),
    }
}
REST_FRAMEWORK['DEFAULT_AUTHENTICATION_CLASSES'] = ()
