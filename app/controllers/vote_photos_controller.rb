class VotePhotosController < ApplicationController
  before_action :set_vote_photo, only: %i[ show edit update destroy ]

  # GET /vote_photos or /vote_photos.json
  def index
    @vote_photos = VotePhoto.all
  end

  # GET /vote_photos/1 or /vote_photos/1.json
  def show
  end

  # GET /vote_photos/new
  def new
    @vote_photo = VotePhoto.new
  end

  # GET /vote_photos/1/edit
  def edit
  end

  # POST /vote_photos or /vote_photos.json
  def create
    @vote_photo = VotePhoto.new(vote_photo_params)

    respond_to do |format|
      if @vote_photo.save
        format.html { redirect_to vote_photo_url(@vote_photo), notice: "Vote photo was successfully created." }
        format.json { render :show, status: :created, location: @vote_photo }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @vote_photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /vote_photos/1 or /vote_photos/1.json
  def update
    respond_to do |format|
      if @vote_photo.update(vote_photo_params)
        format.html { redirect_to vote_photo_url(@vote_photo), notice: "Vote photo was successfully updated." }
        format.json { render :show, status: :ok, location: @vote_photo }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @vote_photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /vote_photos/1 or /vote_photos/1.json
  def destroy
    @vote_photo.destroy

    respond_to do |format|
      format.html { redirect_to vote_photos_url, notice: "Vote photo was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vote_photo
      @vote_photo = VotePhoto.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def vote_photo_params
      params.require(:vote_photo).permit(:image, :content, :vote_id)
    end
end
