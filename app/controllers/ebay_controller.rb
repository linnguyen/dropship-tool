class EbayController < ApplicationController
  require 'net/http'
  require 'json'

  # def index
  #   begin
  #     uri = URI("https://api.ebay.com/ws/api.dll")
  #     http = Net::HTTP.new(uri.host, uri.port)
  #     http.use_ssl = true if uri.scheme == 'https'
  #
  #     req = Net::HTTP::Post.new(
  #         uri.path,
  #         {'Content-Type' => 'text/xml', 'X-EBAY-API-COMPATIBILITY-LEVEL' => '911', 'X-EBAY-API-SITEID' => '0', 'X-EBAY-API-CALL-NAME' => 'GeteBayOfficialTime'}
  #     )
  #     # req.body = {"token" => "15fdba59ecd6ccf9fc93c2b785721bc2952521b1877d95e5"}.to_json
  #     req.body = '<?xml version="1.0" encoding="utf-8"?>
  #   <GeteBayOfficialTimeRequest xmlns="urn:ebay:apis:eBLBaseComponents">
  #     <RequesterCredentials>
  #       <eBayAuthToken>AgAAAA**AQAAAA**aAAAAA**YDCHXA**nY+sHZ2PrBmdj6wVnY+sEZ2PrA2dj6ADloOoCZCHoQydj6x9nY+seQ**8toFAA**AAMAAA**GUveEELf6OyzywF1LZ2AxnLxoiLtqd0fUFtlgBBHlFcJq+f4tYfRp6Hu/u3otqXoxamaN2dNjjZxAXfFvCgEYKyW40ZZFLlb2Pnql1rQmrNRILlBWp/W6JMu7NgLPUm4u0rGujHC36FFU+2AsFdq3RUulbUYXWcJmxgeRYKQYbIVYj6+3dTzbK29OS0dZW4G10ekYLN81//OWdVHL/s208sF6YDxfljGJa2gXEFxLZcHpa4GnVLhLiTqMnP7PF7EPPVT8k540EoVFoShsjJ7XGFE5hdaR+TRXY5l5g/kaGPYrOOxvSHEgK2LELx5q1TlIX9LY25bA4y4xtJwCuOXCKdjN1lJAugAartDhsyFaFNI3sn+4+N43O9VwyJv9Yez+ycQSuTVnnIbB7yO/wvW5DuAVRGMTmzeamStTyoRVplkDLGoumCIhgDX4s52aSuD9MJaKBoJIJmwBi1tNjILeQfQsAb+zT0UTMJ8yF+/yy/Xu517mbyvfEuu3eTnVMMaXwNTDdNC2bcICUX22/sBVRj+qRpJFkuVTVTx9pVZvOJfwjw6HTC53BNkJ7xb/hHT0Rp6aHKbqsJ5D2yRPZX5FxThwO8yp7pbiiDVJthYCyUEheKVaSO/Z2uM7kvRUXZi2C0eQQ94SWik+tjto2LDHZXUUXgqIOPeQb46rnh0F5NmoS1OOpAlV/XghGyAYPHg6qY+fsabmldkPgA3SLCUik4NmArm2+HdAS7G48wr8uJkxphmeVtGvf3KTqLM8iLv</eBayAuthToken>
  #     </RequesterCredentials>
  #   </GeteBayOfficialTimeRequest>'
  #
  #     res = http.request(req)
  #
  #     case res
  #     when Net::HTTPSuccess, Net::HTTPRedirection
  #       # OK
  #     else
  #       res.value
  #     end
  #   end
  # end


  def index

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
