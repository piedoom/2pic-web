json.id         user.id
json.username   user.username

# TODO: set photo
# json.photo      user.photo.url
json.score      user.score
json.traits do
  json.partial! "api/v1/traits/traits", traits: user.traits
end