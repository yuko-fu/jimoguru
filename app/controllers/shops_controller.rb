class ShopsController < ApplicationController
  before_action :set_shop, only: %i[ show edit update destroy ]
  before_action :set_current_user, only: %i[ index new show edit update ]

  # GET /shops or /shops.json
  def index
    @shops = Shop.all
    @categories = Category.all
    @user = current_user
    if params[:prefecture].present? && params[:category_id].present?
      category = Category.find(params[:category_id])
      @shops = category.shops.where(prefecture: params[:prefecture])
      
    elsif params[:prefecture].present?
      @shops = Shop.where(prefecture: params[:prefecture])
    elsif params[:category_id].present?
      category = Category.find(params[:category_id])
      @shops = category.shops
    end
    @category_names = Category.pluck(:name)
    @shop_vote_counts = Shop.joins(:votes).group(:shop_id).count
    @shops = @shops.order(latitude: :desc).page(params[:page]).per(10)
    
  end
  # GET /shops/1 or /shops/1.json
  def show
    
    gon.shops = Shop.find(params[:id])
    gon.menu = Shop.find(params[:id])
    @shop = Shop.find(params[:id])
    @votes = @shop.votes.group(:menu_id).count 
    @menu_names = Menu.where(id: @votes.keys).pluck(:id, :name).to_h
    @votes_with_names = @votes.map { |menu_id, count| { id: menu_id, name: @menu_names[menu_id], count: count } }
    gon.votes = @votes_with_names
    @user_prefecture = current_user.prefecture if user_signed_in?
    
  end
  
  # GET /shops/new
  def new
    @shop = Shop.new
  end

  # GET /shops/1/edit
  def edit
    @shop = Shop.find(params[:id])
  end

  # POST /shops or /shops.json
  def create
    @shop = Shop.new(shop_params)

    respond_to do |format|
      if @shop.save
        format.html { redirect_to shop_url(@shop), notice: "Shop was successfully created." }
        format.json { render :show, category: :created, location: @shop }
      else
        flash.now[:alert] = "同じ住所のお店は登録済みです"
        format.html { render :new, category: :unprocessable_entity }
        format.json { render json: @shop.errors, category: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /shops/1 or /shops/1.json
  def update
    
    respond_to do |format|
      if @shop.update(shop_params)
        format.html { redirect_to shop_url(@shop), notice: "Shop was successfully updated." }
        format.json { render :show, category: :ok, location: @shop }
      else
        format.html { render :edit, category: :unprocessable_entity }
        format.json { render json: @shop.errors, category: :unprocessable_entity }
      end
    end
  end

  # DELETE /shops/1 or /shops/1.json
  def destroy
    @shop.destroy

    respond_to do |format|
      format.html { redirect_to shops_url, notice: "Shop was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_shop
      @shop = Shop.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def shop_params
      params.require(:shop).permit(:name, :prefecture, :address, :category_id)
    end

    def set_current_user
      @user = current_user
    end
end
