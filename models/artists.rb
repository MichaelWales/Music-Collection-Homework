require_relative("../db/sql_runner")

class Artist

  attr_accessor :name
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
  end

  def create()
    sql = "INSERT INTO music_collection
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

end
