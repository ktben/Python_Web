import os
import numpy as np
from PIL import Image
from Flask_App import app, db
import utils
from Flask_App.models import Face
import numpy as np
import cv2

def detect(user_id):
    net = cv2.dnn.readNetFromCaffe('./models/deploy.prototxt.txt',
                                   './models/res10_300x300_ssd_iter_140000_fp16.caffemodel')


    save_path = None
    stat = 1
    cam = cv2.VideoCapture(0)

    count = 0

    while True:
        ret, frame = cam.read()
        if not ret:
            break

        blob = cv2.dnn.blobFromImage(frame, 1.0, (300,300), (104, 177, 123), swapRB = False)
        net.setInput(blob)
        faces = net.forward()

        h, w = frame.shape[:2]

        for i in range(0, faces.shape[2]):
            confidence = faces[0, 0, i, 2]

            if confidence > 0.9:
                start_x = int(faces[0, 0, i, 3] * w)
                start_y = int(faces[0, 0, i, 4] * h)
                end_x = int(faces[0, 0, i, 5] * w)
                end_y = int(faces[0, 0, i, 6] * h)

                cv2.rectangle(frame, (start_x, start_y), (end_x, end_y), (0, 255, 0), 2)

                # cv2.putText(frame,"Press Space to take a photo",(10, 30),cv2.FONT_HERSHEY_SIMPLEX,1.0 ,(255,0,255),2 )
                # cv2.putText(frame, f'{count*0.1}%', (10, 70), cv2.FONT_HERSHEY_SIMPLEX, 1.0, (255, 0, 255), 2)
                cv2.imshow('Face Detector', frame)
                gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)
                count += 1
                if not os.path.exists(f'./dataset/{user_id}'):
                    os.mkdir(f'./dataset/{user_id}')
                save_path = f'./dataset/{user_id}'
                cv2.imwrite(save_path + f'/{count}.jpg', gray[start_y: end_y, start_x: end_x])

                    # image_path = None
                    #
                    # res = cloudinary.uploader.upload(frame)
                    # image_path = res['secure_url']
                    # face = Face(img=image_path, user=current_user)
                    # db.session.add(face)
                    # db.session.commit()
                if count >= 1000 or cv2.waitKey(1) == ord('k'):
                    stat = 0
                    break

        if stat == 0:
            break

    print("Data captured successfully")
    cam.release()
    cv2.destroyAllWindows()

    return save_path






