class BidsController < ApplicationController
  before_action :set_bid, only: [:show, :edit, :update, :destroy]

  # GET /bids
  # GET /bids.json
  def index
    @bids = Bid.all
  end

  # GET /bids/1
  # GET /bids/1.json
  def show
  end

  # GET /bids/new
  def new
    @bid = Bid.new
@bid.installments.build
#     if bid.project_id.empty?
#   @bid = Bid.new
# @bid.installments.new
# else
#   redirect_to startup_path
# end
end


  # GET /bids/1/edit
  def edit
  end

  # POST /bids
  # POST /bids.json
  def create
@bid = Bid.new(bid_params)
@project =Project.find(params[:bid][:project_id])

@bid_exist = Bid.where("user_id=? AND project_id =?",current_user.id,@project.id)
    @startup = ClientPreference.where("user_id=? AND startup_status_id =?",current_user.id,4)
  if @bid_exist.count
@bid_installment = Installment.where(:bid_id => @bid_exist)
end

@project_accept_button = ClientPreference.where("user_id=? AND project_id =?",current_user.id,@project.id)

if @project_accept_button.count

@project_accept = @project_accept_button.where(:startup_status_id => 4)

end



respond_to do |format|
      if @bid.save
     format.html { redirect_to startup_url , notice: 'Bid was successfully created.' }
        format.json { render :show, status: :created, location: @bids }
      else
       
        format.html { render '/startup/project_page'}
        format.json { render json: @bid.errors, status: :unprocessable_entity }
    end
  end
end
  # PATCH/PUT /bids/1
  # PATCH/PUT /bids/1.json
  def update
    respond_to do |format|
      if @bid.update(bid_params)
        format.html { redirect_to @bid, notice: 'Bid was successfully updated.' }
        format.json { render :show, status: :ok, location: @bid }
      else
        format.html { render :edit }
        format.json { render json: @bid.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bids/1
  # DELETE /bids/1.json
  def destroy
    @bid.destroy


    respond_to do |format|
      if @bids.destroy
      format.html { redirect_to bids_url, notice: 'Bid was successfully destroyed.' }
      format.json { head :no_content }
      format.js  
   end
  end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bid
      @bid = Bid.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bid_params
      params.require(:bid).permit(:id,:project_id,:user_id,installments_attributes: [:bid_id,:time,:budget,:details,:_destroy])
    end
end
