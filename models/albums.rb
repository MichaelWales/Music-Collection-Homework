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

end
