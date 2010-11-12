CarrierWave.configure do |config|
  if Rails.env.production?
    config.storage = :s3
    config.s3_access_key_id = 'AKIAJPBA33D3AE6RCG6Q'
    config.s3_secret_access_key = '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'
    config.s3_bucket = 'ffflourish_beta_01'
    config.s3_access_policy = :public_read
  elsif Rails.env.development?
    config.storage = :file
  else
    config.storage = :file
  end
end

