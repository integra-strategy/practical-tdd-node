class DirectUploadsController < ActiveStorage::DirectUploadsController
  skip_before_action :verify_authenticity_token, only: :create
end