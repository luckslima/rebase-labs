require 'pg'

class Tests
  def initialize
    @conn = PG.connect(
      dbname: 'my_database',
      user: 'postgres',
      password: 'password',
      host: 'db'
    )
  end

  def all
    result = @conn.exec("SELECT * FROM tests")
    result.map { |row| row }
  end
end