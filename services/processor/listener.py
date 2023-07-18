import sys

sys.path.insert(0, 'processor')

from processor import app


def listener(event, context):
    app.processor(event, None)
    print("HI")
    return {"statusCode": 200}

def health(val):
    return val