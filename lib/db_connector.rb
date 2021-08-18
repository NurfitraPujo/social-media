require 'mysql2'
require 'singleton'
require 'config'

class DatabaseConnection
  attr_reader :environtment

  include Singleton

  def initialize
    @environtment = ENV['RACK_ENV'] || 'development'
    env_config = YAML.load_file("./config/settings/#{@environtment}.yml")
    @db_con = Mysql2::Client.new(
      host: env_config['DB_HOST'],
      username: env_config['DB_USER'],
      password: env_config['DB_PASSWORD'],
      database: env_config['DB_SCHEMA']
    )
    puts print_conn_success(env_config['DB_HOST'])
    @db_con.query_options.merge!(symbolize_keys: true)
  rescue Mysql2::Error => e
    print_conn_error(e)
  end

  def print_conn_success(host)
    "Server has been connected to Mysql server in #{host}"
  end

  def print_conn_error(error)
    puts 'Failed to connect with mysql server'
    puts error
  end

  def query(sql, options = {})
    @db_con.query(sql, **options)
  end

  def transaction
    raise ArgumentError, 'No block was given' unless block_given?

    begin
      @db_con.query('BEGIN')
      yield
      @db_con.query('COMMIT')
    rescue StandardError => e
      puts e
      @db_con.query('ROLLBACK')
      raise
    end
  end
end
