from Flask_App import app,db
from flask_admin import Admin
from Flask_App.models import Category, Product, UserRole
from flask_admin.contrib.sqla import ModelView
from flask_login import current_user, logout_user
from flask_admin import BaseView, expose, AdminIndexView
from flask import redirect
import utils
from flask import request
from datetime import datetime
class AuthenticatedModelView(ModelView):
    def is_accessible(self):
        return current_user.is_authenticated and current_user.user_role.__eq__(2)

class ProductView(AuthenticatedModelView):
    create_modal = True
    column_display_pk = True
    column_hide_backrefs = False
    column_list = ['id', 'name', 'price', 'image', 'active', 'description', 'category_id', 'sale', 'sale_price']
    form_columns = ['id','name', 'price', 'image', 'active', 'description', 'category_id', 'sale', 'sale_price']
    can_view_details = True
    can_export = True
    column_searchable_list = ['name', 'category_id']
    column_filters = ['name', 'price', 'category_id']
    column_exclude_list = ['image', 'active']
    column_sortable_list = ['id', 'name', 'price']

class CategoryView(AuthenticatedModelView):
    create_modal = True
    column_display_pk = True
    column_hide_backrefs = False
    column_list = ['id', 'name']
    form_columns = ['id','name']
    can_view_details = True
    can_export = True
    column_searchable_list = ['name']
    column_filters = ['name']
    column_sortable_list = ['id']


class LogoutView(BaseView):
    @expose('/')
    def index(self):
        logout_user()
        return redirect("/admin")

    def is_accessible(self):
        return current_user.is_authenticated and current_user.user_role.__eq__(2)


class MyAdminIndex(AdminIndexView):
    @expose('/')
    def index(self):
        return self.render('admin/index.html', stats=utils.category_stats())


class StatsView(BaseView):
    @expose('/')
    def index(self):
        kw = request.args.get('kw')
        from_date = request.args.get('from_date')
        to_date = request.args.get('to_date')
        year = request.args.get('year', datetime.now())


        return self.render('admin/stats.html',
                           month_stats = utils.product_months_stats(year=year),
                           stats = utils.product_stats(kw=kw,
                            from_date=from_date, to_date=to_date))

    def is_accessible(self):
        return current_user.is_authenticated and current_user.user_role.__eq__(2)





admin = Admin(app=app, name = "AANT Website", template_mode="bootstrap4", index_view=MyAdminIndex())
admin.add_view(ProductView(Product, db.session))
admin.add_view(CategoryView(Category, db.session))
admin.add_view(StatsView(name='Stats'))
admin.add_view(LogoutView(name='Logout'))
