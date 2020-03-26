require_relative('../db/sql_runner')
require_relative('./artists')

class Albums

  attr_accessor :title, :genre, :artist_id
  attr_reader :id

  def initialize(options)
    @title = options['title']
    @genre = options['genre']
    @artist_id = options['artist_id'].to_i
    @id = options['id'].to_i if options['id']
  end

  def create()
    sql = "INSERT INTO albums
    (
    title,
    genre,
    artist_id
    )
    VALUES
    (
      $1, $2, $3
    )
    RETURNING id
    "
    values = [@title, @genre, @artist_id]
    @id = SqlRunner.run(sql, values)[0]['id'].to_i
  end

  def update()
    sql = "
    UPDATE albums SET (
      title,
      genre,
      artist_id
    ) =
    (
      $1, $2, $3
    )
    WHERE id = $4"
    values = [@customer_id, @topping, @quantity, @id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = "DELETE FROM albums"
    SqlRunner.run(sql, [])
  end

  def self.find()
    sql = "SELECT * FROM albums WHERE id = $1"
    values = [id]
    album_hash = SqlRunner.run(sql, values).first()
    return nil if album_hash == nil
    return self.new(album_hash)
  end

  def artist()
    sql = "SELECT * FROM artists WHERE id = $1"
    values = [@artist_id]
    artist = SqlRunner.run(sql, values)
    return artist.map {|artist_hash| Artists.new(artist_hash)}
  end

end
