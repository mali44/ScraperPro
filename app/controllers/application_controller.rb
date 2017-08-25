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



  def index_post

      page_links=nil
      puts params[:comment]
      all_links = Array.new(0)
      title= Array.new(0)
      description=Array.new(0)
      links= params[:comment].split(/\n+/).each do |w|
      page_links = scrape_first(w.strip.to_s)
      all_links.push(page_links).each do |tl|
      title.push(scrape_title(w.strip.to_s))
      description.push(scrape_desc(w.strip.to_s))
      end
      puts all_links



        end
        @page_links=all_links
        @title= title
        @desc=description



    render 'index'


    end

    def scrape_first(url)


      page = MetaInspector.new(url)
      all_links=page.links.all

      return all_links


    rescue Exception => e
      false

  end

  def scrape_title(url)


      page = MetaInspector.new(url)
      title= page.title

      return title


    rescue Exception => e
      false

  end


    def scrape_desc(url)


        page = MetaInspector.new(url)
        desc= page.best_description

        return desc


      rescue Exception => e
        false

    end




    #  doc = Nokogiri::HTML(open("http://muhammetaliariturk.com/"))
    #  render plain: doc



end
