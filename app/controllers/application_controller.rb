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
      best_title=Array.new(0)
      scrape_Image=Array.new(0)

      links= params[:comment].split(/\n+/).each do |w|
      page_links = scrape_first(w.strip.to_s)
      all_links.push(page_links).each do |tl|
      title.push(scrape_title(w.strip.to_s))
      description.push(scrape_desc(w.strip.to_s))
      best_title.push(scrape_best_title(w.strip.to_s))
      @scrimage=scrape_image(w.strip.to_s)

      end
      ##puts all_link



        end

        @page_links=all_links
        @title= title
        @description=description
        @best_title=best_title




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

        puts "HEYYYYYYYYYYYYYYYYYYYYYYYYYY"
        page = MetaInspector.new(url)
        desc= page.description

        return desc


      rescue Exception => e

        puts "Site aciklamasi #{desc}"
        puts "Hatali ARAMAA! #{url}"

    end

    def scrape_best_title(url)
      page= MetaInspector.new(url)
      best_title=page.best.title

      return best_title
    rescue Exception => e
      false

    end

    def scrape_image (url)
      page = MetaInspector.new(url)
      images=page.images

      page.images.each do |link|
      puts " ==> #{link}"
    end

      return images
    end





    #  doc = Nokogiri::HTML(open("http://muhammetaliariturk.com/"))
    #  render plain: doc



end
