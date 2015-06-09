json.array! @series do |serie|
  json.id serie.id
  json.title serie.title
  json.rating serie.rating
  json.length serie.length
  json.years serie.years
  json.recap serie.recap
  json.category serie.category
  json.category2 serie.category2
  json.category3 serie.category3
  json.cast serie.cast
  json.like serie.like
  json.dislike serie.dislike
end