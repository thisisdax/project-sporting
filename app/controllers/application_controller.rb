class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :merge_params

  def merge_params(p={})
    params.permit.merge(p).delete_if{|k,v| v.blank?}
  end
end
