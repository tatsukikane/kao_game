#主要のライブラリ読み込み
import json
import base64
import io
import os
from google.cloud import storage #storage読み込み
from google.cloud import vision #vision api読み込み
from google.cloud import firestore #firestore読み込み


def detect_faces_uri(data, context): #storageに写真が追加された時がトリガー。引数二つ。
    bucket = data['bucket'] #追加されたデータのbucketの名前
    name = data['name'] #追加されたデータのobjectの名前
    client = vision.ImageAnnotatorClient() #クライアント宣言
    image = vision.Image() #image取得の既定関数
    image.source.image_uri = 'gs://{}/{}'.format(bucket,name) #gsuri以外ではエラーになる。
    updateimg = 'gs://{}/{}'.format(bucket,name) #確認用
    iu = 'https://storage.cloud.google.com/{}/{}'.format(bucket,name) #urlでfirestoreと照合させる
    print(iu) #urlの取得確認など
    print(updateimg)
    print(data)
    db = firestore.Client() #firestoreに接続
    docsid = db.collection('imags').where("cloudurl", "==", iu).get() #firestoreのimagsのcloudurlとstorageからきたデータの照合
    id_list = []
    for docid in docsid:
        id_list.append(docid.to_dict()) #imagsのデータを取得してid_listに突っ込む
        print(id_list)

    response = client.face_detection(image=image) #face_detectionの利用
    faces = response.face_annotations #判定
    likelihood_name = ('UNKNOWN', 'VERY_UNLIKELY', 'UNLIKELY', 'POSSIBLE',
                       'LIKELY', 'VERY_LIKELY') #既定の評価
    likelihood_num = { #既定の評価を数字化するための箱
        'UNKNOWN':0,  
        'VERY_UNLIKELY':1, 
        'UNLIKELY':2, 
        'POSSIBLE':3,
        'LIKELY':4, 
        'VERY_LIKELY':5
    }
    
    print('Faces:') #確認用

    doc_d = db.collection('todaytopic').get() #todaytopicから各感情のweightを取得
    doc_list=[]
    for doc in doc_d:
        doc_list.append(doc.to_dict())
    print(doc_list)
# /////
    #感情数値取得
    anger = doc_list[0]['anger']
    joy = doc_list[0]['joy']
    surprise = doc_list[0]['surprise']
    sorrow = doc_list[0]['sorrow']

    for face in faces: 
         #それぞれのvisionapi側の既定評価名を後に配列のkeyとして使用する
        a = likelihood_name[face.anger_likelihood]
        j = likelihood_name[face.joy_likelihood]
        s = likelihood_name[face.surprise_likelihood]
        so = likelihood_name[face.sorrow_likelihood]
        print(a)
        print(j)
        print(s)
        print(so)
        total = likelihood_num[a]*anger+likelihood_num[j]*joy+likelihood_num[s]*surprise+likelihood_num[so]*sorrow #取得した感情値とお題別感情重要度を計算して総合点算出
        d={ #これをrankのデータに突っ込むuidは今後の照会用とimgurlはランキング画像
            'anger': '{}'.format(likelihood_num[a]),
            'joy':'{}'.format(likelihood_num[j]),
            'surprise': '{}'.format(likelihood_num[s]),
            'sorrow': '{}'.format(likelihood_num[so]),
            'total':'{}'.format(total),
            'cloudurl':'{}'.format(iu),
            'imgurl':'{}'.format(id_list[0]['imgurl']),
            'uid':'{}'.format(id_list[0]['uid']),
            'cloudtime':'{}'.format(id_list[0]['cloudtime']),
            'name':'{}'.format(id_list[0]['name']),
            'profurl':'{}'.format(id_list[0]['profurl'])
            # 'anger': '{}'.format(likelihood_name[face.anger_likelihood]),
            # 'joy':'{}'.format(likelihood_name[face.joy_likelihood]),
            # 'surprise': '{}'.format(likelihood_name[face.surprise_likelihood]),
            # 'sorrow': '{}'.format(likelihood_name[face.sorrow_likelihood]),

        }
        print(d)
        db = firestore.Client() #db接続
        doc_ref = db.collection('rank') #rankに入れる宣言
        # rd = {"rank": d}
        doc_ref.add(d) #追加。ドキュメントをユニークキーに設定するならadd()
        return str(d)
    if response.error.message: #エラー用
        raise Exception(
            '{}\nFor more info on error messages, check: '
            'https://cloud.google.com/apis/design/errors'.format(
                response.error.message))


# [END vision_face_detection_gcs]