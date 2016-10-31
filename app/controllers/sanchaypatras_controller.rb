class SanchaypatrasController < ApplicationController
  before_action :set_sanchaypatra, only: [:show, :edit, :update, :destroy]

  # GET /sanchaypatras
  # GET /sanchaypatras.json
  def index
    @sanchaypatras = Sanchaypatra.all
  end

  # GET /sanchaypatras/1
  # GET /sanchaypatras/1.json
  def show
  end

  # GET /sanchaypatras/new
  def new
    @sanchaypatra = Sanchaypatra.new
  end

  # GET /sanchaypatras/1/edit
  def edit
  end

  # POST /sanchaypatras
  # POST /sanchaypatras.json
  def create
    @sanchaypatra = Sanchaypatra.new(sanchaypatra_params)
    redeem_dates = []
    redeem_months = ((@sanchaypatra.active_date+1.day) .. @sanchaypatra.expire_date).map{|d| [d.year, d.month]}.uniq
    redeem_months.each do |year,month|
      if Date.valid_date?(year,month,@sanchaypatra.active_date.day)
        redeem_dates << Date.new(year,month,@sanchaypatra.active_date.day)
      else
        redeem_dates << Date.new(year,month,1).next_month
      end
    end
    redeem_dates = redeem_dates.every_nth(@sanchaypatra.interval_month)
    redeem_dates.each_with_index do |date,index| # 1 day added to avoid the first date
        token = Token.new
        token.token_number = index+1
        token.token_date = date
        @sanchaypatra.tokens << token
    end

    respond_to do |format|
      if @sanchaypatra.save
        format.html { redirect_to @sanchaypatra, notice: 'Sanchaypatra was successfully created.' }
        format.json { render :show, status: :created, location: @sanchaypatra }
      else
        format.html { render :new }
        format.json { render json: @sanchaypatra.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sanchaypatras/1
  # PATCH/PUT /sanchaypatras/1.json
  def update
    respond_to do |format|
      if @sanchaypatra.update(sanchaypatra_params)
        format.html { redirect_to @sanchaypatra, notice: 'Sanchaypatra was successfully updated.' }
        format.json { render :show, status: :ok, location: @sanchaypatra }
      else
        format.html { render :edit }
        format.json { render json: @sanchaypatra.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sanchaypatras/1
  # DELETE /sanchaypatras/1.json
  def destroy
    @sanchaypatra.destroy
    respond_to do |format|
      format.html { redirect_to sanchaypatras_url, notice: 'Sanchaypatra was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_sanchaypatra
    @sanchaypatra = Sanchaypatra.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def sanchaypatra_params
    params.require(:sanchaypatra).permit(:reg_number, :issue_date, :amount, :profit_per_lac, :active_date, :expire_date, :profilt_percentage,:interval_month)
  end
end
