class HomeController < ApplicationController
  def index
  end

  def to_sales
  end

  def download
    send_file full_path, type: "application", x_sendfile: true
   end

  private

  def full_path
    File.join(Rails.root, "public", "application", "#{params[:filename]}.#{params[:format]}")
  end
end
