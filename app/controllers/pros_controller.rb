class ProsController < ApplicationController
  # GET /pros
  # GET /pros.json
  def index
    @pros = Pro.limit(20)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @pros }
    end
  end

  # root route
  def search
    @pros = Pro.limit(20)
  end

  # GET /search/:search_term
  def find
    if params[:search_term].present?
      @search = params[:search_term]
      @pros = Pro.near(@search, 10)
    else
      @search = ""
      @pros = Pro.limit(20)
    end
    # puts @search
    # @search_query = @search.to_query
    @image_tag_string = "http://maps.google.com/maps/api/staticmap?key=AIzaSyC77WBfl-zki0vS7h9zyKyYg3htKcERvuo&size=600x500&sensor=false&zoom=11"
    i = 0
    @pros.each do |pro|
      if !pro.latitude.nil?
        # markers=color:blue%7Clabel:S%7C62.107733,-145.541936
        i+=1
        if i==1
          # @image_tag_string << "&center=#{pro.latitude}%2C#{pro.longitude}"
          @image_tag_string << "&center=#{@search_term}"
        end
        @image_tag_string << "&markers=label:#{i}%7Ccolor:blue%7C#{pro.latitude}%2C#{pro.longitude}"
      end
    end
    # puts @image_tag_string.to_query
  end

  # GET /pros/1
  # GET /pros/1.json
  def show
    @pro = Pro.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @pro }
    end
  end

  # GET /pros/new
  # GET /pros/new.json
  def new
    @pro = Pro.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @pro }
    end
  end

  # GET /pros/1/edit
  def edit
    @pro = Pro.find(params[:id])
  end

  # POST /pros
  # POST /pros.json
  def create
    @pro = Pro.new(params[:pro])

    respond_to do |format|
      if @pro.save
        format.html { redirect_to @pro, notice: 'Pro was successfully created.' }
        format.json { render json: @pro, status: :created, location: @pro }
      else
        format.html { render action: "new" }
        format.json { render json: @pro.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /pros/1
  # PUT /pros/1.json
  def update
    @pro = Pro.find(params[:id])

    respond_to do |format|
      if @pro.update_attributes(params[:pro])
        format.html { redirect_to @pro, notice: 'Pro was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @pro.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pros/1
  # DELETE /pros/1.json
  def destroy
    @pro = Pro.find(params[:id])
    @pro.destroy

    respond_to do |format|
      format.html { redirect_to pros_url }
      format.json { head :no_content }
    end
  end
end
