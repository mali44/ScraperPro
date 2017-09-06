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

      best_title=Array.new(0)
      scrape_Image=Array.new(0)

      links= params[:comment].split(/\n+/).each do |w|
      page_links = scrape_first(w.strip.to_s)
      @scrimage=scrape_image(w.strip.to_s)

      puts "Aciklama Site  #{@description} "

    end

      #
      # all_links.each do |t|
      #   t.each do |t2|
      #     puts "_____________________#{title.push(scrape_title(t2))}"
      #
      #   end


      ##puts all_link


        @page_links=page_links
        # @title= title

        # puts "aaa =#{@best_title}"
        # page2=MetaInspector.new("https://twitter.com/MediaCat ")
        # btitle=page2.best_title
        # puts "BEST TITLE = #{btitle}"



    render 'index'


    end

    def scrape_first(url)

      #
              # page = MetaInspector.new(url)

        page = MetaInspector.new(url)
        title= Array.new(0)
        desc= Array.new
        puts "\nScraping #{page.url} returned these results:"
        puts "\nTITLE: #{page.title} "
        desc.push(page.description)
        title.push(page.title)
        puts "META DESCRIPTION: #{page.meta['description']}"
        puts "META KEYWORDS: #{page.meta['keywords']}"

        puts "\n#{page.links.internal.size} internal links found..."
        page.links.internal.each do |link|
          puts " ==> #{link}"
          @description=desc.push(scrape_desc(link))
          @title=title.push(scrape_title(link))



        end
        @internallinks= page.links.internal

        puts "\n#{page.links.external.size} external links found..."
        page.links.external.each do |link|
          puts " ==> #{link}"
        end


        puts " OKEY PUT IT #{title}"

        puts "\n#{page.links.non_http.size} non-http links found..."
        page.links.non_http.each do |link|
          puts " ==> #{link}"

        end



        puts "\nto_hash..."
        puts page.to_hash





    rescue Exception => e
      false

  end



    def scrape_desc(url)

        page = MetaInspector.new(url)
        desc= page.description
        puts " LOOK #{desc}"
        return desc


      rescue Exception => e

        puts "Site aciklamasi #{desc}"
        puts "Hatali ARAMAA! #{url}"

    end

    def scrape_title(url)
      page= MetaInspector.new(url)


      return title
    rescue Exception => e
      false

    end

    def scrape_image (url)
      page = MetaInspector.new(url)
      images=page.images



      return images
    rescue Exception => e
      false

    end
end
