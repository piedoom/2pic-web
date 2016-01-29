class Api::V1::TraitsController < ApplicationController
  before_action :set_trait, only: [:show, :update, :destroy]

  # get traits of a selected user
  # /api/v1/traits?user_id=9
  def index
    params[:user_id] ? user = User.find(params[:user_id]) : user = current_user
    @traits = user.traits
    render 'api/v1/traits/index'
  end

  # GET /traits/:id
  def show
    render 'api/v1/traits/show'
  end

  # POST /traits
  # POST /traits.json
  def create
    @trait = Trait.new(trait_params)
    @trait.user = current_user

    if @trait.save
      render :show, status: :created
    else
      render json: @trait.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /traits/1
  # PATCH/PUT /traits/1.json
  def update
    if current_user == @trait.user
      if @trait.update(trait_params)
        render :show, status: :ok
      else
        render json: @trait.errors, status: :unprocessable_entity
      end
    end
  end

  # DELETE /traits/1
  # DELETE /traits/1.json
  def destroy
    if current_user == @trait.user
      @trait.destroy
        render status: :ok
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_trait
      @trait = Trait.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def trait_params
      params.require(:trait).permit(:trait)
    end
end
