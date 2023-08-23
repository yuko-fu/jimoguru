class MenusController < ApplicationController
  before_action :set_menu, only: %i[ show edit update destroy ]

  def index
    @menus = Menu.all
  end

  def show
    @menu = Menu.find(params[:id])
    @votes = @menu.votes
    
    expires_now
  end

  def new
    @menu = Menu.new
  end

  def edit
    @menu = Menu.new
  end

  def create
    
    @menu = Menu.new(menu_params)
    @vote = Vote.new(vote_params)
    @shop = Shop.find(params[:shop_id])
    if @menu.save
      redirect_to new_vote_path(shop_id: @shop.id)
    else
      redirect_back(fallback_location: new_vote_path(shop_id: @shop.id)) 
    end
  end

  def update
    respond_to do |format|
      if @menu.update(menu_params)
        format.html { redirect_to menu_url(@menu), notice: "Menu was successfully updated." }
        format.json { render :show, status: :ok, location: @menu }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @menu.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @menu.destroy

    respond_to do |format|
      format.html { redirect_to menus_url, notice: "Menu was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    
  def set_menu
    @menu = Menu.find(params[:id])
  end

  def menu_params
    params.permit(:name, :shop_id)
  end

  def vote_params
    params.permit(:image, :content, :shop_id, :user_id, :menu_id)
  end
end
