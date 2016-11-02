class TokensController < ApplicationController
  before_action :set_token, only: [:show, :edit, :update, :destroy]

  # GET /tokens
  # GET /tokens.json
  def index
    sanchaypatra = Sanchaypatra.find(params[:sanchaypatra_id])
    @tokens = sanchaypatra.tokens
    if params[:filter].present?
      if params[:filter][:redemption].present?
        @tokens = @tokens.where(:is_redeemed => true) if params[:filter][:redemption] == "redeemed"
        @tokens = @tokens.where(:is_redeemed => false) if params[:filter][:redemption] == "not_redeemed"
      end
      @tokens = @tokens.where("token_date <= ?", params[:filter][:till_date]) if params[:filter][:till_date].present?
    else
      @tokens
    end
    @tokens = @tokens.order(:token_number)
  end

  # GET /tokens/1
  # GET /tokens/1.json
  def show
  end

  # GET /tokens/new
  def new
    @token = Token.new
  end

  # GET /tokens/1/edit
  def edit
  end

  # POST /tokens
  # POST /tokens.json
  def create
    @token = Token.new(token_params)

    respond_to do |format|
      if @token.save
        format.html { redirect_to tokens_url(:sanchaypatra => @token.sanchaypatra), notice: 'Token was successfully created.' }
        format.json { render :show, status: :created, location: @token }
      else
        format.html { render :new }
        format.json { render json: @token.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tokens/1
  # PATCH/PUT /tokens/1.json
  def update
    respond_to do |format|
      if @token.update(token_params)
        format.html { redirect_to tokens_url(:sanchaypatra_id => @token.sanchaypatra_id), notice: 'Token was successfully updated.' }
        format.json { render :show, status: :ok, location: @token }
      else
        format.html { render :edit }
        format.json { render json: @token.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tokens/1
  # DELETE /tokens/1.json
  def destroy
    sanchaypatra = @token.sanchaypatra
    @token.destroy
    respond_to do |format|
      format.html { redirect_to tokens_url(:sanchaypatra => sanchaypatra), notice: 'Token was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_token
    @token = Token.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def token_params
    #params.require(:token).permit(:sanchaypatra_id, :token_number, :token_date, :is_redeemed)
    params.require(:token).permit!
  end
end
