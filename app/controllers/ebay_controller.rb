class EbayController < ApplicationController
  require 'net/http'
  require 'json'

  require 'openssl'
  require 'nokogiri'
  require 'open-uri'

  require 'selenium-webdriver'
  require 'capybara'

  def banggood
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

  def index

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

    url = "https://www.aliexpress.com/item/5-CM-Dog-Toy-Rubber-Balls-Pet-Dog-Cat-Puppy-Chew-Toys-Ball-Chew-Toys-Tooth/32788039283.html?spm=2114.11010108.06001.20.650c649b8rJchQ&gps-id=pcJustForYou&scm=1007.13562.109986.0&scm_id=1007.13562.109986.0&scm-url=1007.13562.109986.0&pvid=897b3a37-57b9-43f7-89f3-6a93e1588c1d"
    browser.visit url


    # Wait browser to load
    loop do
      sleep(2)
      if driver.execute_script('return document.readyState') == "complete"
        break
      end
    end

    driver.execute_script " window.scrollTo(0, 0)"


    doc = Nokogiri::HTML(driver.page_source);


    @description = doc.css('div.description-content').each do |n|
      puts n.inner_html
    end

  end


  def index1
    # url = "https://sea.banggood.com/XANES-W1-1_3-IPS-Color-Screen-GPS-Smart-Watch-Waterproof-Heart-Rate-Monitor-Smart-Bracelet-mi-band-p-1336197.html?rmmds=DSdownloadcenter&ID=226&cur_warehouse=CN"
    url = "https://sea.banggood.com/XANES-K8-1_3-IPS-Color-Touch-Screen-Waterproof-Smart-Watch-Heart-Rate-Fitness-Exercise-Bracelet-p-1385004.html?rmmds=DSdownloadcenter&ID=227&cur_warehouse=CN"
    doc = Nokogiri::HTML(open(url))

    @description = doc.css('div.jsPolytypeContWrap').each do |n|
      puts n.inner_html
    end

    # pace.doc.at_css('#idLinkProductMainImage img').attr('src')
    # refer https://medium.com/@inanbunyamin90/using-capybara-for-scraping-9b078773c7c2
  end

  def create_item

    token = "AgAAAA**AQAAAA**aAAAAA**TSiKXA**nY+sHZ2PrBmdj6wVnY+sEZ2PrA2dj6wFk4aiCJiCowWdj6x9nY+seQ**2+oEAA**AAMAAA**yOHO2K+nrc52r9ISrMia8vGXcVhf+UJwumu+cob2pkG+3T/betaIBFEwIY/BW+Mcm5I1rfdR5CKy2k2BMSr1vy1UW9scCjmytkN3fUq55eOyb63ojhVOnnSjXw1AyEGJylxGK5MMKPtUhA9QMM8tW3nKFAdURX5Hp/oNoSIjGPoW03iKD7vasmexJh6V+59KabrGLbLnGCtqafgOdRQFk+QGBuS60RprIKTpTVkmGXOMd9OUl5ntPSsOcNIqjOJPyfY0lxdRC/XxNwFl77SnwbW7aE1Uzuct+fqh/DUXben2N+Y6WWQ0RUSp4DvnGNUinIMuwM6RjfVU15fDHd2juVmtBhnYUvhKS5+yIKNFPEz9rfaMZ6XWheM/ScNvSbtpCIDmsl1cIVgbtadkOlAQmsZngrHhALYeWBQ9K8npEDzht9izjE/wUtdBePOEzqhY80iO92IvGf71fAS51oSkPedzBv0bjsJ36IVW7Tq/ad0E2RGnJOh7V0btwc+U3vZhdAT70KphWYU4BBKm5ZpYoN5nT5Pq/98XJCVf/BjYu2dQF9KZmmbYS+zKDguoHIqr1z8/VMy4ZDlIE/c2JzftL2zIsq3oPFjkLO7Qvh5BUuD1EAZVDQ362D9avuSvraHRNEVarPFY9JZfjd5BaiNTVOA9XaZKC9ozrmRagAcNMSBpz2pvcumFcXT6Se+FyqKbO3sPIPyk2SjyI1UpnJ5LUl+/jMT03KD+3MCy6R4XyB2IKdNb0M/bD75cOqUHhzZy"

    begin
      # uri = URI("https://api.ebay.com/ws/api.dll")
      uri = URI("https://api.sandbox.ebay.com/ws/api.dll")
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true if uri.scheme == 'https'

      req = Net::HTTP::Post.new(
          uri.path,
          {'Content-Type' => 'text/xml', 'X-EBAY-API-COMPATIBILITY-LEVEL' => '911', 'X-EBAY-API-SITEID' => '0', 'X-EBAY-API-CALL-NAME' => 'AddItem'}
      )
      # req.body = {"token" => "15fdba59ecd6ccf9fc93c2b785721bc2952521b1877d95e5"}.to_json
      req.body = '<?xml version="1.0" encoding="utf-8"?>
                  <AddItemRequest xmlns="urn:ebay:apis:eBLBaseComponents">
                    <RequesterCredentials>
                      <eBayAuthToken>' + token + '</eBayAuthToken>
                    </RequesterCredentials>
                    <ErrorLanguage>en_US</ErrorLanguage>
                    <WarningLevel>High</WarningLevel>
                    <Item>
                      <Title>Ryn test store with xml</Title>
                      <Description>
                        This is the first book in the Harry Potter series. In excellent condition!
                      </Description>
                        <PrimaryCategory>
                        <CategoryID>377</CategoryID>
                      </PrimaryCategory>
                        <StartPrice>1.0</StartPrice>
                      <CategoryMappingAllowed>true</CategoryMappingAllowed>
                        <ConditionID>4000</ConditionID>
                      <Country>US</Country>
                        <Currency>USD</Currency>
                      <DispatchTimeMax>3</DispatchTimeMax>
                        <ListingDuration>Days_7</ListingDuration>
                      <ListingType>Chinese</ListingType>
                        <PaymentMethods>PayPal</PaymentMethods>
                      <PayPalEmailAddress>nguyenvanlin01041994@gmail.com</PayPalEmailAddress>
                        <PictureDetails>
                        <PictureURL>https://mypicserver.com/myphoto.jpg</PictureURL>
                      </PictureDetails>
                        <PostalCode>95125</PostalCode>
                      <Quantity>1</Quantity>
                        <ReturnPolicy>
                        <ReturnsAcceptedOption>ReturnsAccepted</ReturnsAcceptedOption>
                        <RefundOption>MoneyBack</RefundOption>
                        <ReturnsWithinOption>Days_30</ReturnsWithinOption>
                        <ShippingCostPaidByOption>Buyer</ShippingCostPaidByOption>
                        </ReturnPolicy>
                      <ShippingDetails>
                        <ShippingType>Flat</ShippingType>
                        <ShippingServiceOptions>
                        <ShippingServicePriority>1</ShippingServicePriority>
                          <ShippingService>USPSMedia</ShippingService>
                        <ShippingServiceCost>2.50</ShippingServiceCost>
                        </ShippingServiceOptions>
                        </ShippingDetails>
                      <Site>US</Site>
                        </Item>
                  </AddItemRequest>'

      res = http.request(req)

      case res
      when Net::HTTPSuccess, Net::HTTPRedirection
        # OK
        byebug
      else
        res.value
      end
    end
  end

end
