module CompaniesHelper

  def review_count(company)
    c = Company.includes(:reviews).find_by_title(company.supplier_name)
    c.reviews.where("published_date is not null").count
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
    c = Company.includes(:reviews).find_by_title(company.supplier_name)
    c.reviews.where("published_date is not null").by_review_type(:complaint).count
  end

  def review_compliment_count(company)
    c = Company.includes(:reviews).find_by_title(company.supplier_name)
    c.reviews.where("published_date is not null").by_review_type(:compliment).count
  end

  def change_complaint_count(company)
   c = Company.includes(:reviews).find_by_title(company.supplier_name)
   c.reviews.by_review_type(:compliment).where("change_date IS NOT NULL").count
  end

  def pure_ratio_count(company)
    complaint = review_complaint_count(company).to_f
    compliment = review_compliment_count(company).to_f
    total = complaint + compliment
    if total.to_f == 0.0
      '-'
    else
      (complaint / total.to_f * 100).round(2)
    end
  end

  def ratio_count(company)
    complaint = review_complaint_count(company).to_f
    compliment = review_compliment_count(company).to_f
    total = complaint + compliment
    complaint / total.to_f * 100
  end
end
