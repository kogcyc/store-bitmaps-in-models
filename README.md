How To Store Bitmaps In Models
=========

No, you don't want to store blobs in models.  But if you did...

####1) Assume this opening:

    rails new proj
    cd proj
    rails g scaffold Element bitmap:binary caption:string
    rake db:migrate

####2) routes.rb

    ```ruby
    match 'elements/show_bitmap/:id' => 'elements#show_bitmap'
    ```

####3) elements_controller.rb

    ```ruby
    def create
      @element = Element.new(params[:element])
      @element.bitmap = params[:upload][:datafile].read
      # params[:upload][:datafile].original_filename 
      # params[:upload][:datafile].content_type.chomp # like "image/png"
    .
    .
    .
    def update
      @element = Element.find(params[:id])
      @element.bitmap = params[:upload][:datafile].read
      # params[:upload][:datafile].original_filename 
      # params[:upload][:datafile].content_type.chomp # like "image/png"
    .
    .
    .
    def show_bitmap
      @element = Element.find(params[:id])
      send_data(@element.bitmap, :type => 'image/png', :disposition => 'inline')
    end
    ```

####4) _form.html.erb    

    ```ruby
    <%= form_for(@element, :html => {:multipart => true, :accept => "image/*; capture=camera"}) do |f| %>
    .
    . 
    .
    <% if @element.id %>
      <%= image_tag url_for(:controller => "elements", :action => "show_bitmap", :id => @element.id) %>
    <% end %>

    <div class="field">
      <%= f.label :bitmap %><br />
      <%= file_field 'upload', 'datafile' %>
    </div>
    ```

####5) index.html.erc

    ```ruby
    <td><%= image_tag url_for(:controller => "elements", :action => "show_bitmap", :id => element.id) %></td>
    ```

####6) show.html.erc

    ```ruby
    <p>
      <b>Bitmap:</b>
      <%= image_tag url_for(:controller => "elements", :action => "show_bitmap", :id => @element.id) %>
    </p>
    ```

####7) elements.css.scss

    ```css
    img {
      max-width: 200px;
    }
    ```

