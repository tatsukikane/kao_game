import json
from google.cloud import firestore

def get_insert(data,context):
    db = firestore.Client()

    docs = db.collection('rank').order_by(
    'total', direction=firestore.Query.DESCENDING).get()
    rank_list = []
    for doc in docs:
        rank_list.append(doc.to_dict())
    print(rank_list)
    print(rank_list[0]['total'])
    len_rl = len(rank_list) 

    for i in range(len_rl):
        d= {
            'total':'{}'.format(rank_list[i]['total']),
            'imgurl':'{}'.format(rank_list[i]['imgurl'])
        }
        doc_ref = db.collection('ranksort').document('{}'.format(i))
        doc_ref.set(d)

    # return_json = json.dumps(rank_list, ensure_ascii=False)
    # int_json = eval(return_json)
    # d = sorted(int_json, key=lambda x: x["total"],reverse=True)
    # rd = {"rank": d}

    # doc_ref = db.collection('ranksort')
    # doc_ref.add(d)
    return '成功'