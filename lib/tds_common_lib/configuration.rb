module TdsCommonLib
  class Configuration
    attr_accessor :aws_access_key_id
    attr_accessor :aws_database_backup_file_bucket
    attr_accessor :aws_database_backup_file_dir
    attr_accessor :aws_secret_access_key
    attr_accessor :aws_region

    def initialize
      @aws_access_key_id = ''
      @aws_database_backup_file_bucket = ''
      @aws_database_backup_file_dir = ''
      @aws_secret_access_key = ''
      @aws_region = ''
    end

  end
end
