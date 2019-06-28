class Types::File < Types::BaseObject
  field :url, Types::Url, "The URL of the file on S3", null: false
  field :name, String, "The name of the file", null: false

  def initialize(active_storage_file, block)
    @active_storage_file = active_storage_file
    super(active_storage_file, block)
  end

  def url
    Rails.application.routes.url_helpers.rails_blob_path(@active_storage_file, only_path: true)
  end

  def name
    @active_storage_file.filename.to_s
  end
end