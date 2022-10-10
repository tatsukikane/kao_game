import json
from google.cloud import firestore

def get_insert(data,context):
    db = firestore.Client()

    doc_d = db.collection('ranksort').get()
    doc_list = []
    for doc in doc_d:
        doc_list.append(doc.id)
    print(doc_list)
    len_d = len(doc_list)

    for i in range(len_d):
        deld = doc_list[i]
        print(deld)
        doc_del = db.collection('ranksort').document('{}'.format(deld))
        doc_del.delete()

    docs = db.collection('rankresult').order_by(
    'finaltotal', direction=firestore.Query.DESCENDING).get()
    rank_list = []
    for doc in docs:
        rank_list.append(doc.to_dict())
    print(rank_list)
    print(rank_list[0]['total'])
    len_rl = len(rank_list) 

    for i in range(len_rl):
        d= {
            'finaltotal':rank_list[i]['finaltotal'],
            'imgurl':'{}'.format(rank_list[i]['imgurl']),
            'uid':'{}'.format(rank_list[i]['uid']),
            'name':'{}'.format(rank_list[i]['name']),
            'profurl':'{}'.format(rank_list[i]['profurl']),
            'rank':i

        }
        doc_ref = db.collection('ranksort').document("{}".format(i))
        doc_ref.set(d)

    # return_json = json.dumps(rank_list, ensure_ascii=False)
    # int_json = eval(return_json)
    # d = sorted(int_json, key=lambda x: x["total"],reverse=True)
    # rd = {"rank": d}

    # doc_ref = db.collection('ranksort')
    # doc_ref.add(d)
    return '成功'