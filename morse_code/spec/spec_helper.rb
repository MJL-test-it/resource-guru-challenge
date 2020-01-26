RSpec.configure do |config|
  config.after(:suite) do
    FileUtils.rm Dir.glob('spec/support/*').grep(/morse(_\d*)?\.txt/)
    FileUtils.rm Dir.glob('translations/*').grep(/morse(_\d*)?\.txt/)
  end
end