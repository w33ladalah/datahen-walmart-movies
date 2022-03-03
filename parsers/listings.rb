nokogiri = Nokogiri.HTML(content)
products = nokogiri.css('div.mid-gray')

products.each do |product|
  href = product.at_css('a')['href']
  url = URI.join('https://www.walmart.com', href).to_s
  pages << {
		url: url,
		page_type: 'products',
		fetch_type: 'browser',,
		headers: {
			"User-Agent": "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/98.0.4758.102 Safari/537.36"
			"sec-ch-ua": '" Not A;Brand";v="99", "Chromium";v="98", "Google Chrome";v="98"',
			"sec-ch-ua-mobile": "?0",
			"sec-ch-ua-platform": "Linux"
		},
		display: {
			"width": 1366,
			"height": 760
		},
		vars: {}
    }
end

pagination_links = nokogiri.css('nav[aria-label="pagination"] ul li a')
pagination_links.each do |link|
  url = URI.join('https://www.walmart.com', link['href']).to_s
  pages << {
		url: url,
		page_type: 'listings',
		fetch_type: 'browser',
		headers: {
			"User-Agent": "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/98.0.4758.102 Safari/537.36"
			"sec-ch-ua": '" Not A;Brand";v="99", "Chromium";v="98", "Google Chrome";v="98"',
			"sec-ch-ua-mobile": "?0",
			"sec-ch-ua-platform": "Linux"
		},
		display: {
			"width": 1366,
			"height": 760
		},
		vars: {}
    }
end
