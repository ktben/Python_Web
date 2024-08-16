import os
import cv2
import time
import face_recognition
from sklearn.svm import SVC
import numpy as np
from Flask_App import app, db
from Flask_App.models import Face

def recognize(timeout=15):
    net = cv2.dnn.readNetFromCaffe('./models/deploy.prototxt.txt',
                                   './models/res10_300x300_ssd_iter_140000_fp16.caffemodel')

    cam = cv2.VideoCapture(0)

    face_cascade = cv2.CascadeClassifier("./models/haarcascade_frontalface_default.xml")

    recognizer = cv2.face.LBPHFaceRecognizer_create()

    recognizer.read('recognizer/trainingData.yml')

    modeType = 3
    fontFace = cv2.FONT_HERSHEY_SIMPLEX

    start_time = time.time()

    while(True):
        ret, frame = cam.read()

        if not ret:
            break

        blob = cv2.dnn.blobFromImage(frame, 1.0, (300, 300), (104, 177, 123), swapRB=False)
        net.setInput(blob)
        faces = net.forward()
        h, w = frame.shape[:2]

        # faces = face_cascade.detectMultiScale(frame)


        elapsed_time = time.time() - start_time
        if elapsed_time > timeout:
                cv2.destroyAllWindows()
                return False  # Timeout reached, return False

        else:
            for i in range(0, faces.shape[2]):
                confidence = faces[0, 0, i, 2]

                if confidence > 0.9:
                    start_x = int(faces[0, 0, i, 3] * w)
                    start_y = int(faces[0, 0, i, 4] * h)
                    end_x = int(faces[0, 0, i, 5] * w)
                    end_y = int(faces[0, 0, i, 6] * h)

                    cv2.rectangle(frame, (start_x, start_y), (end_x, end_y), (0, 255, 0), 2)

                    gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)
                    roi_gray = gray[start_y: end_y, start_x: end_x]

                    id, confidence = recognizer.predict(roi_gray)
                    print(100 - confidence," ", id)
                    if confidence < 45:
                        # cv2.putText(frame, f"{100 - round(confidence)}%", (x+10, y-10), fontFace, 1, (0,255,0), 2)
                        cv2.destroyAllWindows()
                        return id

        cv2.imshow("Recognize", frame)
        if cv2.waitKey(1) == ord(' '):
            break

    cv2.destroyAllWindows()