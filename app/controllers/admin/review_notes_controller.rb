class Admin::ReviewNotesController < ApplicationController
	def create
	  @review_note = ReviewNote.new(params_review_notes)
	  if @review_note.save
	  	redirect_to :back, :notice => "Note successfuly saved"
	  else
	  end
	end

	private

	def params_review_notes
		params.require(:review_note).permit(:name, :note,:review_id)
	end
end
