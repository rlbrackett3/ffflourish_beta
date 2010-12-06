if Rails.env.production?
  AWS::S3::Base.establish_connection!(
    :access_key_id      => ENV['S3_KEY'],
    :secret_access_key  => ENV['S3_SECRET'],
    :bucket             => ENV['S3_BUCKET']
  )
end

