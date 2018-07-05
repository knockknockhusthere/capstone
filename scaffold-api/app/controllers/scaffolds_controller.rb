require 'pry'

class ScaffoldsController < ApplicationController
  # def root
  # end

  def index
    scaffolds = File.read(Rails.root.join('lib', 'assets', 'scaffolds.json'))

    render json: scaffolds
  end

# private
#  def media_params
#    params.require(:work).permit(:title, :author, :description, :publication_year)
#  end
end
