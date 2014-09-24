class Faq < ActiveRecord::Base
	validates :question, :answer, presence: true
#	validates :question_number, uniqueness: true
#	validates :question_number, numericality: true

	def displayable_question
		self.question
	end
end
