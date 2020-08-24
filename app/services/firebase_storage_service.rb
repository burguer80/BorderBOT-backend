# frozen_string_literal: true

class FirebaseStorageService
  # f = FirebaseStorageService.new("borderbot-staging.appspot.com")
  def initialize(bucket_name)
    storage = init_firebase
    @bucket = storage.bucket bucket_name
  end

  def upload_file(local_file_path, storage_file_path)
    file = @bucket.create_file(local_file_path, storage_file_path)
    file.acl.public!
    p puts "Uploaded #{file.public_url}"
  end

  private

  def init_firebase
    Google::Cloud::Storage.new(
      project_id: ENV["firestore_project_id"],
      credentials: "config/borderbot-firebase-firebase-adminsdk.json")
  end
end

# multiple files
# f = FirebaseStorageService.new("borderbot-staging.appspot.com")
# port_ids = PortDetail.all.map(&:number)
# ports = []
# port_ids.each do |id|
#   ports << PortWaitTime.where(port_number: id).last
# end
#
# ports.each do |port|
#   name = port.port_number.to_s
#   File.open("public/#{name}.json", "w") do |f|
#     f.write(port.to_json)
#   end
#   f.upload_file("public/#{name}.json", "/bwt/#{name}.json")
#   p name
# end

# single file
# f = FirebaseStorageService.new("borderbot-staging.appspot.com")
# port_ids = PortDetail.all.map(&:number)
# btw = []
# port_ids.each do |id|
#   pwt = PortWaitTime.where(port_number: id).last
#   btw << pwt if pwt
# end
#
#
# name = 'btw'
# File.open("public/#{name}.json", "w") do |f|
#   f.write(btw.to_json)
# end
# f.upload_file("public/#{name}.json", "#{name}.json")
# p name
#
#
# Upload portDetails in a single file
#
# f = FirebaseStorageService.new("borderbot-staging.appspot.com")
#
# ports = PortDetail.all
# # ports.each do |port|
# name = 'ports'
# File.open("public/#{name}.json", "w") do |f|
#   f.write(ports.to_json)
# end
# f.upload_file("public/#{name}.json", "#{name}.json")
# p name
# # end
#