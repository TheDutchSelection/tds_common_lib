module TdsCommonLib
  class DatabaseBackupFileUploader < ::CarrierWave::Uploader::Base

    storage Rails.env.production? ? :fog : :file

    def initialize(*)
      super

      self.fog_credentials = {
        provider: 'AWS',
        aws_access_key_id: TdsCommonLib.configuration.aws_access_key_id,
        aws_secret_access_key: TdsCommonLib.configuration.aws_secret_access_key,
        use_iam_profile: false,
        region: TdsCommonLib.configuration.aws_region
      }
      self.fog_directory = TdsCommonLib.configuration.aws_database_backup_file_bucket
      self.fog_public = false
      self.fog_attributes = {}
    end

    def cache_dir
      '/tmp'
    end

    def move_to_cache
      false
    end

    def store_dir
      if Rails.env.production?
        TdsCommonLib.configuration.aws_database_backup_file_dir || "tds_common_lib/database_backup_files"
      else
        "files/tds_common_lib/database_backup_files"
      end
    end
  end
end