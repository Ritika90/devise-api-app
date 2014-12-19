class ProductsController < ApplicationController

  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_filter :verify_auth_token

  def verify_auth_token
    @user = User.find_by_authentication_token(request.headers["token"])
  end

  def index
    @products = @user.products
    render json: @products
  end

  def show
    render json: @products
  end

  def new
    @product = Product.new
    render json: @products
  end

  def edit
  end

  def create
    @product = @user.products.new(product_params)
    @product.save
    render :json => {:status => "Product Created"}
  end

  def update
    @product.update(product_params)
    render json: @products
  end

  def destroy
    @product.destroy
    render json: @products
  end

  private
    def set_product
      @product = Product.find(params[:id])
    end

    def product_params
      params.require(:product).permit(:name, :price, :user_id)
    end
end
