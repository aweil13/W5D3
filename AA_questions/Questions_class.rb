require_relative 'questions_database.rb'


class Questions
    attr_accessor :id, :fname, :lname

    def self.all
        data = QuestionsDBConnection.instance.execute('SELECT *  FROM questions')
        data.map {|datum| Users.new(datum)}
    end
    # line 18 takes the data from our .db file (users table) 
    # each row of table is represented as an array
    # 19 creates new instances of users.

    def self.find_by_id(id)
        question = QuestionsDBConnection.instance.execute(<<-SQL, id)
            SELECT
                *
            FROM
              questions
            WHERE
              id = ?    
        SQL
        return nil unless question
        Questions.new(question.first)
    end

    # initialize takes in a HASH!!! 
    def initialize(options)
        @id = options['id']
        @title = options['fname']
        @body = options['lname']
    end

    def create
        raise '#{self} already in database' if @id
        QuestionsDBConnection.instance.execute(<<-SQL, @fname, @lname)
            INSERT INTO
                questions (fname, lname)
            VALUES
                (? , ?)
        SQL
        @id = QuestionsDBConnection.instance.last_insert_row_id
    end

    def update
        raise '#{self} NOT in database' unless @id
        QuestionsDBConnection.instance.execute(<<-SQL, @fname, @lname, @id)
        UPDATE
            questions
        SET
            fname = ?, lname = ?
        WHERE
            id = ?
        SQL

    end
    

end