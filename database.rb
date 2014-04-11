#!/usr/bin/env ruby

class SQLCommands
  attr_accessor :table_name
  def create_database(dbname)
    self.execute("create database #{dbname}")
  end

  def drop_database(dbname)
    self.execute("drop database #{dbname}")
  end

  def create_table(table_name, table_columns = {})
    @table_name = table_name
    columns = []
    table_columns.map do |column_name, type|
      columns << "#{column_name} #{type}"
    end
    self.execute("create table #{table_name} (#{columns.join(',')})")
  end

  def drop_table(table_name)
    self.execute("drop table #{table_name}")
  end

  def insert(values_hash = {})
    columns = []
    values = []
    values_hash.map do |column, value|
      columns << column.to_s && values << value
    end
    self.prepare(columns, values)
  end

  def prepare(columns, values)
    value_place_holder = (['?'] * values.size).join(',')
    insert = @con.prepare("insert into #{@table_name} (#{columns.join(',')}) \
                          values(#{value_place_holder})")
    insert.execute(*values)
  end
end

class PGDatabase < SQLCommands
  def initialize(database, host, port, username, password = nil)
    @con = PG::Connection.open(dbname: database, host: host,
                               port: port, user: username, password: password)
  rescue
    @con = PG::Connection.open(dbname: '', host: host,
                               port: port, user: username, password: password)
    self.create_database(database)
    @con = PG::Connection.open(dbname: database, host: host,
                               port: port, user: username, password: password)
  end

  def prepare(columns, values)
    value_place_holder = []
    values.each_with_index { |_, index| value_place_holder << "$#{index + 1}" }
    @con.prepare('insert', "insert into #{@table_name} (#{columns.join(',')}) \
                 values(#{value_place_holder.join(',')})")
    @con.exec_prepared('insert', [*values])
    self.execute('DEALLOCATE insert')
  end

  def execute(sql_command)
    @con.exec(sql_command)
  end

  def import(file_array)
    file_array.each do |file|
      self.execute("copy #{@table_name} from '#{file}' csv header")
    end
  end
end

class SQLiteDatabase < SQLCommands
  def initialize(database)
    @con = SQLite3::Database.new database
  end

  def execute(sql_command)
    @con.execute(sql_command)
  end
end

class MysqlDatabase < SQLCommands
  def initialize(database, host, username, password = nil)
    @con = Mysql.new(hostname, username, password, database)
  end

  def execute(sql_command)
    @con.query(sql_command)
  end
end
