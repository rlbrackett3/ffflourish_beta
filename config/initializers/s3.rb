require 'yaml'
require 'rubygems'
require 'aws/s3'

  if Rails.env.production?
    AWS::S3::Base.establish_connection!(
      :access_key_id      => ENV['S3_KEY'],
      :secret_access_key  => ENV['S3_SECRET']
    )
    
    AWS::S3::Service.buckets(
      :bucket             => ENV['S3_BUCKET']
    )
  elsif Rails.env.staging? 
    AWS::S3::Base.establish_connection!(
      :access_key_id      => ENV['S3_KEY'],
      :secret_access_key  => ENV['S3_SECRET']
    )
    
    AWS::S3::Service.buckets(
      :bucket             => ENV['S3_BUCKET']
    )
  end
