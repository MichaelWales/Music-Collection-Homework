require_relative("../db/sql_runner")

class Artists

  attr_accessor :name
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
  end

  def create()
    sql = "INSERT INTO artists
     (
       name
     )
     VALUES
     (
       $1
     )
     RETURNING id
     "
     values = [@name]
     @id = SqlRunner.run(sql, values)[0]['id'].to_i
  end

  def update()
    sql = "
    UPDATE artists SET (
      name
    ) =
    (
      $1
    )
    WHERE id = $2"
    values = [@name, @id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = "DELETE FROM artists"
    SqlRunner.run(sql, [])
  end

  def self.find()
    sql = "SELECT * FROM artists WHERE id = $1"
    values = [id]
    artist_hash = SqlRunner.run(sql, values).first()
    return nil if artist_hash == nil
    return Artists.new(artist_hash)
  end

  def albums()
    sql = "SELECT * FROM albums WHERE artist_id = $1"
    values = [@id]
    albums = SqlRunner.run(sql, values)
    return albums.map {|album_hash| Albums.new(album_hash)}
  end

end
