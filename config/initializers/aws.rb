# AWS SDK v3 Configuration
if ENV['AWS_ACCESS_KEY_ID'].present?
  Aws.config.update({
    region: ENV['AWS_REGION'] || 'us-east-1',
    credentials: Aws::Credentials.new(ENV['AWS_ACCESS_KEY_ID'], ENV['AWS_SECRET_ACCESS_KEY'])
  })

  # S3 Bucket (if needed)
  if ENV['S3_BUCKET_NAME'].present?
    S3_BUCKET = Aws::S3::Resource.new.bucket(ENV['S3_BUCKET_NAME'])
  end
end
