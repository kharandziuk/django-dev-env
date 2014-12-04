import os, sys
from unipath import Path

def _get_secret():
    try:
        import _secrets as s
    except ImportError:
        print "You does not have `_secrets.py` file."
        sys.exit(1)
    def secret(attribute):
        if hasattr(s, attribute):
            return getattr(s, attribute)
        else:
            msg = "Your _secrets.py file does not have `{}` attribute."
            print msg.format(attribute)
            sys.exit(1)
    return secret

secret = _get_secret()

