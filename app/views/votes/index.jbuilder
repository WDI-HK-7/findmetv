json.array! @votes do |vote|
  json.likes vote.likes
  json.dislikes vote.dislikes
end