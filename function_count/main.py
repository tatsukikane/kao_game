import json
import datetime
from google.cloud import firestore

def get_count(data,context):
    db = firestore.Client() #firestore接続

    docids = db.collection('rankwithcount').get() #imagsからのデータ取得

    #削除処理
    doc_list = [] #既に登録されているドキュメントidを取得するリスト
    for doc in doc_d:
        doc_list.append(doc.id)
    # print(doc_list)
    len_d = len(doc_list) #長さを把握

    for i in range(len_d):
        deld = doc_list[i] #ドキュメントidを一つずつ取ってくる
        # print(deld)
        doc_del = db.collection('rankwithcount').document('{}'.format(deld)) #取ってきたidを一つずつ、削除対象のドキュメントidとして入れていく
        doc_del.delete() #削除


    #1.まずはimagsから全てのデータを取得
    docids = db.collection('imags').get()
    uid_list = [] #取得した全テータを入れるリスト
    for docid in docids:
        uid_list.append(docid.to_dict()) #辞書型にしてリストに入れる
    # print(uid_list)
    len_ul = len(uid_list)  #リストの長さ
    # print(len_ul)
    
    #2.uid(あるいはcloudurlの方がいいかも)とimagsデータを紐付けてテーブルを結合してcountを入れたい
    #imagsの中に含まれている全てデータからurl（あるいはcloudurl）とcountだけを抜き取ってuidkeyリストに入れる

    uidkey = [] 
    for i in range(len_ul):
        d = {
            # "uid":"{}".format(uid_list[i]['uid']),
            "count":"{}".format(uid_list[i]['count']),
            "cloudurl":"{}".format(uid_list[i]['cloudurl'])
        }
        uidkey.append(d)
    len_uk = len(uidkey)

    #今日の日時取得
    now = datetime.date.today()
    # ny = now.year
    # nm = now.month
    # nd = now.day
    td = now.strftime("%Y/%m/%d") #今日の日付を0産め
    print(td)

    #3 2で取得したuid（あるいはcloudurl）をrankテーブルのuidと照合させて、結合し、rankwithcountテーブルへ挿入
    uk_list=[]
    #まずはrankテーブルのuid(あるいはcloudurl)と照合してデータを一つずつ取ってくる
    for i in range(len_uk):
        docuk = db.collection('rank').where("cloudurl", "==", uidkey[i]['cloudurl']).where("cloudtime", "==", td).get() #cloud

        #取ってきたデータをuidをkeyにして辞書結合させる
        for dck in docuk:
            # print(dck)
            check_dck = dck.to_dict() #rankテーブルのデータを辞書型に処理
            check_uk = uidkey[i] #uidkey（imagsのデータ）のi番目のデータ
            check_dck.update(check_uk) #rankテーブルのデータとimagsデータの結合
            # print(check_uk)
            # print(check_dck)
            # print(dck_uk)
            uk_list.append(check_dck) #結合したデータをリストに突っ込む
            doc_ref = db.collection('rankwithcount').document('{}'.format(i)) #rankwithカウントにdocument名を0から順につけながら収める
            doc_ref.set(check_dck) #データ挿入
   
    print(uk_list)

    return '成功'