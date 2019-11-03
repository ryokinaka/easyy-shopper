CarrierWave.configure do |config|
  config.fog_credentials = {
    provider: 'AWS',
    aws_access_key_id: 'AKIARDSBUW3QDU2MFQWZ',
    aws_secret_access_key: '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',
    region: 'ap-northeast-1'
  }
  
  config.fog_directory = 'rails-image-1002'
  config.asset_host = "https://s3.ap-northeast-1.amazonaws.com/rails-image-1002"
  config.cache_storage = :fog
end