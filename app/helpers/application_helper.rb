module ApplicationHelper

  #generate appropriate page title
  def title
    base_title = "Ruby on Rails Tutorial Sample App"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end

  #set link to logo (logo helper)
  def logo
    logo = image_tag("logo.png", :alt => "Sample App", :class => "round")
   end
end
