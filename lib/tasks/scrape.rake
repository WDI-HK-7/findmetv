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

        url_one_serie = "http://www.imdb.com" + series_link

        data_one_serie = open(url_one_serie)
        # , 'User-Agent' => "Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)"

        parsed_data_one_serie = Nokogiri::HTML(data_one_serie)

        get_photo_link = parsed_data_one_serie.css ("#img_primary > div.image > a")

        next if get_photo_link.empty?
        
        photo_link = get_photo_link.attribute("href").value
        url_photo = "http://www.imdb.com" + photo_link

        data_photo = open(url_photo)

        parsed_data_photo = Nokogiri::HTML(data_photo)
        
        open_one_link(parsed_data_one_serie, parsed_data_photo, "tbody > tr > td > h1 > span.itemprop", "#primary-img", "tbody > tr > td > div > div.titlePageSprite.star-box-giga-star", "tbody > tr > td > div > time", "tbody > tr > td > h1 > span.nobr", "#overview-top > p[itemprop=description]", "div.infobar a span.itemprop", url_one_serie, "#overview-top > div[itemprop=actors] > a")
      end
    end
  end
end

def open_one_link(parsed_data_one_serie, parsed_data_photo, series_title, series_photo, series_rating, series_length, series_years, series_recap, series_category, series_link, series_cast)

  title = parsed_data_one_serie.css(series_title)
  rating = parsed_data_one_serie.css(series_rating) 
  length = parsed_data_one_serie.css(series_length)
  years = parsed_data_one_serie.css(series_years)
  recap = parsed_data_one_serie.css(series_recap)
  categories = parsed_data_one_serie.css(series_category)
  photo = parsed_data_photo.css(series_photo)
  casts = parsed_data_one_serie.css(series_cast)

  new_series = Serie.new

  new_series.title = title.text
  new_series.photo = photo.attribute("src").value
  new_series.rating = rating.text if rating.any?
  new_series.length = length.text if length.any?
  new_series.years = years.text 
  new_series.recap = recap.text if recap.any?

  categories.each_with_index do |category, index|
    if index == 0
      new_series.category = category.text
    else
      new_series["category#{index+1}"] = category.text
    end
  end

  total_cast = ""
  casts.each_with_index do |cast, index|
    if index == (casts.length - 1)
      total_cast += cast.text
    else 
      total_cast += cast.text + " / "
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