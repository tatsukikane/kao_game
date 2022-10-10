import json
import random
from google.cloud import firestore

def random_topic(data,context):
    db = firestore.Client()

    doc_d = db.collection('todaytopic').get()
    doc_list = []
    for doc in doc_d:
        doc_list.append(doc.id)
    print(doc_list)
    len_d = len(doc_list)

    for i in range(len_d):
        deld = doc_list[i]
        print(deld)
        doc_del = db.collection('todaytopic').document('{}'.format(deld))
        doc_del.delete()


    doc_d = db.collection('alltopic').get()
    # ここまでテンプレ
    doc_list=[]
    for doc in doc_d:
        doc_list.append(doc.to_dict())
        print(doc_list)
        # alltopicを配列化して取れた？
    today_topic = random.choice(doc_list)
    print(today_topic)
    len_tt = len(today_topic)
    #today_topicを配列化しないといけない？

    doc_ref.add(today_topic)
    return '成功'