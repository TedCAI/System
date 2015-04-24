class ActiclesController < ApplicationController
  before_action :set_acticle, only: [:show, :edit, :update, :destroy]
  require 'mechanize'
  # GET /acticles
  # GET /acticles.json
  def index
    @acticles = Acticle.all
  end

  # GET /acticles/1
  # GET /acticles/1.json
  def show
  end

  # GET /acticles/new
  def new
    @acticle = Acticle.new
  end

  # GET /acticles/1/edit
  def edit
  end

  # POST /acticles
  # POST /acticles.json
  def create
    @acticle = Acticle.new(acticle_params)

    respond_to do |format|
      if @acticle.save
        format.html { redirect_to @acticle, notice: 'Acticle was successfully created.' }
        format.json { render :show, status: :created, location: @acticle }
      else
        format.html { render :new }
        format.json { render json: @acticle.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /acticles/1
  # PATCH/PUT /acticles/1.json
  def update
    respond_to do |format|
      if @acticle.update(acticle_params)
        format.html { redirect_to @acticle, notice: 'Acticle was successfully updated.' }
        format.json { render :show, status: :ok, location: @acticle }
      else
        format.html { render :edit }
        format.json { render json: @acticle.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /acticles/1
  # DELETE /acticles/1.json
  def destroy
    @acticle.destroy
    respond_to do |format|
      format.html { redirect_to acticles_url, notice: 'Acticle was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def search
	#p params[:search]
	industryId = nil
	if params[:search].nil?
		industryId = "i257"
	else
		industryId = Acticle.searchActicle(params[:search])
	end

	agent = Mechanize::new
	page = agent.get("http://api.beta.dowjones.com/api/public/2.0/Content/Headlines/json?SearchString=(in=#{industryId}%20and%20ns=NFCPIN%20and%20rst=(TMNB%20or%20TNWP%20or%20TFCP%20or%20i257)%20and%20wc%3E700)%20or%20ns=REQRPH&searchmode=Traditional&Records=10&DeDuplicationLevel=NearExact&LanguageCode=en&SortBy=DisplayDateTime&SortOrder=Descending&encryptedToken=S00ZGV71GFm0TEnMXmnOHmnNDIvN9avODQt5DByWa3WNpFHRcqmVEVkTVFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUEA")
	@tempResult = []
	@tempShortAc = []
	tResult = JSON.load(page.body)["Headlines"]
	tResult.each do |r|
		tRes = r["Title"].first["Items"].first["Value"]
		loop do
			startIndex = tRes.index('<')
			endIndex = tRes.index('>')
			if startIndex.nil? or endIndex.nil?
				break
			end
			tRes.slice! tRes[startIndex..endIndex]
		end
		@tempResult.push(tRes)
		@tempShortAc.push(r["Snippet"]["Items"].first["Value"])
#		@tempResult.push(r)
	end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_acticle
      @acticle = Acticle.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def acticle_params
      params.require(:acticle).permit(:request_link, :acticle_id, :title)
    end
end
