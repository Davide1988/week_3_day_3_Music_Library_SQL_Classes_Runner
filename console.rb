require('pg')
require('pry')
require_relative('./moduls/artist')
require_relative('./moduls/album')

Album.delete_all()
Artist.delete_all()

artist1 = Artist.new({ 'name' => 'Aerosmith' })
artist1.save

artist2 = Artist.new({ 'name' => 'Iron Maiden' })
artist2.save

album1 = Album.new({ 'title' => 'Dreom on', 'genre' => 'Rock', 'artist_id' => artist1.id})
album1.save



album2 = Album.new({ 'title' => 'Powerslave', 'genre' => 'Metal', 'artist_id' => artist2.id})
album2.save

album3 = Album.new({ 'title' => 'Brave new world', 'genre' => 'Metal', 'artist_id' => artist2.id})
album3.save

album3.genre = "Heavy Metal"
album3.update

artist1.name = "Large Mouth singer"
artist1.update


p Artist.find_by_id(artist1.id)

p Album.find_by_id(album3.id)

binding.pry
nil
