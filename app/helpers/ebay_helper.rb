module EbayHelper
  def get_decription title, altMainImage, mainImageUrl, itemSpecificHash, packageDetailHash, description

    itemSpecific = ""
    itemSpecificHash.each do |key, value|
      itemSpecific += '<li><span>' + key.to_s + '</span> <span>' + value.to_s + '</span></li>'
    end

    packageDetail = ""
    packageDetailHash.each do |key, value|
      packageDetail += '<li><span>' + key.to_s + '</span> <span>' + value.to_s + '</span></li>'
    end

    des = '
    <html>
  <body>
  <table style="border-spacing: 0px; width: 100%;" align="center">
      <tbody>
      <tr>
          <td>
              <div id="ds_div">
                  <meta content="width=device-width, initial-scale=1.0" name="viewport">
                  <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
                  <link href="https://fonts.googleapis.com/css?family=Open+Sans:400,600|Roboto+Condensed:300,400,700"
                        rel="stylesheet">
                  <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
                  <link href="https://cldup.com/BIUxxmE1z4.css" rel="stylesheet">
                  <link href="https://fonts.googleapis.com/css?family=Bree+Serif|Cairo|Saira+Semi+Condensed:400,700|Ubuntu"
                        rel="stylesheet">
                  <div class="wholeWidth">
                      <header>
                          <div class="containerWidth"><img alt="banner" src="https://cldup.com/00FhLi9aZS.png"></div>
                      </header>

                      <div class="containerWidth">
                          <nav class="navbar navbar-default">
                              <div class="container text-center">
                                  <div class="navbar-collapse" id="navbar">
                                      <ul class="nav navbar-nav">
                                          <li><a target="_blank" href="http://stores.ebay.com/linstore2019">Store</a></li>
                                          <li><a target="_blank"
                                                 href="https://www.ebay.com/sch/m.html?_nkw=&amp;_armrs=1&amp;_ipg=&amp;_from=&amp;_ssn=linstore2018&amp;_sop=10">New
                                              Arrivals</a></li>
                                          <li><a target="_blank"
                                                 href="http://my.ebay.com/ws/eBayISAPI.dll?AcceptSavedSeller&amp;ru=http%3A//cgi.ebay.com/ws/eBayISAPI.dll?ViewItemNext&amp;item=330478824623&amp;mode=0&amp;ssPageName=STRK:MEFS:ADDVI&amp;sellerid=linstore2018&amp;preference=0">Add
                                              to Favorite</a></li>
                                          <li><a target="_blank"
                                                 href="http://feedback.ebay.com/ws/eBayISAPI.dll?ViewFeedback2&amp;userid=linstore2018&amp;ftab=AllFeedback&amp;myworld=true&amp;rt=nc">View
                                              Feedback</a></li>
                                          <li><a target="_blank"
                                                 href="http://contact.ebay.com/ws/eBayISAPI.dll?FindAnswers&amp;frm=284&amp;requested=linstore2018&amp;iid=-1">Contact</a>
                                          </li>
                                      </ul>
                                  </div>
                              </div>
                          </nav>
                      </div>

                      <div class="containerWidth hidden-sm hidden-xs"><img alt="30days" class="img-responsive"
                                                                           src="https://cldup.com/O73DZ9qvQm-3000x3000.png">
                      </div>

                      <div class="content">
                          <div class="listing_row1">
                              <div class="containerWidth">
                                  <div class="row">
                                      <div class="col-md-6 desc">
                                          <h3>' + title + '</h3>

                                          <h4>Description</h4>

                                          <p></p>

                                          <div>
                                              <div>

                                                  <h2>Product Details</h2>

                                                  <div>
                                                      <div>
                                                          <div>Item specifics</div>

                                                          <div>
                                                              <ul>' + itemSpecific.to_s + '</ul>
                                                          </div>
                                                      </div>

                                                      <div>
                                                          <div>Product Description</div>
                                                          ' + description + '
                                                      </div>

                                                      <div>
                                                          <div>Packaging Details</div>

                                                          <div>
                                                              <ul> ' + packageDetail + ' </ul>
                                                          </div>
                                                      </div>

                                                      <div>
                                                          <div></div>
                                                      </div>
                                                  </div>
                                              </div>
                                          </div>

                                          <p></p>
                                      </div>

                                      <div class="col-md-6">
                                          <div class="preview" align="center"><img
                                                  alt="' + altMainImage + '"
                                                  class="mainImage" name="preview"
                                                  src="' + mainImageUrl + '">
                                          </div>
                                      </div>
                                  </div>
                              </div>
                          </div>

                          <div class="listing_row2">
                              <div class="listing_row2">
                                  <div class="containerWidth">
                                      <div class="tab_content" id="aboutus">
                                          <h4>ABOUT US</h4>

                                          <p>We offer the best prices around on high quality products. Our E-store
                                              includes media such as books, movies, music and games while offering
                                              electronics, toys, sporting apparel, clothing, tools, general home, garden
                                              items and more.</p>
                                      </div>

                                      <div class="tab_content" id="shipping">
                                          <h4>SHIPPING</h4>

                                          <p>We are always working hard to ensure your package arrives as soon as
                                              possible. Please understand that some factors like weather, high postal
                                              traffic, and the performance of shipping companies are outside of our
                                              control.<br>
                                              <br>
                                              We offer free shipping to the lower 48 states and ship within 2 business
                                              days of payment, usually sooner. We do not accept P.O. Boxes. Please provide
                                              a physical address.<br>
                                              <br>
                                              For shipping outside of the continental USA, we only use eBay\' s Global
    Shipping Program.The item is shipped to KY and then sent to the rest of the
    world.International customers are responsible for all duties and taxes.
        Continue to check out
                                                    in order to calculate costs for shipping the item to
                                                                                  your country.Messages regarding eBay \'s Global Shipping Program MUST be
                                              directed at eBay EXCLUSIVELY.</p>
                                      </div>

                                      <div class="tab_content" id="return">
                                          <h4>RETURNS</h4>

                                          <p>We offer a 30-Day Return Policy on items which you are not completely
                                              satisfied with. You have the option for a full-refund or an exchange of the
                                              item. No returns are available on items shipped outside of the USA.</p>
                                      </div>

                                      <div class="tab_content" id="payment">
                                          <h4>PAYMENT</h4>

                                          <p>We accept PayPal.</p>
                                      </div>

                                      <div class="tab_content" id="contact">
                                          <h4>CONTACT US</h4>

                                          <p>This page content is yet to come<br>
                                              Please ad us to your favorite seller and visit again later<br>
                                              Thank You</p>
                                      </div>

                                      <div class="tab_content">
                                          <h4>CUSTOMER SATISFACTION</h4>

                                          <p>We try our very best to make sure every customer is completely satisfied. If
                                              there \'s a problem, message us! We \'re happy to help.</p>
                                      </div>
                                  </div>
                              </div>
                          </div>
                      </div>

                      <footer>
                          <div class="containerWidth">
                              <div class="footer_bottom" style="border-top: 1px solid #59a2d8;">
      <div class="row" style="border-bottom: 1px solid #59a2d8;">
      <div class="col-md-6 col-sm-8 col-xs-12">
      <h4>WE ACCEPT</h4>
                                          <img alt="paypal" class="img-responsive"
                                               style="width:60%;margin: 20px 0 10px 0;"
                                               src="https://cldup.com/lg0nO9KkhD.jpg"></div>
                                  </div>
                              </div>
                          </div>
                      </footer>
                  </div>
              </div>
          </td>
      </tr>
      </tbody>
  </table>
  <span id="closeHtml"></span>
  </body>
</html>
    '
  end

  def get_suggested_item_req token, query
    req = '
      <?xml version="1.0" encoding="utf-8"?>
  <GetSuggestedCategoriesRequest xmlns="urn:ebay:apis:eBLBaseComponents">
    <RequesterCredentials>
      <eBayAuthToken>' + token + '</eBayAuthToken>
    </RequesterCredentials>
    <Query>' + query + '</Query>
  </GetSuggestedCategoriesRequest>'
  end

  def add_item_req token, title, description, categoryID, pictureUrls
    req = '
    <?xml version="1.0" encoding="utf-8"?>
        <AddItemRequest
    xmlns="urn:ebay:apis:eBLBaseComponents">
    <RequesterCredentials>
    <eBayAuthToken>' + token + '</eBayAuthToken>
	</RequesterCredentials>
    <ErrorLanguage>en_US</ErrorLanguage>
	<WarningLevel>High</WarningLevel>
    <Item>
    <Title>' + title + '</Title>
		<Description><![CDATA[' + description + ']]></Description>
    <PrimaryCategory>
    <CategoryID>' + categoryID.to_s + '</CategoryID>
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
    <GalleryType>Gallery</GalleryType>
    ' + pictureUrls + '
		</PictureDetails>
    <ConditionID>1000</ConditionID>
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
  end

  def get_valid_title title
    valid_name = ""
    title_arr = title.split(" ")
    title_arr.each_with_index do |w, index|
      valid_name = valid_name + w.to_s + " "
      if ((index + 1) < title_arr.size && (valid_name + title_arr[index + 1]).size <= 80)
        next
      else
        break
      end
    end
    return valid_name.strip
  end
end
