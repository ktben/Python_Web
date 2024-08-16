from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from flask_admin import Admin
from flask_login import LoginManager
import cloudinary

app = Flask(__name__)

app.secret_key= 'ajwdnkjabwhdkbalwdajwd'
app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql+pymysql://root:123456tuan@localhost/labsaledb?charset=utf8mb4'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = True
app.config['PAGE_SIZE'] = 8
app.config['COMMENT_SIZE'] = 20

db = SQLAlchemy(app=app)


cloudinary.config(
    cloud_name= 'dr4hg7vdv',
    api_key= '219231189323661',
    api_secret= '13au1HyrP1GXpZhf3d5fM09OPEs',
)

login = LoginManager(app=app)