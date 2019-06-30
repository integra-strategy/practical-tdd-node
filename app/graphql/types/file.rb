class Types::File < Types::BaseObject
  field :url, Types::Url, "The URL of the file", null: true
  field :name, String, "The name of the file", null: true

  def initialize(active_storage_file, block)
    @active_storage_file = active_storage_file
    super(active_storage_file, block)
  end

  def url
    return nil unless active_storage_file_exists?
    Rails.application.routes.url_helpers.rails_blob_path(@active_storage_file, only_path: true)
  end

  def name
    return nil unless active_storage_file_exists?
    @active_storage_file.filename.to_s
  end

  private

  def active_storage_file_exists?
    @active_storage_file.present? && @active_storage_file.try(:signed_id)
  end
end