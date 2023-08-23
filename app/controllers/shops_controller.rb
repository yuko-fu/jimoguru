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
    @shop_prefecture = [ "北海道","青森県","岩手県","宮城県","秋田県","山形県","福島県",
    "茨城県","栃木県","群馬県","埼玉県","千葉県","東京都","神奈川県",
    "新潟県","富山県","石川県","福井県","山梨県","長野県",
    "岐阜県","静岡県","愛知県","三重県",
    "滋賀県","京都府","大阪府","兵庫県","奈良県","和歌山県",
    "鳥取県","島根県","岡山県","広島県","山口県",
    "徳島県","香川県","愛媛県","高知県",
    "福岡県","佐賀県","長崎県","熊本県","大分県","宮崎県","鹿児島県",
    "沖縄県" ] & Shop.pluck(:prefecture).uniq
      
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
  
  def new
    @shop = Shop.new
  end

  def edit
    @shop = Shop.find(params[:id])
  end

  def create
    @shop = Shop.new(shop_params)

    respond_to do |format|
      if @shop.save
        format.html { redirect_to shop_url(@shop), notice: "お店の新規登録できました" }
        format.json { render :show, category: :created, location: @shop }
      else
        flash.now[:alert] = "入力され店名または住所は、空欄または登録済みです"
        format.html { render :new, category: :unprocessable_entity }
        format.json { render json: @shop.errors, category: :unprocessable_entity }
      end
    end
  end

  def update
    
    respond_to do |format|
      if @shop.update(shop_params)
        format.html { redirect_to shop_url(@shop), notice: "ショップの編集しました" }
        format.json { render :show, category: :ok, location: @shop }
      else
        format.html { render :edit, category: :unprocessable_entity }
        format.json { render json: @shop.errors, category: :unprocessable_entity }
      end
    end
  end

  def destroy
    @shop.destroy

    respond_to do |format|
      format.html { redirect_to shops_url, notice: "Shop was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    
    def set_shop
      @shop = Shop.find(params[:id])
    end

    def shop_params
      params.require(:shop).permit(:name, :prefecture, :address, :category_id)
    end

    def set_current_user
      @user = current_user
    end
end
