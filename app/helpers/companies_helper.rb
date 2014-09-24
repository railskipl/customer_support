module CompaniesHelper

  def review_count(company)
    company.reviews.count
  end

  def is_user_compliment(review)
    if (review.review_type == 'compliment')
# && review.change_date == nil) || (review.review_type == 'complaint' && review.change_date != nil)
      return true
    else
      return false
    end
  end

  def review_complaint_count(company)
    company.reviews.by_review_type(:complaint).count
  end

  def review_compliment_count(company)
    company.reviews.by_review_type(:compliment).count
  end

  def change_complaint_count(company)
   company.reviews.by_review_type(:compliment).where("change_date IS NOT NULL").count
  end

  def pure_ratio_count(company)
    complaint = review_complaint_count(company).to_f
    compliment = review_compliment_count(company).to_f
    (complaint / (compliment.nonzero? || 1)) *100
  end

  def ratio_count(company)
    complaint = review_complaint_count(company)
    compliment = review_compliment_count(company).to_f
    (complaint / (compliment.nonzero? || 1)) *100
  end
end
