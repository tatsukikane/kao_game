import json
from google.cloud import firestore

def get_result(data,context): 
    db = firestore.Client() #データベース接続

    #rankresultテーブルの既存データ削除
    doc_d = db.collection('rankresult').get() 
    doc_list = []
    for doc in doc_d:
        doc_list.append(doc.id) #各id名取得して加える
    print(doc_list)
    len_d = len(doc_list)

    for i in range(len_d):
        deld = doc_list[i]
        print(deld)
        doc_del = db.collection('rankresult').document('{}'.format(deld)) #ドキュメントidを一つずつ照らし合わせて削除
        doc_del.delete()

    #rankwithcountのデータ取得
    docs = db.collection('rankwithcount').get()
    rwc_list = []
    for doc in docs:
        rwc_list.append(doc.to_dict())
    # print(uid_list)
    len_rl = len(rwc_list) 
    # print(len_rl)
    
    # result_list = []
    #取得したデータrwc_listから一つずつ値を取得して辞書化
    for i in range(len_rl):
        count = rwc_list[i]['count']
        uid = rwc_list[i]['uid']
        cloudurl = rwc_list[i]['cloudurl']
        imgurl = rwc_list[i]['imgurl']
        total = int(rwc_list[i]['total'])
        profurl = rwc_list[i]['profurl']
        name = rwc_list[i]['name']
        finaltotal = int(total) + int(count)
        d = {
            "count":"{}".format(count),
            "uid":"{}".format(uid),
            "cloudurl":"{}".format(cloudurl),
            "imgurl":"{}".format(imgurl),
            "total":total, #int型で入れる
            "profurl":"{}".format(profurl),
            "name":"{}".format(name),
            "finaltotal":finaltotal #int型。int型じゃないと並び替えで大きい順番にならない

        }
        doc_ref = db.collection('rankresult').document('{}'.format(i))
        doc_ref.set(d)
 

    return '成功'