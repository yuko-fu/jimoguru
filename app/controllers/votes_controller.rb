class VotesController < ApplicationController
  before_action :set_vote, only: %i[ show edit update destroy ]
 
  def index
    @votes = Vote.all
  end

  def show
    @vote = Vote.find(params[:id])
    
  end

  def new
    @vote = Vote.new
    @shop = Shop.find(params[:shop_id])
    @menus = @shop.menus

  end

  def edit
    @vote = Vote.find(params[:id])
  end

  def create
    @vote = current_user.votes.new(vote_params)
    @shop = Shop.find(params[:vote][:shop_id])
    @menus = @shop.menus
    if @vote.save
      redirect_to @vote.shop, notice: '投票が成功しました。'
    else
      Rails.logger.error @vote.errors.full_messages.inspect
      # redirect_back(fallback_location: new_vote_path(shop_id: @shop.id), notice:"投票ができませんでした")
      redirect_to new_vote_path(shop_id: @shop.id), alert: 'エラーが発生しました'
      
    end
  end

  def update
    @vote = Vote.find(params[:id])
    respond_to do |format|
      if @vote.update(vote_params)
        format.html { redirect_to vote_url(@vote), notice: "Vote was successfully updated." }
        format.json { render :show, status: :ok, location: @vote }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @vote.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @vote.destroy
    respond_to do |format|
      format.html { redirect_to user_path(@vote), notice: "Vote was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
  
    def set_vote
      @vote = Vote.find(params[:id])
    end

    def vote_params
      params.require(:vote).permit(:image, :content, :shop_id, :user_id, :menu_id)
    end
end
