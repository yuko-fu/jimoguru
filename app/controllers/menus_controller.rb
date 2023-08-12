class MenusController < ApplicationController
  before_action :set_menu, only: %i[ show edit update destroy ]

  # GET /menus or /menus.json
  def index
    @menus = Menu.all
  end

  # GET /menus/1 or /menus/1.json

  def show
    @menu = Menu.find(params[:id])
    # @menu = Menu.find(params[:id])
    # @votes = @menu.votes.group(:menu_id).count 
    # gon.votes = @votes
    
  end

  # GET /menus/new
  def new
    @menu = Menu.new
  end

  # GET /menus/1/edit
  def edit
    @menu = Menu.new
  end

  # POST /menus or /menus.json
  def create
    
    @menu = Menu.new(menu_params)
    @vote = Vote.new(vote_params)
    @shop = Shop.find(params[:shop_id])
    # binding.pry
    if @menu.save
      redirect_to new_vote_path(shop_id: @shop.id)
    else
      render :new
    end
  end

  # PATCH/PUT /menus/1 or /menus/1.json
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

  # DELETE /menus/1 or /menus/1.json
  def destroy
    @menu.destroy

    respond_to do |format|
      format.html { redirect_to menus_url, notice: "Menu was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_menu
      @menu = Menu.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def menu_params
      params.permit(:name, :shop_id)
    end

    def vote_params
      params.permit(:image, :content, :shop_id, :user_id, :menu_id)
    end
end
