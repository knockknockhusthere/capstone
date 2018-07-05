class ScaffoldsController < ApplicationController
  # def root
  # end

  def index
    @scaffolds = File.read('../../../lib/assets/scaffolds.json')
  end

# private
#  def media_params
#    params.require(:work).permit(:title, :author, :description, :publication_year)
#  end
end
