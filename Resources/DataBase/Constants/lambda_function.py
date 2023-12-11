import snowflake.connector as sf
import json
import pandas as pd
import datetime
import boto3
from snowflake.connector.pandas_tools import write_pandas
import base64
import gzip
import re


def lambda_handler(event, context):
    """
    Accepts an action and a number, performs the specified action on the number,
    and returns the result.

    :param event: The event dict that contains the parameters sent when the function
                  is invoked.
    :param context: The context in which the function is called.
    :return: The result of the specified action.
    """
    # print('starting')
    s3 = boto3.client('s3')
    bucket = event['Records'][0]['s3']['bucket']['name']
    key = event['Records'][0]['s3']['object']['key']

    # #return key

    obj = s3.get_object(Bucket=bucket, Key=key)
    f = obj['Body'].read()
    file_content = gzip.decompress(f)
    file_content = str(file_content)
    regex = r"{\"messageType"
    index = []

    matches = re.finditer(regex, file_content, re.MULTILINE)

    for matchNum, match in enumerate(matches, start=1):

        # print ("Match {matchNum} was found at {start}-{end}: {match}".format(matchNum = matchNum,
        # start = match.start(), end = match.end(), match = match.group()))
        index.append(match.start())
        for groupNum in range(0, len(match.groups())):
            groupNum = groupNum + 1

        # print ("Group {groupNum} found at {start}-{end}: {group}".format(groupNum = groupNum, start = match.start(
        # groupNum), end = match.end(groupNum), group = match.group(groupNum)))
    # print(index)
    json_data = []
    for i in index:
        a = index[index.index(i)]
        try:
            b = index[index.index(i) + 1]
            # print('one index')
            # print(file_content[a:b])
            json_d = eval(file_content[a:b])
            json_data.append(json_d)
        except:
            kl = file_content[a:-1]
            # print('last index')
            # print(kl)
            json_d = eval(kl)
            json_data.append(json_d)

    json_df = pd.DataFrame(json_data)
    json_df.columns = ['MESSAGETYPE', 'OWNER', 'LOGGROUP', 'LOGSTREAM', 'SUBSCRIPTIONFILTERS', 'LOGEVENTS']

    parse_data = []
    for q in range(2, json_df.shape[0]):
        report = json_df.iloc[q]['LOGEVENTS']
        # print('printing q')
        turned_to_dict = eval(str(report))
        #    print(turned_to_dict)
        for w in turned_to_dict:
            data = json_df.iloc[q]
            owner = data[1]
            loggroup = data[2]
            logstream = data[3]
            subscription_filters = str(data[4]).replace(']', '').replace('[', '').replace("'", '')
            # print('i ngot here')
            # print([data,owner,loggroup,logstream,subscription_filters])
            if 'REPORT' in w['message']:
                try:
                    id_ = w['id']
                except:
                    id_ = 'NA'
                try:
                    timestamp = str(datetime.datetime.fromtimestamp(int(str(w['timestamp'])[:10])))
                except:
                    timestamp = 'NA'
                message_type = 'REPORT'
                try:
                    message = w['message'].split(':')  # .split(':')[1].split()[0]
                except:
                    message = 'NA'
                try:
                    billed_duration = float(message[2].replace('Billed Duration', '').split()[0])
                except:
                    billed_duration = 0
                try:
                    memory_size = message[3].replace('Memory Size', '').split()[0]
                except:
                    memory_size = 0
                try:
                    memory_used = message[4].replace('Memory Used', '').split()[0]
                except:
                    memory_used = 0
                try:
                    Init_Duration = message[5].replace('Init Duration', '').split()[0]
                except:
                    Init_Duration = 0
                try:
                    mstn = message[-1]
                except:
                    mstn = 0
                message = ''
                details = [owner, loggroup, logstream, subscription_filters, timestamp, 'START', id_, billed_duration,
                           memory_size, memory_used, Init_Duration, mstn, '']
            # print(details)
            elif 'END' in w['message']:
                id_ = w['id']
                timestamp = str(datetime.datetime.fromtimestamp(int(str(w['timestamp'])[:10])))
                message_type = 'END'
                message = w['message'].split(':')[1].replace('Version', '')
                details = [owner, loggroup, logstream, subscription_filters, timestamp, 'END', id_, 0, 0, 0, 0, 0,
                           message]
            elif 'START' in w['message']:
                id_ = w['id']
                timestamp = str(datetime.datetime.fromtimestamp(int(str(w['timestamp'])[:10])))
                message_type = 'START'
                message = w['message'].split(':')[1].replace('Version', '')
                details = [owner, loggroup, logstream, subscription_filters, timestamp, 'REPORT', id_, 0, 0, 0, 0, 0,
                           message]
            # print(id_,timestamp,message)

            parse_data.append(details)
    # cur.execute(f'''INSERT INTO  TESTT VALUES ('{owner}','{loggroup}','{logstream}','{subscription_filters}',
    # '{timestamp}','{message_type}','{id_}','{billed_duration}','{memory_size}','{memory_used}','{Init_Duration}',
    # '{mstn}','{message}')''' )

    # add your snowflake credentials
    conn = sf.connect(
        user='',
        password='',
        account='',
        database='',
        schema=''
    )

    print("success in connecting")
    # print(parse_data)
    cur = conn.cursor()
    # print('i got here')
    for i in parse_data:
        i = [str(j) for j in i]
        # print(i)
        owner = i[0]
        loggroup = i[1]
        logstream = i[2]
        subscription_filters = i[3]
        timestamp = i[4]
        message_type = i[5]
        idx = i[6]
        billed_duration = i[7]
        memory_size = i[8]
        memory_used = i[9]
        init = i[10]
        mstn = i[11]
        message = i[12]

        query = f"INSERT INTO TESTT VALUES('{owner}','{loggroup}','{logstream}','{subscription_filters}','{timestamp}','{message_type}','{idx}',{billed_duration},{memory_size},{memory_used},{init},'{mstn}','{message}')"
        print(query)
        cur.execute(query)
        # cur.commit()
        # cursor.execute()
        # print('a row has been inserted')
    # this would have been used but pyarrow could not installed due to layer size
    # write_pandas( conn,json_df,'TESTT',database='TEST',schema='PUBLIC')
    print('data has been saved to snowflake')
    cur.close()
    # file = obj['Body'].read()
    # print( file)
    # # f=gzip.open(obj,'rb')

    # file_content=f.read()

    # print(file_content)

    # return obj

    # df = pd.read_csv(obj['Body'], compression='gzip', header=0, sep=' ', quotechar='"', error_bad_lines=False)
    # return df
