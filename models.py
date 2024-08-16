from sqlalchemy import Column, Integer, String, Float, Boolean, DateTime, ForeignKey, MetaData, Table, update
from Flask_App import db, app
from datetime import datetime
from sqlalchemy.orm import relationship
from enum import Enum
from flask_login import UserMixin

class Category(db.Model):
    __tablename__ = 'category'

    id = Column(Integer, primary_key=True, autoincrement=True)
    name = Column(String(20), nullable=False)
    products = relationship('Product', backref='category', lazy=False)
    
    def __str__(self):
        return self.name


class UserRole(Enum):
    ADMIN = 1
    USER = 2

class Product(db.Model):
    __tablename__ = 'product'

    id = Column(Integer, primary_key=True, autoincrement=True)
    name = Column(String(50), nullable=False)
    description = Column(String(255))
    price = Column(Float, default=0)
    image = Column(String(100))
    active = Column(Boolean, default=True)
    created_table = Column(DateTime, default=datetime.now())
    sale = Column(Boolean, default=False, nullable=True)
    sale_price = Column(Float, default=0, nullable=True)
    category_id = Column(Integer, ForeignKey('category.id'), nullable=False)
    receipt_details = relationship('ReceiptDetail', backref='product', lazy=True)
    comments = relationship('Comment', backref='product', lazy=True)

    def __str__(self):
        return self.name

class User(db.Model, UserMixin):
    id = Column(Integer, primary_key=True, autoincrement=True)
    name = Column(String(50), nullable=False)
    username = Column(String(50), nullable=False, unique=True)
    password = Column(String(50), nullable=False)
    avatar = Column(String(100))
    email = Column(String(50))
    active = Column(Boolean, default=True)
    joined_date = Column(DateTime, default=datetime.now())
    user_role = Column(Integer, default=1)
    receipts = relationship('Receipt', backref='user', lazy=True)
    comments = relationship('Comment', backref='user', lazy=True)
    faces = relationship('Face', backref='user', lazy=True)
    face_id = Column(Boolean, default=False)

    def __str__(self):
        return self.name

# Hoa don
class Receipt(db.Model):
    id = Column(Integer, primary_key=True, autoincrement=True)
    created_date = Column(DateTime, default=datetime.now())
    user_id = Column(Integer, ForeignKey(User.id), nullable=False)
    details = relationship('ReceiptDetail', backref='receipt', lazy=True)

class ReceiptDetail(db.Model):
    receipt_id = Column(Integer, ForeignKey(Receipt.id), nullable=False, primary_key=True)
    product_id = Column(Integer, ForeignKey(Product.id), nullable=False, primary_key=True)
    quantity = Column(Integer, default=0)
    unit_price = Column(Float, default=0)


class Comment(db.Model):
     id = Column(Integer, primary_key=True, autoincrement=True)
     content = Column(String(255), nullable=False)
     product_id = Column(Integer, ForeignKey(Product.id), nullable=False)
     user_id = Column(Integer, ForeignKey(User.id), nullable=False)
     created_date = Column(DateTime, default=datetime.now())

     def __str__(self):
         return self.content

class Face(db.Model):
    id = Column(Integer, primary_key=True, autoincrement=True)
    img = Column(String(255), unique=True, nullable=True)
    user_id = Column(Integer, ForeignKey(User.id), nullable=False)
    name = Column(String(25), nullable=True)

    def __str__(self):
        return self.name

if __name__ == "__main__":
    with app.app_context():
            db.create_all()
            # stmt = update(Product).values(sale=False)
            # db.session.execute(stmt)
            # db.session.commit()


    #     c1 = Category(name="Dien thoai")
    #     c2 = Category(name="May tinh bang")
    #     c3 = Category(name="Dong ho thong minh")
    #
    #     db.session.add(c1)
    #     db.session.add(c2)
    #     db.session.add(c3)
    #
    #     db.session.commit()
    #
    #     products = [{
    #     "image" : "images/iphone7.jpg",
    #     "id" : 1,
    #     "name" : "IPhone 7 Plus",
    #     "price" : 17000000,
    #     "category_id" : 1
    # }, {
    #     "image" : "images/iphone7.jpg",
    #     "id" : 2,
    #     "name" : "IPad Pro 2020",
    #     "price" : 37000000,
    #     "category_id" : 2
    # }, {
    #     "image" : "images/iphone7.jpg",
    #     "id" : 3,
    #     "name" : "IPhone 6 Plus",
    #     "price" : 13000000,
    #     "category_id" : 1
    # }, {
    #     "image" : "images/iphone7.jpg",
    #     "id" : 4,
    #     "name" : "IPad Mini 2020",
    #     "price" : 29000000,
    #     "category_id" : 1
    # }, {
    #     "image" : "images/iphone7.jpg",
    #     "id" : 5,
    #     "name" : "IPhone 7",
    #     "price" : 14000000,
    #     "category_id" : 1
    # }]
    #
    #     for p in products:
    #         pro = Product(name=p['name'], price=p['price'], image=p['image'],
    #                     category_id=p['category_id'])
    #         db.session.add(pro)
    #
    #     db.session.commit()