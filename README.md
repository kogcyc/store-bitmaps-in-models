How To Store Bitmaps In Models
=========

No, you ***do not*** want to store blobs in models.  But if you did...

####1) Assume this opening:

```bash
rails new proj
cd proj
rails g scaffold Element bitmap:binary caption:string
rake db:migrate
```

####2) routes.rb

```ruby
match 'elements/show_bitmap/:id' => 'elements#show_bitmap'
```

####3) elements_controller.rb

```ruby
def create
  @element = Element.new(params[:element])
  @element.bitmap = params[:bitmap].read
  # params[:bitmap].original_filename 
  # params[:bitmap].content_type.chomp # like "image/png"
.
.
.
def update
  @element = Element.find(params[:id])
  @element.bitmap = params[:bitmap].read
  # params[:bitmap].original_filename 
  # params[:bitmap].content_type.chomp # like "image/png"
.
.
.
def show_bitmap
  @element = Element.find(params[:id])
  send_data(@element.bitmap, :type => 'image/png', :disposition => 'inline')
end
```

####4) _form.html.erb    

```html
<script>
$(function() {
   $('form').submit(function() {
      if(!$("form input[type=file]").val()) {
         alert('You must select a file!');
         return false;
      }
   });
});
</script>

<%= form_for(@element, :html => {:multipart => true, :accept => "image/*; capture=camera"}) do |f| %>
.
. 
.
<% if @element.id %>
  <%= image_tag url_for(:controller => "elements", :action => "show_bitmap", :id => @element.id) %>
<% end %>

<div class="field">
  <%= f.label :bitmap %><br />
  <%= file_field_tag 'bitmap' %>
</div>
```

####5) index.html.erb

```ruby
<td><%= image_tag url_for(:controller => "elements", :action => "show_bitmap", :id => element.id) %></td>
```

####6) show.html.erb

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

####8) element.rb
```ruby
class Element < ActiveRecord::Base
  attr_accessible :bitmap, :caption
  validates :bitmap, :presence => true
  validates :caption, :presence => true
end
```
