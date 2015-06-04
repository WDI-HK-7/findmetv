require 'open-uri' #opening an url

namespace :scrape do

  desc "Scrape TV series with more than 5000 reviews"
  task :imdb_series => :environment do

    (1..901).step(50).each do |i|
      url = "http://www.imdb.com/search/title?num_votes=5000,&sort=user_rating,desc&start=#{i}&title_type=tv_series"

      data = open(url)

      parsed_data = Nokogiri::HTML(data) #parse the websie with Nokogiri

      (2..51).each do |j|
        get_series_link = parsed_data.css("table.results > tr:nth-child(#{j}) > td.title > a")
        series_link = get_series_link.attribute("href").value

        url2 = "http://www.imdb.com" + series_link

        data2 = open(url2)
        # , 'User-Agent' => "Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)"

        parsed_data2 = Nokogiri::HTML(data2)

        get_photo_link = parsed_data2.css ("#img_primary > div.image > a")

        next if get_photo_link.empty?
        
        photo_link = get_photo_link.attribute("href").value
        url3 = "http://www.imdb.com" + photo_link

        data3 = open(url3)

        parsed_data3 = Nokogiri::HTML(data3)
        
        open_one_link(parsed_data2, parsed_data3, "tbody > tr > td > h1 > span.itemprop", "#primary-img", "tbody > tr > td > div > div.titlePageSprite.star-box-giga-star", "tbody > tr > td > div > time", "tbody > tr > td > h1 > span.nobr", "#overview-top > p[itemprop=description]", "div.infobar a span.itemprop", url2, "#overview-top > div[itemprop=actors] > a")
      end
    end
  end
end

def open_one_link(parsed_data2, parsed_data3, series_title, series_photo, series_rating, series_length, series_years, series_recap, series_category, series_link, series_cast)

  title = parsed_data2.css(series_title)
  rating = parsed_data2.css(series_rating) 
  length = parsed_data2.css(series_length)
  years = parsed_data2.css(series_years)
  recap = parsed_data2.css(series_recap)
  category = parsed_data2.css(series_category)
  photo = parsed_data3.css(series_photo)
  cast = parsed_data2.css(series_cast)

  new_series = Serie.new

  new_series.title = title.text
  new_series.photo = photo.attribute("src").value
  new_series.rating = rating.text if rating.any?
  new_series.length = length.text if length.any?
  new_series.years = years.text if years.any?
  new_series.recap = recap.text if recap.any?

  k=0
  while k < category.length do
    if k == 0
      new_series.category = category[k].text
      k += 1
    else
      new_series["category#{k+1}"] = category[k].text
      k += 1
    end
  end

  total_cast = ""
  l=0
  while l < cast.length do
    if l == (cast.length - 1)
      total_cast += cast[l].text
      l += 1
    else 
      total_cast += cast[l].text + " / "
      l += 1
    end
  end

  new_series.cast = total_cast
  
  new_series.link = series_link

  new_series.like = 0
  new_series.dislike = 0

  if new_series.save
    puts "#{new_series.title} saved in db"
  else
    puts "#{new_series.title} --------- FAILED!!!" 
  end

end