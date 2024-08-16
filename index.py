from flask import Flask
from flask import render_template, request, redirect, session, jsonify, url_for
from Flask_App import app, login
import math
import cloudinary.uploader
from flask_login import login_user, logout_user, login_required
import Face_Detect
from Recognize import recognize
import TrainingData
from Suggest import recommendSimilarProducts, recommend_products_by_user_receipt

@app.route('/')
def home():

    page = request.args.get('page', 1)

    cate_id = request.args.get('category_id')

    kw = request.args.get('kw')

    products = utils.load_products(cate_id = cate_id, kw = kw, page=int(page))

    all_products = utils.load_all_products()

    cate_name = utils.get_cate_by_id(cate_id)

    counter = utils.count_product(cate_id=cate_id, kw = kw)

    prev_page = url_for('home', page=int(page) - 1) if int(page) > 1 else None
    next_page = url_for('home', page=int(page) + 1)

    recommend_id = None
    if current_user.is_authenticated:
        recommend_id = recommend_products_by_user_receipt(current_user.id)

    return render_template('index.html',
                           products=products,
                           pages=math.ceil(counter / app.config['PAGE_SIZE']),
                           prev_page=prev_page,
                           next_page=next_page,
                           cate_name=cate_name,
                           recommend_id=recommend_id,
                           all_products=all_products
                           )


@app.route('/product/<int:product_id>')
def product_detail(product_id):
    product = utils.get_product_by_id(product_id)

    products = utils.load_all_products()

    comments = utils.get_comments(product_id=product_id,
                                  page=int(request.args.get('page', 1)))

    suggest_id = recommendSimilarProducts(product_id, NUMBER = 5)

    suggest_id = sorted(suggest_id)

    return render_template('product_detail.html',
                           comments=comments,
                           product = product,
                           pages = math.ceil(utils.count_comment(product_id)/app.config['COMMENT_SIZE']),
                           products=products,
                           suggest_id=suggest_id
                           )


@app.route('/register', methods=['get', 'post'])
def user_register():
    err_msg = ""
    if request.method.__eq__('POST'):
        name = request.form.get('name')
        username = request.form.get('username')
        password = request.form.get('password')
        email = request.form.get('email')
        confirm = request.form.get('confirm')
        avatar_path = None

        try:
            if password.strip().__eq__(confirm.strip()):
                avatar = request.files.get('avatar')
                if avatar:
                    res = cloudinary.uploader.upload(avatar)
                    avatar_path = res['secure_url']
                utils.add_user(name=name, username=username,
                               password=password, email=email,
                               avatar = avatar_path)
                return redirect("/user-login")
            else:
                err_msg = "Mat khau khong khop"

        except Exception as e:
            err_msg = "He thong dang co loi " + str(e)


    return render_template('register.html', err_msg = err_msg)


@app.route('/user-login', methods=['get', 'post'])
def user_signin():
    err_msg = ""
    if request.method.__eq__('POST'):
        username = request.form.get('username')
        password = request.form.get('password')

        user = utils.check_login(username=username, password=password)
        if user:
            login_user(user=user)
            next = request.args.get('next', 'home')
            return redirect(url_for(next))

        else:
            err_msg = 'Username hoặc password không chính xác'

    return render_template('login.html', err_msg = err_msg)


@app.route('/detect')
def register_face_detect():
    user_id = request.args.get('user_id')
    img_path = Face_Detect.detect(user_id)
    utils.set_face_id(img_path)
    TrainingData.trainData()

    return redirect(url_for('home'))


# khi nhận dạng thì lấy ảnh từ cơ sở dữ liệu lên, train rồi mới nhận diện
# --> Khi lấy ảnh lên để nhận diện thì lấy id tương ứng label + ảnh của người đó rồi cho vào dictionary
@app.route('/recognizer')
def face_recognize():
    result = recognize()
    if result:
        id = result
        user = utils.check_face_login(id)
        login_user(user=user)
        next = request.args.get('next', 'home')
        return redirect(url_for(next))


    elif result == False:
        err_msg = "Không nhận dạng được đối tượng, vui lòng thử lại !!"
        return render_template('login.html', err_msg = err_msg)



@app.route('/admin-login', methods=['post'])
def signin_admin():
    if request.method.__eq__('POST'):
        username = request.form.get('username')
        password = request.form.get('password')

        user = utils.check_login(username=username,
                                 password=password,
                                 role=2)
        if user:
            login_user(user=user)
            return redirect('/admin')

        else:
            err_msg = 'Username hoặc password không chính xác'

        return redirect('/admin')


@app.route('/user-logout')
def user_signout():
    logout_user()
    return redirect('/user-login')


@app.route('/api/comment', methods=['post'])
@login_required
def add_comment():
    data = request.json
    content = data.get('content')
    product_id = data.get('product_id')

    try:
        c = utils.add_comment(content=content, product_id=product_id)
    except:
        return {'status': 404, 'err_msg': 'Chương trình đang bị lỗi !!!'}

    return {'status': 201, 'comment': {
        'id': c.id,
        'content': c.content,
        'created_date': c.created_date,
        'user': {
            'username': current_user.username,
            'avatar': current_user.avatar
        }
    }}


@app.context_processor
def common_response():
    return {
        'categories': utils.load_categories(),
        'cart_stats': utils.count_cart(session.get('cart'))
    }


@login.user_loader
def user_load(user_id):
    return utils.get_user_by_id(user_id=user_id)


@app.route('/products')    
def product_list():
    
    cate_id = request.args.get("category_id")

    kw = request.args.get("keyword")
    
    products = utils.load_products(cate_id=cate_id, kw=kw)
    
    return render_template('products.html',
                           products=products)


@app.route('/cart')
def cart():
    return render_template('cart.html',
                           stats = utils.count_cart(session.get('cart'))
                           )


@app.route('/api/add-cart', methods=['post'])
def add_to_cart():
    data = request.get_json()
    id = str(data.get('id'))
    name = data.get('name')
    price = data.get('price')
    image = data.get('image')


    cart = session.get('cart')
    if not cart:
        cart = {}

    if id in cart:
        cart[id]['quantity'] = cart[id]['quantity'] + 1
    else:
        cart[id] = {
            'id': id,
            'name': name,
            'price': price,
            'quantity': 1,
            'image': image
        }

    session['cart'] = cart

    return jsonify(utils.count_cart(cart))


@app.route("/api/update-cart", methods=['put'])
def update_cart():
    data = request.json
    id = str(data.get('id'))
    quantity = data.get('quantity')

    cart = session.get('cart')

    if cart and id in cart:
        cart[id]['quantity'] = quantity
        session['cart'] = cart

    return jsonify(utils.count_cart(cart))


@app.route("/api/delete-cart/<product_id>", methods = ['delete'])
def delete_cart(product_id):
    cart = session.get('cart')

    if cart and product_id in cart:
        del cart[product_id]

        session['cart'] = cart

    return jsonify(utils.count_cart(cart))


@app.route('/api/pay', methods=['post'])
def pay():
    try:
        utils.add_receipt(session.get('cart'))
        del session['cart']
    except:
        print("Error")
        return jsonify({'code': 400})

    return jsonify({'code': 200})


if __name__ == "__main__":
    from Flask_App.admin import *
    app.run(debug=True)