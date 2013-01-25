class ElementsController < ApplicationController

  # GET /elements
  # GET /elements.json
  def index
    @elements = Element.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @elements }
    end
  end

  # GET /elements/1
  # GET /elements/1.json
  def show
    @element = Element.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @element }
    end
  end

  # GET /elements/new
  # GET /elements/new.json
  def new
    @element = Element.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @element }
    end
  end

  # GET /elements/1/edit
  def edit
    @element = Element.find(params[:id])
  end

  # POST /elements
  # POST /elements.json
  def create
    @element = Element.new(params[:element])
    @element.bitmap = params[:upload][:datafile].read
    @element.bitmap = "\x89PNG\r\n\x1A\n\x00\x00\x00\rIHDR\x00\x00\x00(\x00\x00\x00(\x01\x03\x00\x00\x00\xB60*.\x00\x00\x00\x03PLTE\x01\xA8\xB3\x92\x0E\x83:\x00\x00\x00\tpHYs\x00\x00\v\x13\x00\x00\v\x13\x01\x00\x9A\x9C\x18\x00\x00\x00\fIDAT\b\xD7c`\x18Y\x00\x00\x00\xF0\x00\x01\xD7\xB7\x96\xA2\x00\x00\x00\x19tEXtComment\x00Created with GIMPW\x81\x0E\x17\x00\x00\x00%tEXtdate:create\x002013-01-24T20:31:30-08:00\x9E\xC2\xAB\x14\x00\x00\x00%tEXtdate:modify\x002013-01-24T20:31:30-08:00\xEF\x9F\x13\xA8\x00\x00\x00\x00IEND\xAEB`\x82"
    # params[:upload][:datafile].original_filename    # its file name on the client
    # params[:upload][:datafile].content_type.chomp   # something like "image/jpg" or "image/png"

    respond_to do |format|
      if @element.save
        format.html { redirect_to @element, notice: 'Element was successfully created.' }
        format.json { render json: @element, status: :created, location: @element }
      else
        format.html { render action: "new" }
        format.json { render json: @element.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /elements/1
  # PUT /elements/1.json
  def update
    @element = Element.find(params[:id])
    @element.bitmap = params[:upload][:datafile].read
    @element.bitmap = "\x89PNG\r\n\x1A\n\x00\x00\x00\rIHDR\x00\x00\x00(\x00\x00\x00(\x01\x03\x00\x00\x00\xB60*.\x00\x00\x00\x03PLTE\x01\xA8\xB3\x92\x0E\x83:\x00\x00\x00\tpHYs\x00\x00\v\x13\x00\x00\v\x13\x01\x00\x9A\x9C\x18\x00\x00\x00\fIDAT\b\xD7c`\x18Y\x00\x00\x00\xF0\x00\x01\xD7\xB7\x96\xA2\x00\x00\x00\x19tEXtComment\x00Created with GIMPW\x81\x0E\x17\x00\x00\x00%tEXtdate:create\x002013-01-24T20:31:30-08:00\x9E\xC2\xAB\x14\x00\x00\x00%tEXtdate:modify\x002013-01-24T20:31:30-08:00\xEF\x9F\x13\xA8\x00\x00\x00\x00IEND\xAEB`\x82"
    # params[:upload][:datafile].original_filename    # its file name on the client
    # params[:upload][:datafile].content_type.chomp   # something like "image/jpg" or "image/png"

    respond_to do |format|
      if @element.update_attributes(params[:element])
        format.html { redirect_to @element, notice: 'Element was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @element.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /elements/1
  # DELETE /elements/1.json
  def destroy
    @element = Element.find(params[:id])
    @element.destroy

    respond_to do |format|
      format.html { redirect_to elements_url }
      format.json { head :no_content }
    end
  end

  
  def show_bitmap
    @element = Element.find(params[:id])

    send_data(@element.bitmap, :type => 'image/png', :disposition => 'inline')
  end

end



