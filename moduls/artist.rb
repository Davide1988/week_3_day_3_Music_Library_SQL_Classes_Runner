require('pg')
require('pry')
require_relative('../db/sql_runner')
require_relative('album')

class Artist

  attr_accessor :name
  attr_reader :id

  def initialize(options)
    @name = options['name']
    @id = options['id'].to_i if options['id']
  end


  def save
    sql = 'INSERT INTO artists ( name ) VALUES  ($1) RETURNING id'
    values = [@name]
    results = SqlRunner.run(sql,values)
    @id = results[0]['id'].to_i
  end


  def Artist.list_all
    sql = 'SELECT * FROM artists'
    results = SqlRunner.run(sql)
    return results.map {|artist| Artist.new(artist)}
  end


  def list_albums()
    sql = 'SELECT * FROM albums WHERE artist_id = $1'
    values = [@id]
    results = SqlRunner.run(sql,values)
    albums =  results.map {|album| Album.new(album)}
    return albums
  end

  def Artist.delete_all
    sql = 'DELETE FROM artists'
    SqlRunner.run(sql)
  end


  def update()
    sql = 'UPDATE artists SET name = $1 WHERE ID = $2'
    values = [@name, @id]
    SqlRunner.run(sql,values)
  end

  def Artist.find_by_id(id)
      sql = 'SELECT * FROM artists WHERE id = $1'
      values = [id]
      results = SqlRunner.run(sql,values)
      artist = results[0]
      return Artist.new(artist)
    end


end
