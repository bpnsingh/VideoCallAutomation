import random
import string
import time
import csv
from datetime import datetime, timedelta
import os
from twilio.rest import Client
import  requests
import json




def randomString(stringLength=10):
    """Generate a random string of fixed length """
    letters = string.ascii_lowercase
    return ''.join(random.choice(letters) for i in range(stringLength))

def get_current_time():
    t = time.localtime()
    current_time = time.strftime("%H:%M:%S", t)
    return current_time

def get_current_time2():
    current_time2 = datetime.now().strftime("%H:%M:%S.%f")
    return current_time2[:-3]

def parse_pin(pin):
    #pin = int(pin)
    lista=[]
    #while pin > 0:
    #    temp = pin % 10
    #    lista.append(temp)
    #    pin= pin // 10
    for each in pin:
        lista.append(each)
    return lista

def append_to_csv(file_name,input_list):
    with open(file_name,'a') as fh:
        csv_file=csv.writer(fh,delimiter=',',quotechar='"', quoting=csv.QUOTE_MINIMAL)
        csv_file.writerow(input_list)

def get_schedule_time(device_time : string ,delta=9):
    future_time= datetime.fromisoformat(device_time) + timedelta(minutes=delta)
    gcal_format_schedule_start = future_time.strftime("%-I:%M %p")
    conf_end_time =  future_time + timedelta(minutes=15)
    gcal_format_schedule_end = conf_end_time.strftime("%-I:%M %p")
    time_list=[future_time.strftime("%-I"),future_time.strftime("%M"),future_time.strftime("%p"),gcal_format_schedule_start,gcal_format_schedule_end]
    return time_list

def get_recurring_date(delta=7):
    future_day= datetime.now()+timedelta(days=7)
    return future_day.strftime("%a, %b %-d")

def get_date():
    current_day= datetime.now()
    return current_day.strftime("%m/%d/%Y")

def get_date2():
    current_day= datetime.now()
    return current_day.strftime("%b %-d, %Y")

def get_gcal_date():
    current_day = datetime.now()
    return  current_day.strftime("%a, %b %-d, %Y")

def dot_append(text):
    lista=[]
    for c in text.lower():
        lista.append(c+'.')
    return  ''.join(lista)

def strip_list(list_name):
    temp = []
    for text in list_name:
        striped_text=text.strip()
        temp.append(striped_text)
    return   temp

def twilio_call(callee,caller='+14156826556',type=call_and_pause):
    client = Client(account_sid, auth_token)
    call = client.calls.create(
                        twiml=type,
                        to=callee,
                        from_=caller
                        )
    return call.sid

def twilio_dialin_with_pin(callee,pin):
    client = Client(account_sid, auth_token)
    pin_format = 'wwwwwwww{0}'.format(pin)
    call = client.calls.create(
        twiml=call_and_pause,
        from_=+14156826559,
        to=callee,
        send_digits= pin_format
    )
    time.sleep(10)
    return call.sid




def end_twilio_call(call_sid):
    client = Client(account_sid, auth_token)
    call = client.calls(call_sid).update(status='completed')

def twilio_call_status(call_sid):
    client = Client(account_sid, auth_token)
    call = client.calls(call_sid).fetch()
    return call.status

def twilio_incoming_call_sid(callee):
    client = Client(account_sid, auth_token)
    calls = client.calls.list(to=callee, limit=1)
    return calls[0].sid

def twilio_incoming_caller_id(callee):
    client = Client(account_sid, auth_token)
    caller_id = client.calls.list(to=callee, limit=1)
    return caller_id[0].from_

def twilio_send_dtmf(call_sid, dtmf):
    client = Client(account_sid, auth_token)
    client.calls(call_sid).update(twiml=dtmf)




