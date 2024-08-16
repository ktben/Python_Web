import os
import numpy as np
from PIL import Image
from Flask_App import app, db
import utils
from Flask_App.models import Face
import numpy as np
import urllib
import cv2


recognizer = cv2.face.LBPHFaceRecognizer_create()

path = './dataset'


def getImagesAndLabels(path):
    IMG_AMOUNT = 200
    faces = []
    IDs = []
    for user_id in os.listdir(path):
        user_dir = os.path.join(path, user_id)
        for count in range(1, IMG_AMOUNT + 1):
            image_path = os.path.join(user_dir, f"{count}.jpg")
            if os.path.exists(image_path):
                image = cv2.imread(image_path, cv2.IMREAD_GRAYSCALE)
                faces.append(image)
                IDs.append(int(user_id))
    return faces, IDs


def trainData():
    faces, IDs = getImagesAndLabels(path)

    if os.path.exists('recognizer/trainingData.yml'):
        # Xóa file trainingData.yml hiện tại
        os.remove('recognizer/trainingData.yml')

    recognizer.train(faces, np.array(IDs))

    if not os.path.exists('recognizer'):
        os.mkdir('recognizer')

    recognizer.save('recognizer/trainingData.yml')
    print("Train success")

    cv2.destroyAllWindows()
