from Flask_App import app, db
from Flask_App.models import Category, Product, User, Receipt, ReceiptDetail, UserRole, Comment, Face
import hashlib
from flask_login import current_user
from sqlalchemy import func, and_
from sqlalchemy.sql import extract
import os


def load_categories():
    return Category.query.all()

def load_products(cate_id=None, kw=None, page=1):
    products = Product.query.filter(Product.active.__eq__(True))

    if cate_id:
        products = products.filter(Product.category_id.__eq__(cate_id))

    if kw:
        products = products.filter(Product.name.contains(kw))

    products = products.order_by(Product.category_id)
    page_size = app.config['PAGE_SIZE']
    start = (page - 1) * page_size
    end = start + page_size
    # select * from product limit 4 offset 0

    return products.slice(start, end).all()


def load_all_products():
    products = Product.query.filter(Product.active.__eq__(True))
    products = products.order_by(Product.category_id)
    return products

def count_product(cate_id=None, kw=None):
    if cate_id:
        return Product.query.filter(and_(Product.active.__eq__(True),Product.category_id.__eq__(cate_id))).count()

    if kw:
        return Product.query.filter(Product.name.contains(kw)).count()

    return Product.query.filter(Product.active.__eq__(True)).count()


def get_product_by_id(product_id):
    return Product.query.get(product_id)

def get_cate_by_id(cate_id):
    return Category.query.get(cate_id)


def add_user(name, username, password, **kwargs):
    password = str(hashlib.md5(password.strip().encode('utf-8')).hexdigest())
    user = User(name=name.strip(),
                username=username.strip(),
                password=password,
                email=kwargs.get('email'),
                avatar = kwargs.get('avatar'))

    db.session.add(user)
    db.session.commit()

def check_login(username, password, role=1):
    if username and password:
        password = str(hashlib.md5(password.strip().encode('utf-8')).hexdigest())

        return User.query.filter(User.username.__eq__(username.strip()),
                                 User.password.__eq__(password),
                                User.user_role.__eq__(role)).first()

def check_face_login(id):
    return User.query.filter(User.id.__eq__(id)).first()


def set_face_id(img_path):
    face = Face(img=img_path, user=current_user)
    db.session.add(face)
    current_user.face_id = 1
    # g.user = current_user.get_id()
    # face_to_update = User.query.filter(user=g.user).first()
    # face_to_update.face_id = True

    db.session.commit()


def get_user_by_id(user_id):
    return User.query.get(user_id)


def count_cart(cart):
    total_quantity, total_amount = 0, 0

    if cart:
        for c in cart.values():
            total_quantity += c['quantity']
            total_amount += c['quantity'] * c['price']

    return {
        'total_quantity': total_quantity,
        'total_amount': total_amount
    }

def add_receipt(cart):
    if cart:
        receipt = Receipt(user=current_user)
        db.session.add(receipt)

        for c in cart.values():
            d = ReceiptDetail(receipt=receipt,
                              product_id=int(c['id']),
                              quantity=c['quantity'],
                              unit_price=c['price'])
            db.session.add(d)

        db.session.commit()

def category_stats():
    '''
    SELECT C.id, c.name, count(p.id)
    FROM category c left outer join product p on c.id = p.category_id
    GROUP BY c.id, c.name
    '''

    # return Category.query.join(Product, Product.category_id.__eq__(Category.id), isouter=True)\
    #     .add_column(func.count(Product.id)).group_by(Category.id, Category.name).all()

    return db.session.query(Category.id, Category.name, func.count(Product.id))\
          .join(Product, Category.id.__eq__(Product.category_id), isouter=True)\
          .group_by(Category.id, Category.name).all()
#
# with app.app_context():
#     print(category_stats())


def product_stats(kw=None, from_date=None, to_date=None):
    p = db.session.query(Product.id, Product.name, func.sum(ReceiptDetail.quantity * ReceiptDetail.unit_price))\
        .join(ReceiptDetail, ReceiptDetail.product_id.__eq__(Product.id), isouter=True)\
        .join(Receipt, Receipt.id.__eq__(ReceiptDetail.receipt_id))\
        .group_by(Product.id, Product.name)\
        .order_by( func.sum(ReceiptDetail.quantity * ReceiptDetail.unit_price))

    if kw:
        p = p.filter(Product.name.contains(kw))
        print(p)

    if from_date:
        p = p.filter(Receipt.created_date.__ge__(from_date))

    if to_date:
        p = p.filter(Receipt.created_date.__le__(to_date))

    return p.all()

def product_months_stats(year):
    return db.session.query(extract('month', Receipt.created_date),
                            func.sum(ReceiptDetail.quantity*ReceiptDetail.unit_price))\
                            .join(ReceiptDetail, ReceiptDetail.receipt_id.__eq__(Receipt.id))\
                            .filter(extract('year', Receipt.created_date) == year)\
                            .group_by(extract('month', Receipt.created_date))\
                            .order_by(extract('month', Receipt.created_date)).all()


def add_comment(content, product_id):
    c = Comment(content=content, product_id=product_id, user=current_user)

    db.session.add(c)
    db.session.commit()

    return c


def get_comments(product_id, page=1):
    page_size = app.config['COMMENT_SIZE']
    start = (page - 1) * page_size

    return Comment.query.filter(Comment.product_id.__eq__(product_id)).order_by(-Comment.id).slice(start, start + page_size).all()


def count_comment(product_id):
    return Comment.query.filter(Comment.product_id.__eq__(product_id)).count()