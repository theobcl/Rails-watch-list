require 'json'
require 'open-uri'

Bookmark.destroy_all
Movie.destroy_all

puts 'Creating movies'

url = 'http://tmdb.lewagon.com/movie/top_rated?'
movies_serialized = URI.open(url).read
movies = JSON.parse(movies_serialized)

movies['results'].each do |movie|
  Movie.create!({
    title: movie['original_title'],
    overview: movie['overview'],
    poster_url: "https://image.tmdb.org/t/p/w500#{movie['poster_path']}",
    rating: movie['vote_average']
  })
end

puts 'Movies created'
