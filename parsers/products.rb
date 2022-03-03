nokogiri = Nokogiri.HTML(content)

# initialize an empty hash
product = {}

#extract title
product['title'] = nokogiri.at_css('h1.dark-gray').text.strip

#extract current price
product['current_price'] = nokogiri.at_css('div[data-testid="add-to-cart-price-atf"] span[itemprop="price"]').text.strip

#extract original price
original_price_div = nokogiri.at_css('div[data-testid=add-to-cart-price-atf] .nowrap span.strike')
original_price = original_price_div ? original_price_div.text.strip.gsub('$','').to_f : nil
product['original_price'] = original_price == 0.0 ? nil : original_price

#extract rating
rating = nokogiri.at_css('span.rating-number').text.strip.gsub(/[)(]/, '').to_f
product['rating'] = rating == 0 ? nil : rating

#extract number of reviews
review_text = nokogiri.at_css('a[link-identifier="reviewsLink"]').text.strip
product['reviews_count'] = review_text =~ /reviews/ ? review_text.split(' ').first.to_i : 0

#extract publisher
product['publisher'] = nokogiri.at_css('div[itemprop="brand"]').text.strip

#extract walmart item number
canonical_url = nokogiri.at_css('link[rel="canonical"]')['href']
product['walmart_number'] = canonical_url.split('/').last.strip

#extract product image
product['img_url'] = nokogiri.at_css('.relative img.db')['src'].split('?').first

#extract product categories
product['categories'] = nokogiri.css('nav[aria-label="breadcrumb"] li').collect{|li| li.text.strip.gsub('/','') }

# specify the collection where this record will be stored
product['_collection'] = 'products'

# save the product to the job’s outputs
outputs << product
