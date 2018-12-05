require('pg')
require_relative('../db/sql_runner')
require_relative('artist')

class Album

  attr_accessor :title, :genre
  attr_reader :id , :artist_id

  def initialize(options)
    @title = options['title']
    @genre = options['genre']
    @id = options['id'].to_i if options['id']
    @artist_id = options['artist_id'].to_i
  end


    def save
      sql = 'INSERT INTO albums (title, genre, artist_id) VALUES  ($1, $2, $3) RETURNING id'
      values = [@title, @genre, @artist_id]
      results = SqlRunner.run(sql,values)
      @id = results[0]['id']
    end

    def Album.list_all
      sql = 'SELECT * FROM albums'
      results = SqlRunner.run(sql)
      return results.map {|album| Album.new(album)}
    end

    def name_artist()
      sql = 'SELECT * FROM artists WHERE id = $1'
      values = [@artist_id]
      results = SqlRunner.run(sql,values)
      artist =  results.map {|artist| Artist.new(artist)}
      return artist
    end

    def Album.delete_all
      sql = 'DELETE FROM albums'
      SqlRunner.run(sql)
    end


    def update()
      sql = 'UPDATE albums SET (title, genre, artist_id) = ($1, $2 , $3) WHERE ID = $4'
      values = [@title, @genre,@artist_id, @id]
      SqlRunner.run(sql,values)
    end

    def Album.find_by_id(id)
        sql = 'SELECT * FROM albums WHERE id = $1'
        values = [id]
        results = SqlRunner.run(sql,values)
        album = results[0]
        return Album.new(album)
      end


end
