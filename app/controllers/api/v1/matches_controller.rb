class Api::V1::MatchesController < ApplicationController
  before_action :set_match, only: [:show, :update, :destroy]

  # GET /matches/1
  # GET /matches/1.json
  def show
  end

  # POST /matches
  # send auth header
  # send opposing user id
  def create
    @match = Match.new(match_params)
    @match.user = current_user

    if @match.save
      APNS.send_notification(User.find(@match.target_user_id).key, alert: 'You\'ve been challenged.')
      render :show, status: :created
    else
      render json: @match.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /matches/1
  # PATCH/PUT /matches/1.json
  def update
    if @match.update(match_params)
      render :show, status: :ok
    else
      render json: @match.errors, status: :unprocessable_entity
    end
  end

  # DELETE /matches/1
  # DELETE /matches/1.json
  def destroy
    @match.destroy
    head :no_content
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_match
      @match = Match.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def match_params
      params.require(:match).permit(:target_user_id)
    end
end
