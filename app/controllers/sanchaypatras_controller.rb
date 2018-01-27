class SanchaypatrasController < ApplicationController
  before_action :set_sanchaypatra, only: [:show, :edit, :update, :destroy, :regenerate_tokens]

  # GET /sanchaypatras
  # GET /sanchaypatras.json
  def index
    sanchaypatras =  current_user.sanchaypatras.not_expired
    sanchaypatras =  sanchaypatras.where("reg_number ilike ?","%#{params[:reg_number]}%") if params[:reg_number].present?
    sanchaypatras =  sanchaypatras.where("owner_name ilike ?","%#{params[:owner_name]}%") if params[:owner_name].present?
    @sanchaypatras_in_groups = sanchaypatras.order(:active_date).group_by(&:interval_month)
  end

  def expired
    sanchaypatras =  current_user.sanchaypatras.expired
    sanchaypatras =  sanchaypatras.where("reg_number ilike ?","%#{params[:reg_number]}%") if params[:reg_number].present?
    sanchaypatras =  sanchaypatras.where("owner_name ilike ?","%#{params[:owner_name]}%") if params[:owner_name].present?
    @sanchaypatras_in_groups = sanchaypatras.order(:active_date).group_by(&:interval_month)
  end

  # GET /sanchaypatras/1
  # GET /sanchaypatras/1.json
  def show
  end

  # GET /sanchaypatras/new
  def new
    @sanchaypatra = current_user.sanchaypatras.new
    @sanchaypatra.active_date = Time.now
    @sanchaypatra.expire_date = Time.now + 3.years
  end

  # GET /sanchaypatras/1/edit
  def edit
  end

  # POST /sanchaypatras
  # POST /sanchaypatras.json
  def create
    @sanchaypatra = current_user.sanchaypatras.new(sanchaypatra_params)
    @sanchaypatra.generate_tokens

    respond_to do |format|
      if @sanchaypatra.save
        format.html { redirect_to sanchaypatras_url, notice: 'Sanchaypatra was successfully created.' }
        format.json { render :show, status: :created, location: @sanchaypatra }
      else
        format.html { render :new }
        format.json { render json: @sanchaypatra.errors, status: :unprocessable_entity }
      end
    end
  end

  def regenerate_tokens
    @sanchaypatra.generate_tokens
    respond_to do |format|
      if @sanchaypatra.save
        format.html { redirect_to sanchaypatras_url, notice: 'Tokens was successfully regenerated.' }
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
        format.html { redirect_to sanchaypatras_url, notice: 'Sanchaypatra was successfully updated.' }
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

  def redeemable
    @till_date = params["till_date(1i)"].present? ? Date.new(params["till_date(1i)"].to_i, params["till_date(2i)"].to_i, params["till_date(3i)"].to_i) : Time.now
    @sanchaypatras = current_user.sanchaypatras.includes(:tokens).where("tokens.is_redeemed = ? and tokens.token_date <= ?",false,@till_date).references(:tokens)
    @sanchaypatras =  @sanchaypatras.where("owner_name ilike ?","%#{params[:owner_name]}%") if params[:owner_name].present?
    @total_redeemable_amount = @sanchaypatras.collect{|s| s.tokens.length*s.profit_per_lac.to_f}.sum
    @sanchaypatras_in_groups = @sanchaypatras.order(:active_date).group_by(&:interval_month)
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_sanchaypatra
    @sanchaypatra = current_user.sanchaypatras.find(params[:id] || params[:sanchaypatra_id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def sanchaypatra_params
    #params.require(:sanchaypatra).permit(:reg_number, :issue_date, :amount, :profit_per_lac, :active_date, :expire_date, :profilt_percentage,:interval_month)
    params.require(:sanchaypatra).permit!
  end
end
