CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',
    :aws_access_key_id      => 'AKIAIDBNKE6K5YFMOMFA',
    :aws_secret_access_key  => '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',
  }
  config.fog_directory  = 'cmstage01'
end
