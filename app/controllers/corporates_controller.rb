class CorporatesController < ApplicationController
  before_action :set_corporate, only: [:show, :edit, :update, :destroy]

  # GET /corporates
  # GET /corporates.json
  def index
    @corporates = Corporate.all
  end

  # GET /corporates/1
  # GET /corporates/1.json
  def show
  end

  # GET /corporates/new
  def new
    @corporate = Corporate.new
  end

  # GET /corporates/1/edit
  def edit
  end

  # POST /corporates
  # POST /corporates.json
  def create
    @corporate = Corporate.new(corporate_params)

    respond_to do |format|
      if @corporate.save
        format.html { redirect_to @corporate, notice: 'Corporate was successfully created.' }
        format.json { render action: 'show', status: :created, location: @corporate }
      else
        format.html { render action: 'new' }
        format.json { render json: @corporate.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /corporates/1
  # PATCH/PUT /corporates/1.json
  def update
    respond_to do |format|
      if @corporate.update(corporate_params)
        format.html { redirect_to @corporate, notice: 'Corporate was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @corporate.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /corporates/1
  # DELETE /corporates/1.json
  def destroy
    @corporate.destroy
    respond_to do |format|
      format.html { redirect_to corporates_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_corporate
      @corporate = Corporate.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def corporate_params
      params.require(:corporate).permit(:id, :name, :status, :key)
    end
end
