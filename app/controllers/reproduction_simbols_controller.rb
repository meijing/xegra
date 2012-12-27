class ReproductionSimbolsController < ApplicationController
  # GET /reproduction_simbols
  # GET /reproduction_simbols.json
  def index
    @reproduction_simbols = ReproductionSimbol.all
  end

  # GET /reproduction_simbols/1
  # GET /reproduction_simbols/1.json
  def show
    @reproduction_simbol = ReproductionSimbol.find(params[:id])
  end

  # GET /reproduction_simbols/new
  # GET /reproduction_simbols/new.json
  def new
    @reproduction_simbol = ReproductionSimbol.new
  end

  # GET /reproduction_simbols/1/edit
  def edit
    @reproduction_simbol = ReproductionSimbol.find(params[:id])
  end

  # POST /reproduction_simbols
  # POST /reproduction_simbols.json
  def create
    @reproduction_simbol = ReproductionSimbol.new(params[:reproduction_simbol])

    respond_to do |format|
      if @reproduction_simbol.save
        format.html { redirect_to @reproduction_simbol, notice: 'Reproduction simbol was successfully created.' }
        format.json { render json: @reproduction_simbol, status: :created, location: @reproduction_simbol }
      else
        format.html { render action: "new" }
        format.json { render json: @reproduction_simbol.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /reproduction_simbols/1
  # PUT /reproduction_simbols/1.json
  def update
    @reproduction_simbol = ReproductionSimbol.find(params[:id])

    respond_to do |format|
      if @reproduction_simbol.update_attributes(params[:reproduction_simbol])
        format.html { redirect_to @reproduction_simbol, notice: 'Reproduction simbol was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @reproduction_simbol.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reproduction_simbols/1
  # DELETE /reproduction_simbols/1.json
  def destroy
    @reproduction_simbol = ReproductionSimbol.find(params[:id])
    @reproduction_simbol.destroy
  end
end
