require 'pg'

class JmlDb

  DB_NAME = 'jmldb'

  class << self
    def create(options = {})
      keys = options.keys.join(', ')
      values = options.values.map { |v| "'#{v}'" }.join(', ')
      sql = "INSERT INTO #{table_name} (#{keys}) VALUES (#{values}) returning *"
      result = execute_sql(sql)
      new(result[0])
    end

    def where(options)
      sql = "SELECT * FROM #{table_name} WHERE"
      if options.is_a?(Hash)
        options.each do | k, v |
          sql = "#{sql} #{k} = '#{v}' AND"
        end
        sql.chomp!('AND')
      else
        sql = "#{sql} #{options}"
      end
      result = execute_sql(sql)

      Array(result).map { |res| new(res) }
    end

    def find(id)
      sql = "SELECT * FROM #{table_name} WHERE id = #{id} LIMIT 1"
      result = execute_sql(sql)
      return if result.empty?

      new(result[0])
    end

    def find_by(options = {})
      sql = "SELECT * FROM #{table_name} WHERE"
      if options.is_a?(Hash)
        options.each do | k, v |
         sql = "#{sql} #{k} = '#{v}' AND"
        end
        sql.chomp!('AND')
        sql = "#{sql} LIMIT 1"
      else
        sql = "#{sql} #{options} LIMIT 1"
      end
      result = execute_sql(sql)
      return if result.empty?

      new(result[0])
    end

    private

    def table_name
      self.to_s.downcase.pluralize
    end

    def execute_sql(sql)
      connection = PG.connect(dbname: DB_NAME)
      result = connection.exec(sql)
      connection.close
      result.to_a
    end
  end

  def initialize(params = {})
    columns = execute_sql(columns_sql)
    columns.each do |column|
      self.class.send(:attr_accessor, column['column_name'])
    end
    params.each do | k, v |
      public_send("#{k}=", v)
    end
  end

  def update(options = {})
    setter = ''
    options.each do | k,v |
      setter = "#{setter} #{k} = '#{v}', "
    end
    setter.chomp!(', ')
    sql = "UPDATE #{table_name} SET #{setter} WHERE id = #{self.id}  returning *"
    result = execute_sql(sql)
    return if result.empty?

    self.class.new(result[0])
  end

  def delete
    sql = "DELETE FROM #{table_name} WHERE id = #{self.id}"
    execute_sql(sql)

    self
  end

  private

  def table_name
    self.class.name.downcase.pluralize
  end

  def columns_sql
    "select column_name from information_schema.columns where table_name='#{table_name}'"
  end

  def execute_sql(sql)
    connection = PG.connect(dbname: DB_NAME)
    result = connection.exec(sql)
    connection.close
    result.to_a
  end
end


