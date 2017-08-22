class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  require 'uri'


  # def scrape_upload
  #   render plain: 'a'
  #
  #   file = File.open("log2.txt", "r")
  #   contents = file.read
  #   puts contents   #=> Lorem ipsum etc.
  #
  #   render plain: contents
  #



  def index
    render 'index'

  end

  def url_valid?(url)
   url = URI.parse(url) rescue false
   url.kind_of?(URI::HTTP) || url.kind_of?(URI::HTTPS)

 end

  def index_post


    puts params[:comment]
    links= params[:comment].split(/\n+/).each do |w|
      page_links = scrape_first(w.strip.to_s)
      @page_links = page_links
  end
  render 'index'


  end

  def scrape_first(url)

    begin
      page = MetaInspector.new(url).to_s
      match = page.scan(/href\s*=\s*"([^"]*)"/)
      return match
    rescue Exception => e
      false
    end
  end


    #  doc = Nokogiri::HTML(open("http://muhammetaliariturk.com/"))
    #  render plain: doc



end
