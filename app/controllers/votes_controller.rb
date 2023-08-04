class VotesController < ApplicationController
  before_action :set_vote, only: %i[ show edit update destroy ]

  # GET /votes or /votes.json
  def index
    @votes = Vote.all
  end

  # GET /votes/1 or /votes/1.json
  def show
    @vote = Vote.find(params[:id])
  end

  # GET /votes/new
  def new
    @shop = Shop.find(params[:shop_id])
    @existing_vote = Vote.find_by(user: current_user, shop: @shop)

    if @existing_vote
      redirect_to edit_vote_path(@existing_vote)
    else
      @vote = Vote.new(shop: @shop)
    end
  end

  # GET /votes/1/edit
  def edit
    @vote = Vote.find(params[:id])
  end

  # POST /votes or /votes.json
  def create
    @vote = current_user.votes.new(vote_params)


    respond_to do |format|
      if @vote.save
        redirect_to @vote.shop, notice: '投票が成功しました。'
        format.html { redirect_to vote_url(@vote), notice: "Vote was successfully created." }
        format.json { render :show, status: :created, location: @vote }
      else
        render :new
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @vote.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /votes/1 or /votes/1.json
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

  # DELETE /votes/1 or /votes/1.json
  def destroy
    @vote.destroy

    respond_to do |format|
      format.html { redirect_to votes_url, notice: "Vote was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vote
      @vote = Vote.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def vote_params
      params.require(:vote).permit(:image, :content, :shop_id, :user_id, :menu_id)
    end
end
