require 'sqlite3'
require 'singleton'

class QuestionsDBConnection < SQLite3::Database 
    include Singleton 

    def initialize
        super('questions.db')
        self.type_translation = true
        self.results_as_hash = true
    end
end

class Users
    attr_accessor :id, :fname, :lname

    def self.all
        data = QuestionsDBConnection.instance.execute('SELECT *  FROM users')
        data.map {|datum| Users.new(datum)}
    end
    # line 18 takes the data from our .db file (users table) 
    # each row of table is represented as an array
    # 19 creates new instances of users.

    def self.find_by_id(id)
        user = QuestionsDBConnection.instance.execute(<<-SQL, id)
            SELECT
                *
            FROM
              users
            WHERE
              id = ?    
        SQL
        return nil unless user
        Users.new(user.first)
    end


    def initialize(options)
        @id = options['id']
        @fname = options['fname']
        @lname = options['lname']
    end

    def create
        raise '#{self} already in database' if @id
        QuestionsDBConnection.instance.execute(<<-SQL, @fname, @lname)
            INSERT INTO
                users (fname, lname)
            VALUES
                (? , ?)
        SQL
        @id = QuestionsDBConnection.instance.last_insert_row_id
    end


    

end
