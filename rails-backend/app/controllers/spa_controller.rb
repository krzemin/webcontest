class SpaController < ApplicationController

    def prefetch_all
        respond_to do |format|
            format.json {
                render :json => {

                    :problem => {}
                    :submissions => []
                    
                    }
                }
            }
        end
    end


end