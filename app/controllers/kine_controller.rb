class KineController < ApplicationController
  # GET /kine
  # GET /kine.json
  def index
    @kine = Cow.order('short_ring').where('is_active=1').page(params[:page]).per(15)
    
    respond_to do |format|
      format.html # index.html.erb
    end
  end
  
  # GET /kine/1
  # GET /kine/1.json
  def show
    @cow = Cow.find(params[:id])
    @reproductions = Reproduction.find_by_cow_id(@cow.id)

    @last_insemination = Reproduction.where('cow_id = '+@cow.id.to_s+' and date = (select max(date) from reproductions where cow_id = '+@cow.id.to_s+' and reproduction_simbol_id = 11)')

    if @last_insemination != []
      @num_months_pregnant = DateTime.now.month - @last_insemination[0].date.month
      p '---------------'
      p @num_months_pregnant
      if @num_months_pregnant<=9
        @previous_lactation = @last_insemination[0].date.advance(:months=>7)
        @previous_parturition = @last_insemination[0].date.advance(:months=>9)
      else
        @last_insemination = []
      end
    end
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @cow }
    end
  end

  # GET /kine/new
  # GET /kine/new.json
  def new
    @cow = Cow.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @cow }
    end
  end

  # GET /kine/1/edit
  def edit
    @cow = Cow.find(params[:id])
    @cow.date_born = @cow.date_born.strftime('%d/%m/%Y')
  end

  # POST /kine
  # POST /kine.json
  def create
    @cow = Cow.new(params[:cow])
    @cow.is_active=1
    @cow.short_ring = @cow.ring[0..3]
    respond_to do |format|
      if @cow.save
        format.html { redirect_to @cow, notice: 'Cow was successfully created.' }
        format.json { render json: @cow, status: :created, location: @cow }
      else
        format.html { render action: "new" }
        format.json { render json: @cow.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /kine/1
  # PUT /kine/1.json
  def update
    @cow = Cow.find(params[:id])
    @cow.short_ring = @cow.ring[0..3]
    respond_to do |format|
      if @cow.update_attributes(params[:cow])
        format.html { redirect_to @cow, notice: 'Cow was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @cow.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /kine/1
  # DELETE /kine/1.json
  def destroy
    @cow = Cow.find(params[:id])
    @cow.is_active = 0
    #@cow.date_down = Time.new
    @cow.save

    respond_to do |format|
      format.html { redirect_to kine_url }
      format.json { head :no_content }
    end
  end

end
