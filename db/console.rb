require('pry')
require_relative('../models/albums')
require_relative('../models/artists')

Albums.delete_all()
Artists.delete_all()

artist1 = Artists.new({
  'name' => "The Beatles"
  })

artist1.create()

artist2 = Artists.new({
  'name' => "M83"
  })

artist2.create()

album1 = Albums.new({
  'title' => "Abbey Road",
  'genre' => "Rock",
  'artist_id' => artist1.id
  })

album1.create()

album2 = Albums.new({
  'title' => "Saturdays = Youth",
  'genre' => "Indie Rock",
  'artist_id' => artist2.id
  })

album2.create()

album3 = Albums.new({
  'title' => "The White Album",
  'genre' => "Rock",
  'artist_id' => artist1.id
  })

  album3.create()
