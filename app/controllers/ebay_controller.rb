class EbayController < ApplicationController
  include EbayHelper

  require 'net/http'
  require 'json'

  require 'openssl'
  require 'nokogiri'
  require 'open-uri'

  require 'selenium-webdriver'
  require 'capybara'

  def index
  end

  def add_item
    doc = crawl_aliexpress
    token = "AgAAAA**AQAAAA**aAAAAA**x0+QXA**nY+sHZ2PrBmdj6wVnY+sEZ2PrA2dj6ADloOoCZCHoQydj6x9nY+seQ**8toFAA**AAMAAA**GUveEELf6OyzywF1LZ2AxnLxoiLtqd0fUFtlgBBHlFcJq+f4tYfRp6Hu/u3otqXoxamaN2dNjjZxAXfFvCgEYKyW40ZZFLlb2Pnql1rQmrNRILlBWp/W6JMu7NgLPUm4u0rGujHC36FFU+2AsFdq3RUulbUYXWcJmxgeRYKQYbIVYj6+3dTzbK29OS0dZW4G10ekYLN81//OWdVHL/s208sF6YDxfljGJa2gXEFxLZcHpa4GnVLhLiTqMnP7PF7EPPVT8k540EoVFoShsjJ7XGFE5hdaR+TRXY5l5g/kaGPYrOOxvSHEgK2LELx5q1TlIX9LY25bA4y4xtJwCuOXCKdjN1lJAugAartDhsyFaFNI3sn+4+N43O9VwyJv9Yez+ycQSuTVnnIbB7yO/wvW5DuAVRGMTmzeamStTyoRVplkDLGoumCIhgDX4s52aSuD9MJaKBoJIJmwBi1tNjILeQfQsAb+zT0UTMJ8yF+/yy/Xu517mbyvfEuu3eTnVMMaXwNTDdNC2bcICUX22/sBVRj+qRpJFkuVTVTx9pVZvOJfwjw6HTC53BNkJ7xb/hHT0Rp6aHKbqsJ5D2yRPZX5FxThwO8yp7pbiiDVJthYCyUEheKVaSO/Z2uM7kvRUXZi2C0eQQ94SWik+tjto2LDHZXUUXgqIOPeQb46rnh0F5NmoS1OOpAlV/XghGyAYPHg6qY+fsabmldkPgA3SLCUik4NmArm2+HdAS7G48wr8uJkxphmeVtGvf3KTqLM8iLv"
    #----------------------------------------------------------------------------------------------------------------

    itemSpecificHash = Hash.new
    doc.css('ul.product-property-list li').each do |el|
      itemSpecificHash[el.css('span.propery-title').text] = el.css('span.propery-des').text
    end

    packageDetailHash = Hash.new
    doc.css('ul.product-packaging-list li').each do |el|
      packageDetailHash[el.css('span.packaging-title').text] = el.css('span.packaging-des').text
    end


    # mainImageUrl = doc.css('img#poster').attr('src').value
    mainImageUrl = doc.css('a.ui-image-viewer-thumb-frame img').attr('src').value
    altMainImage = doc.css('a.ui-image-viewer-thumb-frame img').attr('alt').value
    title = doc.css('h1.product-name').text
    valid_title = get_valid_title title
    image_thumb_list = ""
    doc.css('ul.image-thumb-list li').each do |img|
      image_thumb_list += '<PictureURL>' + img.css('img').attr('src').value.gsub('.jpg_50x50', '') + '</PictureURL>'
    end

    # Remove unnecessary element
    doc.search('.//widget').each do |node|
      node.remove
    end

    # Remove image
    doc.search('.//img').each do |node|
      node.remove
    end

    doc.css('*').remove_attr('style')

    description = ""
    doc.css('div.description-content').each do |n|
      description += n.inner_html
    end

    @description = get_decription title, altMainImage, mainImageUrl, itemSpecificHash, packageDetailHash, description


    # @description = doc.search('.//span').each do |node|
    #   puts '<span><li>' + node.text + '</li><span>'
    # end
    #

    render "index"


    #GET SUGGESTED CATEGORIES
    #---------------------------------------------------------------------------------------------------------------------------------------------
    # begin
    #   # uri = URI("https://api.ebay.com/ws/api.dll")
    #   uri = URI("https://api.ebay.com/ws/api.dll")
    #   http = Net::HTTP.new(uri.host, uri.port)
    #   http.use_ssl = true if uri.scheme == 'https'
    #
    #   req = Net::HTTP::Post.new(
    #       uri.path,
    #       {'Content-Type' => 'text/xml', 'X-EBAY-API-COMPATIBILITY-LEVEL' => '911', 'X-EBAY-API-SITEID' => '0', 'X-EBAY-API-CALL-NAME' => 'GetSuggestedCategories'}
    #   )
    #   # req.body = {"token" => "15fdba59ecd6ccf9fc93c2b785721bc2952521b1877d95e5"}.to_json
    #   req.body = get_suggested_item_req token, title
    #
    #   res = http.request(req)
    #
    #   case res
    #   when Net::HTTPSuccess, Net::HTTPRedirection
    #     # OK
    #     categoryId = get_suggested_category_id res.body
    #
    #     #ADD ITEM
    #     #-------------------------------------------------------------------------------------------------------------------------------------------------
    #     begin
    #       # uri = URI("https://api.ebay.com/ws/api.dll")
    #       http = Net::HTTP.new(uri.host, uri.port)
    #       http.use_ssl = true if uri.scheme == 'https'
    #
    #       req = Net::HTTP::Post.new(
    #           uri.path,
    #           {'Content-Type' => 'text/xml', 'X-EBAY-API-COMPATIBILITY-LEVEL' => '911', 'X-EBAY-API-SITEID' => '0', 'X-EBAY-API-CALL-NAME' => 'AddItem'}
    #       )
    #       # req.body = {"token" => "15fdba59ecd6ccf9fc93c2b785721bc2952521b1877d95e5"}.to_json
    #       # request log
    #       logger.info add_item_req token, valid_title, description, categoryId, image_thumb_list
    #
    #       req.body = add_item_req token, valid_title, description, categoryId, image_thumb_list
    #
    #       res = http.request(req)
    #
    #       case res
    #       when Net::HTTPSuccess, Net::HTTPRedirection
    #         # OK
    #         byebug
    #       else
    #         res.value
    #       end
    #     end
    #
    #   else
    #     res.value
    #   end
    # end
    #END -------------------------------------------------------------------------------------------------------------------------------------------------
  end

  def add_fixed_price_item
    doc = crawl_aliexpress
    token = "AgAAAA**AQAAAA**aAAAAA**x0+QXA**nY+sHZ2PrBmdj6wVnY+sEZ2PrA2dj6ADloOoCZCHoQydj6x9nY+seQ**8toFAA**AAMAAA**GUveEELf6OyzywF1LZ2AxnLxoiLtqd0fUFtlgBBHlFcJq+f4tYfRp6Hu/u3otqXoxamaN2dNjjZxAXfFvCgEYKyW40ZZFLlb2Pnql1rQmrNRILlBWp/W6JMu7NgLPUm4u0rGujHC36FFU+2AsFdq3RUulbUYXWcJmxgeRYKQYbIVYj6+3dTzbK29OS0dZW4G10ekYLN81//OWdVHL/s208sF6YDxfljGJa2gXEFxLZcHpa4GnVLhLiTqMnP7PF7EPPVT8k540EoVFoShsjJ7XGFE5hdaR+TRXY5l5g/kaGPYrOOxvSHEgK2LELx5q1TlIX9LY25bA4y4xtJwCuOXCKdjN1lJAugAartDhsyFaFNI3sn+4+N43O9VwyJv9Yez+ycQSuTVnnIbB7yO/wvW5DuAVRGMTmzeamStTyoRVplkDLGoumCIhgDX4s52aSuD9MJaKBoJIJmwBi1tNjILeQfQsAb+zT0UTMJ8yF+/yy/Xu517mbyvfEuu3eTnVMMaXwNTDdNC2bcICUX22/sBVRj+qRpJFkuVTVTx9pVZvOJfwjw6HTC53BNkJ7xb/hHT0Rp6aHKbqsJ5D2yRPZX5FxThwO8yp7pbiiDVJthYCyUEheKVaSO/Z2uM7kvRUXZi2C0eQQ94SWik+tjto2LDHZXUUXgqIOPeQb46rnh0F5NmoS1OOpAlV/XghGyAYPHg6qY+fsabmldkPgA3SLCUik4NmArm2+HdAS7G48wr8uJkxphmeVtGvf3KTqLM8iLv"
    #----------------------------------------------------------------------------------------------------------------

    itemSpecificHash = Hash.new
    doc.css('ul.product-property-list li').each do |el|
      itemSpecificHash[el.css('span.propery-title').text] = el.css('span.propery-des').text
    end

    packageDetailHash = Hash.new
    doc.css('ul.product-packaging-list li').each do |el|
      packageDetailHash[el.css('span.packaging-title').text] = el.css('span.packaging-des').text
    end


    # mainImageUrl = doc.css('img#poster').attr('src').value
    mainImageUrl = doc.css('a.ui-image-viewer-thumb-frame img').attr('src').value
    altMainImage = doc.css('a.ui-image-viewer-thumb-frame img').attr('alt').value
    title = doc.css('h1.product-name').text
    valid_title = get_valid_title title
    image_thumb_list = ""
    doc.css('ul.image-thumb-list li').each do |img|
      image_thumb_list += '<PictureURL>' + img.css('img').attr('src').value.gsub('.jpg_50x50', '') + '</PictureURL>'
    end

    description = get_decription title, altMainImage, mainImageUrl, itemSpecificHash, packageDetailHash


    # @description = doc.css('div.description-content').each do |n|
    #   puts n.inner_html
    # end
    #


    #GET SUGGESTED CATEGORIES
    #---------------------------------------------------------------------------------------------------------------------------------------------
    begin
      # uri = URI("https://api.ebay.com/ws/api.dll")
      uri = URI("https://api.ebay.com/ws/api.dll")
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true if uri.scheme == 'https'

      req = Net::HTTP::Post.new(
          uri.path,
          {'Content-Type' => 'text/xml', 'X-EBAY-API-COMPATIBILITY-LEVEL' => '911', 'X-EBAY-API-SITEID' => '0', 'X-EBAY-API-CALL-NAME' => 'GetSuggestedCategories'}
      )
      # req.body = {"token" => "15fdba59ecd6ccf9fc93c2b785721bc2952521b1877d95e5"}.to_json
      req.body = get_suggested_item_req token, title

      res = http.request(req)

      case res
      when Net::HTTPSuccess, Net::HTTPRedirection
        # OK
        categoryId = get_suggested_category_id res.body

        #ADD ITEM
        #-------------------------------------------------------------------------------------------------------------------------------------------------
        begin
          # uri = URI("https://api.ebay.com/ws/api.dll")
          http = Net::HTTP.new(uri.host, uri.port)
          http.use_ssl = true if uri.scheme == 'https'

          req = Net::HTTP::Post.new(
              uri.path,
              {'Content-Type' => 'text/xml', 'X-EBAY-API-COMPATIBILITY-LEVEL' => '911', 'X-EBAY-API-SITEID' => '0', 'X-EBAY-API-CALL-NAME' => 'AddItem'}
          )
          # req.body = {"token" => "15fdba59ecd6ccf9fc93c2b785721bc2952521b1877d95e5"}.to_json
          # request log
          logger.info add_item_req token, valid_title, description, categoryId, image_thumb_list

          req.body = add_item_req token, valid_title, description, categoryId, image_thumb_list

          res = http.request(req)

          case res
          when Net::HTTPSuccess, Net::HTTPRedirection
            # OK
            byebug
          else
            res.value
          end
        end

      else
        res.value
      end
    end
    #END -------------------------------------------------------------------------------------------------------------------------------------------------
  end

  private

  def crawl_banggood
    Selenium::WebDriver::Chrome.driver_path = "/home/ryne/Desktop/chromedriver"
    Capybara.register_driver :selenium do |app|
      # Capybara::Selenium::Driver.new(app, browser: :chrome,
      #                                options: Selenium::WebDriver::Chrome::Options.new(args: %w[headless disable-gpu]))

      Capybara::Selenium::Driver.new(app, browser: :chrome)
    end
    Capybara.javascript_driver = :chrome
    Capybara.configure do |config|
      config.default_max_wait_time = 10 # seconds
      config.default_driver = :selenium
    end

    browser = Capybara.current_session
    driver = browser.driver.browser

    url = "https://sea.banggood.com/XANES-K8-1_3-IPS-Color-Touch-Screen-Waterproof-Smart-Watch-Heart-Rate-Fitness-Exercise-Bracelet-p-1385004.html?rmmds=DSdownloadcenter&ID=227&cur_warehouse=CN"
    browser.visit url


    # Wait browser to load
    loop do
      sleep(2)
      if driver.execute_script('return document.readyState') == "complete"
        break
      end
    end

    driver.execute_script "window.scrollBy(0,10000)"


    doc = Nokogiri::HTML(driver.page_source);


    @description = doc.css('div.jsPolytypeContWrap').each do |n|
      puts n.inner_html
    end

  end

  def crawl_aliexpress
    Selenium::WebDriver::Chrome.driver_path = "../dropship-tool/driver/chromedriver"
    Capybara.register_driver :selenium do |app|
      Capybara::Selenium::Driver.new(app, browser: :chrome,
                                     options: Selenium::WebDriver::Chrome::Options.new(args: %w[headless disable-gpu]))

      # Capybara::Selenium::Driver.new(app, browser: :chrome)
    end
    Capybara.javascript_driver = :chrome
    Capybara.configure do |config|
      config.default_max_wait_time = 10 # seconds
      config.default_driver = :selenium
    end

    browser = Capybara.current_session
    driver = browser.driver.browser

    url = params[:url]
    browser.visit url


    # Wait browser to load
    loop do
      sleep(2)
      if driver.execute_script('return document.readyState') == "complete"
        break
      end
    end


    #
    el = driver.find_elements(:css, "div.description-content")
    driver.action.move_to(el[0]).perform

    loop do
      sleep(2)
      logger.info "Wait for JavaScript Loading"
      if !browser.has_css?('div.description-content > div.loading32')
        break
      end
    end

    doc = Nokogiri::HTML(driver.page_source);
  end

  def get_suggested_category_id xml
    Nokogiri::XML(xml).css('CategoryID').first.text
  end

end



