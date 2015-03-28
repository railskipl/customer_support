module Admin::ReportsHelper
    def total_reviews
		#total reviews according to compliment and complaints
		@compliments = Review.where('Date(created_at) >= ? and Date(created_at) <= ? and user_id is not null and review_type = ?', 1.year.ago, Date.today,'compliment')  rescue nil
		@complaints = Review.where('Date(created_at) >= ? and Date(created_at) <= ? and user_id is not null and review_type = ?', 1.year.ago, Date.today,'complaint')  rescue nil
		@total_converted = Review.where('Date(created_at) >= ? and Date(created_at) <= ? and user_id is not null and review_type = ? and change_date is not null', 1.year.ago, Date.today,'compliment')  rescue nil
	end

	def nature_of_complaints
		#nature of review for compliments
		@billing = Review.where('Date(created_at) >= ? and Date(created_at) <= ? and user_id is not null and nature_of_review = ?  ',1.year.ago, Date.today,'Billing/accounts') rescue nil
		@booking = Review.where('Date(created_at) >= ? and Date(created_at) <= ? and user_id is not null and nature_of_review = ?  ',1.year.ago, Date.today,'Booking') rescue nil
		@call_center = Review.where('Date(created_at) >= ? and Date(created_at) <= ? and user_id is not null and nature_of_review = ?  ',1.year.ago, Date.today,'Call centre efficiency') rescue nil
		@contract = Review.where('Date(created_at) >= ? and Date(created_at) <= ? and user_id is not null and nature_of_review = ?  ',1.year.ago, Date.today,'Contract') rescue nil
		@delivery = Review.where('Date(created_at) >= ? and Date(created_at) <= ? and user_id is not null and nature_of_review = ?  ',1.year.ago, Date.today,'Delivery on time') rescue nil
		@feedback = Review.where('Date(created_at) >= ? and Date(created_at) <= ? and user_id is not null and nature_of_review = ? ',1.year.ago, Date.today,'Feedback') rescue nil
		@going_extra = Review.where('Date(created_at) >= ? and Date(created_at) <= ? and user_id is not null and nature_of_review = ?  ',1.year.ago, Date.today,'Going the extra mile') rescue nil
		@great_attitude = Review.where('Date(created_at) >= ? and Date(created_at) <= ? and user_id is not null and nature_of_review = ?  ',1.year.ago, Date.today,'Great attitude') rescue nil
		@pricing = Review.where('Date(created_at) >= ? and Date(created_at) <= ? and user_id is not null and nature_of_review = ?  ',1.year.ago, Date.today,'Pricing') rescue nil
		@refund = Review.where('Date(created_at) >= ? and Date(created_at) <= ? and user_id is not null and nature_of_review = ?  ',1.year.ago, Date.today,'Refund') rescue nil
		@repairs = Review.where('Date(created_at) >= ? and Date(created_at) <= ? and user_id is not null and nature_of_review = ?  ',1.year.ago, Date.today,'Repairs') rescue nil
		@stock = Review.where('Date(created_at) >= ? and Date(created_at) <= ? and user_id is not null and nature_of_review = ?  ',1.year.ago, Date.today,'Stock') rescue nil
		@others = Review.where('Date(created_at) >= ? and Date(created_at) <= ? and user_id is not null and nature_of_review = ?  ',1.year.ago, Date.today,'Other') rescue nil

		#nature of review for complaints
		@bad_attitude = Review.where('Date(created_at) >= ? and Date(created_at) <= ? and user_id is not null and nature_of_review = ? ',1.year.ago, Date.today,'Bad attitude') rescue nil
		@billing_account = Review.where('Date(created_at) >= ? and Date(created_at) <= ? and user_id is not null and nature_of_review = ?  ',1.year.ago, Date.today,'Billing/Accounts') rescue nil
		@booking_query = Review.where('Date(created_at) >= ? and Date(created_at) <= ? and user_id is not null and nature_of_review = ?  ',1.year.ago, Date.today,'Booking query') rescue nil
		@breach_of_contract = Review.where('Date(created_at) >= ? and Date(created_at) <= ? and user_id is not null and nature_of_review = ?  ',1.year.ago, Date.today,'Breach of contract') rescue nil
		@call_centre_c = Review.where('Date(created_at) >= ? and Date(created_at) <= ? and user_id is not null and nature_of_review = ?  ',1.year.ago, Date.today,'Call centre') rescue nil
		@damaged_goods = Review.where('Date(created_at) >= ? and Date(created_at) <= ? and user_id is not null and nature_of_review = ?  ',1.year.ago, Date.today,'Damaged goods') rescue nil
		@expiry = Review.where('Date(created_at) >= ? and Date(created_at) <= ? and user_id is not null and nature_of_review = ?  ',1.year.ago, Date.today,'Expiry date') rescue nil
		@feedback_response = Review.where('Date(created_at) >= ? and Date(created_at) <= ? and user_id is not null and nature_of_review = ?  ',1.year.ago, Date.today,'Feedback/response') rescue nil
		@hygiene = Review.where('Date(created_at) >= ? and Date(created_at) <= ? and user_id is not null and nature_of_review = ? ',1.year.ago, Date.today,'Hygiene') rescue nil
		@Late_no_delivery = Review.where('Date(created_at) >= ? and Date(created_at) <= ? and user_id is not null and nature_of_review = ? ',1.year.ago, Date.today,'Late/no delivery') rescue nil
		@out_of_stock = Review.where('Date(created_at) >= ? and Date(created_at) <= ? and user_id is not null and nature_of_review = ?  ',1.year.ago, Date.today,'Out of stock') rescue nil
		@pricing_bar_codes = Review.where('Date(created_at) >= ? and Date(created_at) <= ? and user_id is not null and nature_of_review = ?  ',1.year.ago, Date.today,'Pricing/bar codes') rescue nil
		@repairs_servicing = Review.where('Date(created_at) >= ? and Date(created_at) <= ? and user_id is not null and nature_of_review = ?  ',1.year.ago, Date.today,'Repairs/servicing') rescue nil
		@spam = Review.where('Date(created_at) >= ? and Date(created_at) <= ? and user_id is not null and nature_of_review = ?  ',1.year.ago, Date.today,'Spam') rescue nil
		@others_c = Review.where('Date(created_at) >= ? and Date(created_at) <= ? and user_id is not null and nature_of_review = ?  ',1.year.ago, Date.today,'Other') rescue nil
	end

	def total_reviews_dump
		#total reviews according to compliment and complaints
		@compliments = Review.where('user_id is not null and review_type = ?','compliment')  rescue nil
		@complaints = Review.where('user_id is not null and review_type = ?', 'complaint')  rescue nil
		@total_converted = Review.where('user_id is not null and review_type = ? and change_date is not null','compliment')  rescue nil
	end

	def nature_of_complaints_dump
		#nature of review for compliments
		@billing = Review.where('user_id is not null and nature_of_review = ? and review_type = ? ','Billing/accounts', 'compliment') rescue nil
		@booking = Review.where('user_id is not null and nature_of_review = ? and review_type = ? ','Booking', 'compliment') rescue nil
		@call_center = Review.where('user_id is not null and nature_of_review = ? and review_type = ? ','Call centre efficiency', 'compliment') rescue nil
		@contract = Review.where('user_id is not null and nature_of_review = ? and review_type = ? ','Contract', 'compliment') rescue nil
		@delivery = Review.where('user_id is not null and nature_of_review = ? and review_type = ? ','Delivery on time', 'compliment') rescue nil
		@feedback = Review.where('user_id is not null and nature_of_review = ? and review_type = ?','Feedback', 'compliment') rescue nil
		@going_extra = Review.where('user_id is not null and nature_of_review = ? and review_type = ? ','Going the extra mile', 'compliment') rescue nil
		@great_attitude = Review.where('user_id is not null and nature_of_review = ? and review_type = ? ','Great attitude', 'compliment') rescue nil
		@pricing = Review.where('user_id is not null and nature_of_review = ? and review_type = ? ','Pricing', 'compliment') rescue nil
		@refund = Review.where('user_id is not null and nature_of_review = ? and review_type = ? ','Refund', 'compliment') rescue nil
		@repairs = Review.where('user_id is not null and nature_of_review = ? and review_type = ? ','Repairs', 'compliment') rescue nil
		@stock = Review.where('user_id is not null and nature_of_review = ? and review_type = ? ','Stock', 'compliment') rescue nil
		@others = Review.where('user_id is not null and nature_of_review = ? and review_type = ? ','Other', 'compliment') rescue nil

		#nature of review for complaints
		@bad_attitude = Review.where('user_id is not null and nature_of_review = ? and review_type = ?','Bad attitude', 'complaint') rescue nil
		@billing_account = Review.where('user_id is not null and nature_of_review = ? and review_type = ? ','Billing/Accounts', 'complaint') rescue nil
		@booking_query = Review.where('user_id is not null and nature_of_review = ? and review_type = ? ','Booking query', 'complaint') rescue nil
		@breach_of_contract = Review.where('user_id is not null and nature_of_review = ? and review_type = ? ','Breach of contract', 'complaint') rescue nil
		@call_centre_c = Review.where('user_id is not null and nature_of_review = ? and review_type = ? ','Call centre', 'complaint') rescue nil
		@damaged_goods = Review.where('user_id is not null and nature_of_review = ? and review_type = ? ','Damaged goods', 'complaint') rescue nil
		@expiry = Review.where('user_id is not null and nature_of_review = ? and review_type = ? ','Expiry date', 'complaint') rescue nil
		@feedback_response = Review.where('user_id is not null and nature_of_review = ? and review_type = ? ','Feedback/response', 'complaint') rescue nil
		@hygiene = Review.where('user_id is not null and nature_of_review = ? and review_type = ?','Hygiene', 'complaint') rescue nil
		@Late_no_delivery = Review.where('user_id is not null and nature_of_review = ? and review_type = ?','Late/no delivery', 'complaint') rescue nil
		@out_of_stock = Review.where('user_id is not null and nature_of_review = ? and review_type = ? ','Out of stock', 'complaint') rescue nil
		@pricing_bar_codes = Review.where('user_id is not null and nature_of_review = ? and review_type = ? ','Pricing/bar codes', 'complaint') rescue nil
		@repairs_servicing = Review.where('user_id is not null and nature_of_review = ? and review_type = ? ','Repairs/servicing', 'complaint') rescue nil
		@spam = Review.where('user_id is not null and nature_of_review = ? and review_type = ? ','Spam', 'complaint') rescue nil
		@others_c = Review.where('user_id is not null and nature_of_review = ? and review_type = ? ','Other', 'complaint') rescue nil
	end

	def industry_level #industries
		@industry = Industry.where('id = ?', params[:industry]).first
		
		#total number of complaints/compliments according to each industry
		@compliments = Review.where('Date(created_at) >= ? and Date(created_at) <= ? and user_id is not null and industry_id = ? and review_type = ?',1.year.ago, Date.today,@industry.id, 'compliment').count
		@complaints = Review.where('Date(created_at) >= ? and Date(created_at) <= ? and user_id is not null and industry_id = ? and review_type = ?',1.year.ago, Date.today,@industry.id, 'complaint').count
        #total number of compliments and complaints according to the nature of review
        
        #nature of review for compliments
		@billing = Review.where('Date(created_at) >= ? and Date(created_at) <= ? and industry_id = ? and user_id is not null and nature_of_review = ? and review_type = ?  ',1.year.ago, Date.today,  @industry.id ,'Billing/accounts', 'compliment').count rescue nil
		@booking = Review.where('Date(created_at) >= ? and Date(created_at) <= ? and user_id is not null and industry_id = ? and nature_of_review = ? and review_type = ?  ',1.year.ago, Date.today,@industry.id , 'Booking', 'compliment').count rescue nil
		@call_center = Review.where('Date(created_at) >= ? and Date(created_at) <= ? and user_id is not null and industry_id = ? and nature_of_review = ? and review_type = ? ',1.year.ago, Date.today,@industry.id,'Call centre efficiency', 'compliment').count rescue nil
		@contract = Review.where('Date(created_at) >= ? and Date(created_at) <= ? and user_id is not null and industry_id = ? and nature_of_review = ? and review_type = ? ',1.year.ago, Date.today,@industry.id,'Contract', 'compliment').count rescue nil
		@delivery = Review.where('Date(created_at) >= ? and Date(created_at) <= ? and user_id is not null and industry_id = ? and nature_of_review = ? and review_type = ? ',1.year.ago, Date.today,@industry.id,'Delivery on time', 'compliment').count rescue nil
		@feedback = Review.where('Date(created_at) >= ? and Date(created_at) <= ? and user_id is not null and industry_id = ? and nature_of_review = ? and review_type = ? ',1.year.ago, Date.today,@industry.id,'Feedback', 'compliment').count rescue nil
		@going_extra = Review.where('Date(created_at) >= ? and Date(created_at) <= ? and user_id is not null and industry_id = ? and nature_of_review = ? and review_type = ? ',1.year.ago, Date.today,@industry.id,'Going the extra mile', 'compliment').count rescue nil
		@great_attitude = Review.where('Date(created_at) >= ? and Date(created_at) <= ? and user_id is not null and industry_id = ? and nature_of_review = ? and review_type = ? ',1.year.ago, Date.today,@industry.id,'Great attitude', 'compliment').count rescue nil
		@pricing = Review.where('Date(created_at) >= ? and Date(created_at) <= ? and user_id is not null and industry_id = ? and nature_of_review = ? and review_type = ? ',1.year.ago, Date.today,@industry.id,'Pricing', 'compliment').count rescue nil
		@refund = Review.where('Date(created_at) >= ? and Date(created_at) <= ? and user_id is not null and industry_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,@industry.id,'Refund', 'compliment').count  rescue nil
		@repairs = Review.where('Date(created_at) >= ? and Date(created_at) <= ? and user_id is not null and industry_id = ? and nature_of_review = ? and review_type = ? ',1.year.ago, Date.today,@industry.id,'Repairs', 'compliment').count rescue nil
		@stock = Review.where('Date(created_at) >= ? and Date(created_at) <= ? and user_id is not null and industry_id = ? and nature_of_review = ? and review_type = ? ',1.year.ago, Date.today,@industry.id,'Stock', 'compliment').count rescue nil
		@others = Review.where('Date(created_at) >= ? and Date(created_at) <= ? and user_id is not null and industry_id = ? and nature_of_review = ? and review_type = ? ',1.year.ago, Date.today,@industry.id,'Other', 'compliment').count rescue nil

        #nature of review for complaints
		@bad_attitude = Review.where('Date(created_at) >= ? and Date(Date(created_at)) <= ? and user_id is not null and industry_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,@industry.id,'Bad attitude', 'complaint').count rescue nil
		
		@billing_account = Review.where('Date(created_at) >= ? and Date(created_at) <= ? and user_id is not null and industry_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,@industry.id,'Billing/Accounts', 'complaint').count rescue nil
		@booking_query = Review.where('Date(created_at) >= ? and Date(created_at) <= ? and user_id is not null and industry_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,@industry.id,'Booking query', 'complaint').count rescue nil
		@breach_of_contract = Review.where('Date(created_at) >= ? and Date(created_at) <= ? and user_id is not null and industry_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,@industry.id,'Breach of contract', 'complaint').count rescue nil
		@call_centre_c = Review.where('Date(created_at) >= ? and Date(created_at) <= ? and user_id is not null and industry_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,@industry.id,'Call centre', 'complaint').count rescue nil
		@damaged_goods = Review.where('Date(created_at) >= ? and Date(created_at) <= ? and user_id is not null and industry_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,@industry.id,'Damaged goods', 'complaint').count rescue nil
		@expiry = Review.where('Date(created_at) >= ? and Date(created_at) <= ? and user_id is not null and industry_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,@industry.id,'Expiry date', 'complaint').count rescue nil
		@feedback_response = Review.where('Date(created_at) >= ? and Date(created_at) <= ? and user_id is not null and industry_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,@industry.id,'Feedback/response', 'complaint').count rescue nil
		@hygiene = Review.where('Date(created_at) >= ? and Date(created_at) <= ? and user_id is not null and industry_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,@industry.id,'Hygiene', 'complaint').count rescue nil
		@Late_no_delivery = Review.where('Date(created_at) >= ? and Date(created_at) <= ? and user_id is not null and industry_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,@industry.id,'Late/no delivery', 'complaint').count rescue nil
		@out_of_stock = Review.where('Date(created_at) >= ? and Date(created_at) <= ? and user_id is not null and industry_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,@industry.id,'Out of stock', 'complaint').count rescue nil
		@pricing_bar_codes = Review.where('Date(created_at) >= ? and Date(created_at) <= ? and user_id is not null and industry_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,@industry.id,'Pricing/bar codes', 'complaint').count rescue nil
		@repairs_servicing = Review.where('Date(created_at) >= ? and Date(created_at) <= ? and user_id is not null and industry_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,@industry.id,'Repairs/servicing', 'complaint').count rescue nil
		@spam = Review.where('Date(created_at) >= ? and Date(created_at) <= ? and user_id is not null and industry_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,@industry.id,'Spam', 'complaint').count rescue nil
		@others_c = Review.where('Date(created_at) >= ? and Date(created_at) <= ? and user_id is not null and industry_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,@industry.id,'Other', 'complaint').count rescue nil
        send_data(render_to_string(:template=>"admin/reports/industry_level.html.erb" ) , :type=>"text/xls",:filename => "customer_summary.xls")
	end

   def supplier_level #company/suppliers
   	    @company = Company.where('id = ?', params[:company]).first
   	    
		#total number of complaints/compliments according to each industry
		@compliments = Review.where('Date(created_at) >= ? and Date(created_at) <= ? and user_id is not null and company_id = ? and review_type = ?',1.year.ago, Date.today,@company.id, 'compliment').count rescue nil
		@complaints = Review.where('Date(created_at) >= ? and Date(created_at) <= ? and user_id is not null and company_id = ? and review_type = ?',1.year.ago, Date.today,@company.id, 'complaint').count rescue nil
        #total number of compliments and complaints according to the nature of review
        
        #nature of review for compliments
		@billing = Review.where('Date(created_at) >= ? and Date(created_at) <= ? and user_id is not null and company_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today, @company.id ,'Billing/accounts', 'compliment').count rescue nil
		@booking = Review.where('Date(created_at) >= ? and Date(created_at) <= ? and user_id is not null and company_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,@company.id , 'Booking', 'compliment').count rescue nil
		@call_center = Review.where('Date(created_at) >= ? and Date(created_at) <= ? and user_id is not null and company_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,@company.id,'Call centre efficiency', 'compliment').count rescue nil
		@contract = Review.where('Date(created_at) >= ? and Date(created_at) <= ? and user_id is not null and company_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,@company.id,'Contract', 'compliment').count rescue nil
		@delivery = Review.where('Date(created_at) >= ? and Date(created_at) <= ? and user_id is not null and company_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,@company.id,'Delivery on time', 'compliment').count rescue nil
		@feedback = Review.where('Date(created_at) >= ? and Date(created_at) <= ? and user_id is not null and company_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,@company.id,'Feedback', 'compliment').count rescue nil
		@going_extra = Review.where('Date(created_at) >= ? and Date(created_at) <= ? and user_id is not null and company_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,@company.id,'Going the extra mile', 'compliment').count rescue nil
		@great_attitude = Review.where('Date(created_at) >= ? and Date(created_at) <= ? and user_id is not null and company_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,@company.id,'Great attitude', 'compliment').count rescue nil
		@pricing = Review.where('Date(created_at) >= ? and Date(created_at) <= ? and user_id is not null and company_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,@company.id,'Pricing', 'compliment').count rescue nil
		@refund = Review.where('Date(created_at) >= ? and Date(created_at) <= ? and user_id is not null and company_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,@company.id,'Refund', 'compliment').count rescue nil
		@repairs = Review.where('Date(created_at) >= ? and Date(created_at) <= ? and user_id is not null and company_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,@company.id,'Repairs', 'compliment').count rescue nil
		@stock = Review.where('Date(created_at) >= ? and Date(created_at) <= ? and user_id is not null and company_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,@company.id,'Stock', 'compliment').count rescue nil
		@others = Review.where('Date(created_at) >= ? and Date(created_at) <= ? and user_id is not null and company_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,@company.id,'Other', 'compliment').count rescue nil

        #nature of review for complaints
		@bad_attitude = Review.where('Date(created_at) >= ? and Date(created_at) <= ? and user_id is not null and company_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,@company.id,'Bad attitude', 'complaint').count rescue nil
		@billing_account = Review.where('Date(created_at) >= ? and Date(created_at) <= ? and user_id is not null and company_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,@company.id,'Billing/Accounts', 'complaint').count rescue nil
		@booking_query = Review.where('Date(created_at) >= ? and Date(created_at) <= ? and user_id is not null and company_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,@company.id,'Booking query', 'complaint').count rescue nil
		@breach_of_contract = Review.where('Date(created_at) >= ? and Date(created_at) <= ? and user_id is not null and company_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,@company.id,'Breach of contract', 'complaint').count rescue nil
		@call_centre_c = Review.where('Date(created_at) >= ? and Date(created_at) <= ? and user_id is not null and company_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,@company.id,'Call centre', 'complaint').count rescue nil
		@damaged_goods = Review.where('Date(created_at) >= ? and Date(created_at) <= ? and user_id is not null and company_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,@company.id,'Damaged goods', 'complaint').count rescue nil
		@expiry = Review.where('Date(created_at) >= ? and Date(created_at) <= ? and user_id is not null and company_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,@company.id,'Expiry date', 'complaint').count rescue nil
		@feedback_response = Review.where('Date(created_at) >= ? and Date(created_at) <= ? and user_id is not null and company_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,@company.id,'Feedback/response', 'complaint').count rescue nil
		@hygiene = Review.where('Date(created_at) >= ? and Date(created_at) <= ? and user_id is not null and company_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,@company.id,'Hygiene', 'complaint').count rescue nil
		@Late_no_delivery = Review.where('Date(created_at) >= ? and Date(created_at) <= ? and user_id is not null and company_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,@company.id,'Late/no delivery', 'complaint').count rescue nil
		@out_of_stock = Review.where('Date(created_at) >= ? and Date(created_at) <= ? and user_id is not null and company_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,@company.id,'Out of stock', 'complaint').count rescue nil
		@pricing_bar_codes = Review.where('Date(created_at) >= ? and Date(created_at) <= ? and user_id is not null and company_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,@company.id,'Pricing/bar codes', 'complaint').count rescue nil
		@repairs_servicing = Review.where('Date(created_at) >= ? and Date(created_at) <= ? and user_id is not null and company_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,@company.id,'Repairs/servicing', 'complaint').count rescue nil
		@spam = Review.where('Date(created_at) >= ? and Date(created_at) <= ? and user_id is not null and company_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,@company.id,'Spam', 'complaint').count rescue nil
		@others_c = Review.where('Date(created_at) >= ? and Date(created_at) <= ? and user_id is not null and company_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,@company.id,'Other', 'complaint').count rescue nil
   end

   def most_compliments
   	    @most_compliment = Review.select(:company_id).where('Date(created_at) >= ? and Date(created_at) <= ? and review_type = ? and user_id is not null',1.year.ago, Date.today, 'compliment').map(&:company_id) rescue nil
   	    freq = @most_compliment.inject(Hash.new(0)) { |h,v| h[v] += 1; h }
   	    @value_compliments = @most_compliment.max_by { |v| freq[v] }
   	    @max_compliment = freq.values.max
   	 
        # Most complaints for supplier
   	    @most_complaint = Review.select(:company_id).where('Date(created_at) >= ? and Date(created_at) <= ? and review_type = ? and user_id is not null',1.year.ago, Date.today, 'complaint').map(&:company_id) rescue nil
   	    freq = @most_complaint.inject(Hash.new(0)) { |h,v| h[v] += 1; h }
   	    @value_complaints = @most_complaint.max_by { |v| freq[v] }
   	    @max_complaint = freq.values.max
   end

   def all_customers 
      if params[:subaction] == "all_customer"
   	  	@start_from = params[:report1][:start_date] rescue ""
   	  	@start_to = params[:report1][:end_date] rescue ""
        if @start_from > @start_to
          flash[:notice] = "Start date cannot be greater than End date."
        else
          
        end
      elsif params[:id] == "data_dump"
      	@customers ||= User.customers rescue nil
        send_data(render_to_string(:template=>"admin/reports/all_customers.html.erb" ) , :type=>"text/xls",:filename => "all_customers.xls")
      else
      	  @start_from = 1.year.ago 
   	  	  @start_to =  Date.today 
      end
      @customers ||= User.where('Date(created_at) >= ? and Date(created_at) <= ?',@start_from, @start_to).customers rescue nil
  end
   

   def active_customers
   	  @users = Review.select(:id,:user_id).where('Date(created_at) >= ? and Date(created_at) <= ? and user_id is not null', 6.months.ago, Date.today).map(&:user_id).uniq rescue nil
      respond_to do |format|
        format.html # index.html.erb
        format.xls
      end
   end

   def customer_record
   	  if params[:subaction] == "customer_record"
   	  	preferredalias = params[:report2][:customer]
   	  	user = User.find_by_preferred_alias(preferredalias)
   	  	@start_from = params[:report2][:start_date] rescue ""
   	  	@start_to = params[:report2][:end_date] rescue ""
   	  
        if @start_from > @start_to
          flash[:notice] = "Start date cannot be greater than End date."
        else
          
        end
      elsif params[:id] == "data_dump"
      	@users = Review.select(:id,:user_id).where('user_id is not null').map(&:user_id).uniq rescue nil
        send_data(render_to_string(:template=>"admin/reports/customer_record.html.erb" ) , :type=>"text/xls",:filename => "all_customer_summary.xls")
      else
      	  @start_from = 1.year.ago 
   	  	  @start_to =  Date.today 
      end
      unless params[:id] == "data_dump"
   	    if user.nil?
   	      @users = Review.select(:id,:user_id).where('Date(created_at) >= ? and Date(created_at) <= ? and user_id is not null', @start_from, @start_to).map(&:user_id).uniq rescue nil
          send_data(render_to_string(:template=>"admin/reports/customer_record.html.erb" ) , :type=>"text/xls",:filename => "customer_summary.xls")
   	    else
   	      @users = Review.select(:id,:user_id).where('Date(created_at) >= ? and Date(created_at) <= ? and user_id = ?', @start_from, @start_to,user.id).map(&:user_id).uniq rescue nil
          send_data(render_to_string(:template=>"admin/reports/customer_record.html.erb" ) , :type=>"text/xls",:filename => "customer_summary.xls")
        end
      end
   end

   def industry_xls
   	  if params[:subaction] == "industry_total"
   	  	 industry = Industry.find(params[:report][:industry]) unless params[:report][:industry].blank?

   	  	@start_from = params[:report][:start_date] rescue ""
   	  	@start_to = params[:report][:end_date] rescue ""
   	  
        if @start_from > @start_to
          flash[:notice] = "Start date cannot be greater than End date."
        else
          if industry.nil?	
            @industries = Industry.all
          else
            @industries = Industry.where('id = ?', industry.id) rescue nil
          end
          send_data(render_to_string(:template=>"admin/reports/industry_xls.html.erb" ) , :type=>"text/xls",:filename => "industries.xls")
        end
      elsif params[:id] == "data_dump"
      	  @industries = Industry.all rescue nil
          send_data(render_to_string(:template=>"admin/reports/industry_xls.html.erb" ) , :type=>"text/xls",:filename => "industries.xls")
      else
      	  @start_from = 1.year.ago 
   	  	  @start_to =  Date.today 
      	  @industries = Industry.all rescue nil
      	  send_data(render_to_string(:template=>"admin/reports/industry_xls.html.erb" ) , :type=>"text/xls",:filename => "industries.xls")
      end
   end

   def get_company_from_supplier(company)
   	  Company.find_by_title(company.supplier_name)
   end

   def company_xls
   	 if params[:subaction] == "company_total"
   	  	@start_from = params[:report][:start_date] rescue ""
   	  	@start_to = params[:report][:end_date] rescue ""
   	  
        if @start_from > @start_to
          flash[:notice] = "Start date cannot be greater than End date."
        else
          @companies = Company.all rescue nil
          send_data(render_to_string(:template=>"admin/reports/company_xls.html.erb" ) , :type=>"text/xls",:filename => "companies.xls")
        end
      elsif params[:id] == "data_dump"
      	  @companies = Company.all rescue nil
          send_data(render_to_string(:template=>"admin/reports/company_xls.html.erb" ) , :type=>"text/xls",:filename => "companies.xls")
      else
      	  @companies = Company.all rescue nil
      	  @start_from = 1.year.ago 
   	  	  @start_to =  Date.today 
      	  send_data(render_to_string(:template=>"admin/reports/company_xls.html.erb" ) , :type=>"text/xls",:filename => "companies.xls")
      end
   end

   def total_xls
   	   if params[:id] == "data_dump"
   	      total_reviews_dump
   	      nature_of_complaints_dump
          send_data(render_to_string(:template=>"admin/reports/total_xls.html.erb" ) , :type=>"text/xls",:filename => "total_reviews.xls")
      else
      	  total_reviews
   	      nature_of_complaints
      	  send_data(render_to_string(:template=>"admin/reports/total_xls.html.erb" ) , :type=>"text/xls",:filename => "total_reviews.xls")
      end
   	 #send_data(render_to_string(:template=>"admin/reports/total_xls.html.erb" ) , :type=>"text/xls",:filename => "total_reviews.xls")
   end

   def most_company_xls
   	  # Most compliments for supplier
      if params[:subaction] == "most_company"
   	  	@start_from = params[:report5][:start_date] rescue ""
   	  	@start_to = params[:report5][:end_date] rescue ""
   	  	company = Company.find_by_title(params[:report5][:company])
        if @start_from > @start_to
          flash[:notice] = "Start date cannot be greater than End date."
        else
          @start_from
          @start_to
        end
      elsif params[:id] == "data_dump"
      	@most_compliment = Review.select(:company_id).where('review_type = ? and user_id is not null','compliment').map(&:company_id) rescue nil
   	    freq = @most_compliment.inject(Hash.new(0)) { |h,v| h[v] += 1; h }
   	    @value_compliments = @most_compliment.max_by { |v| freq[v] }
   	    @max_compliment = freq.values.max
   	    @compliments = Review.where('user_id is not null and company_id = ? and review_type = ?',@value_compliments, 'compliment') rescue nil
        # Most complaints for supplier
   	    @most_complaint = Review.select(:company_id).where('review_type = ? and user_id is not null','complaint').map(&:company_id) rescue nil
   	    freq = @most_complaint.inject(Hash.new(0)) { |h,v| h[v] += 1; h }
   	    @value_complaints = @most_complaint.max_by { |v| freq[v] }
   	    @max_complaint = freq.values.max
   	    @complaints = Review.where('user_id is not null and company_id = ? and review_type = ?',@value_complaints, 'complaint') rescue nil
   	    send_data(render_to_string(:template=>"admin/reports/most_company_xls.html.erb" ) , :type=>"text/xls",:filename => "most_compliments_complaints.xls")
      	
      else
      	  @start_from = 1.year.ago 
   	  	  @start_to =  Date.today 
      end
        unless params[:id] == "data_dump"
          if company.nil? 
	        @most_compliment = Review.select(:company_id).where('Date(created_at) >= ? and Date(created_at) <= ? and review_type = ? and user_id is not null',@start_from, @start_to, 'compliment').map(&:company_id) rescue nil
	   	    freq = @most_compliment.inject(Hash.new(0)) { |h,v| h[v] += 1; h }
	   	    @value_compliments = @most_compliment.max_by { |v| freq[v] }
	   	    @max_compliment = freq.values.max
	   	    @compliments = Review.where('Date(created_at) >= ? and Date(created_at) <= ? and user_id is not null and company_id = ? and review_type = ?',@start_from, @start_to,@value_compliments, 'compliment') rescue nil
	        # Most complaints for supplier
	   	    @most_complaint = Review.select(:company_id).where('company_id = ? and Date(created_at) >= ? and Date(created_at) <= ? and review_type = ? and user_id is not null',company.id,@start_from, @start_to, 'complaint').map(&:company_id) rescue nil
	   	    freq = @most_complaint.inject(Hash.new(0)) { |h,v| h[v] += 1; h }
	   	    @value_complaints = @most_complaint.max_by { |v| freq[v] }
	   	    @max_complaint = freq.values.max
	   	    @complaints = Review.where('Date(created_at) >= ? and Date(created_at) <= ? and user_id is not null and company_id = ? and review_type = ?',@start_from, @start_to,@value_complaints, 'complaint') rescue nil
	   	    send_data(render_to_string(:template=>"admin/reports/most_company_xls.html.erb" ) , :type=>"text/xls",:filename => "most_compliments_complaints.xls")
	   	  else
	   		@most_compliment = Review.select(:company_id).where('company_id = ? and Date(created_at) >= ? and Date(created_at) <= ? and review_type = ? and user_id is not null',company.id,@start_from, @start_to, 'compliment').map(&:company_id) rescue nil
	   	    freq = @most_compliment.inject(Hash.new(0)) { |h,v| h[v] += 1; h }
	   	    @value_compliments = @most_compliment.max_by { |v| freq[v] }
	   	    @max_compliment = freq.values.max
	   	    @compliments = Review.where('Date(created_at) >= ? and Date(created_at) <= ? and user_id is not null and company_id = ? and review_type = ?',@start_from, @start_to,@value_compliments, 'compliment') rescue nil
	        # Most complaints for supplier
	   	    @most_complaint = Review.select(:company_id).where('company_id = ? and Date(created_at) >= ? and Date(created_at) <= ? and review_type = ? and user_id is not null',company.id,@start_from, @start_to, 'complaint').map(&:company_id) rescue nil
	   	    freq = @most_complaint.inject(Hash.new(0)) { |h,v| h[v] += 1; h }
	   	    @value_complaints = @most_complaint.max_by { |v| freq[v] }
	   	    @max_complaint = freq.values.max
	   	    @complaints = Review.where('company_id = ? and Date(created_at) >= ? and Date(created_at) <= ? and user_id is not null and company_id = ? and review_type = ?',company.id,@start_from, @start_to,@value_complaints, 'complaint') rescue nil
	   	    send_data(render_to_string(:template=>"admin/reports/most_company_xls.html.erb" ) , :type=>"text/xls",:filename => "most_compliments_complaints.xls")
          end
        end
   end

   def conversion_industry

  	if params[:subaction] == "conversion_industry"
   	  	@start_from = params[:report1][:start_date] rescue ""
   	  	@start_to = params[:report1][:end_date] rescue ""
        if @start_from > @start_to
          flash[:notice] = "Start date cannot be greater than End date."
        else
          
        end
      elsif params[:id] == "data_dump"
      else
      	  @start_from = 1.year.ago 
   	  	  @start_to =  Date.today 
      end
  	  @industries = Industry.all rescue nil
  	  send_data(render_to_string(:template=>"admin/reports/conversion_industry.html.erb" ) , :type=>"text/xls",:filename => "conversion_industry.xls")
  end

  def conversion_company
  	if params[:subaction] == "conversion_company"
   	  	@start_from = params[:report1][:start_date] rescue ""
   	  	@start_to = params[:report1][:end_date] rescue ""
        if @start_from > @start_to
          flash[:notice] = "Start date cannot be greater than End date."
        else
          
        end
      elsif params[:id] == "data_dump"
      else
      	  @start_from = 1.year.ago 
   	  	  @start_to =  Date.today 
      end
      @companies = Company.all rescue nil
      send_data(render_to_string(:template=>"admin/reports/conversion_company.html.erb" ) , :type=>"text/xls",:filename => "conversion_company.xls")
  end

  def jagent
  	if params[:subaction] == "junior_agent"
   	  	@start_from = params[:report1][:start_date] rescue ""
   	  	@start_to = params[:report1][:end_date] rescue ""
        if @start_from > @start_to
          flash[:notice] = "Start date cannot be greater than End date."
        else
          
        end
      elsif params[:id] == "data_dump"
      	@jagents = User.where('role = ?','jagent')
        send_data(render_to_string(:template=>"admin/reports/jagent.html.erb" ) , :type=>"text/xls",:filename => "junior_agent.xls")
      else
      	  @start_from = 1.year.ago 
   	  	  @start_to =  Date.today 
      end
      unless params[:id] == "data_dump"
  	   @jagents = User.where('Date(created_at) >= ? and Date(created_at) <= ? and role = ?', @start_from, @start_to, 'jagent')
	    respond_to do |format|
	    	format.html # index.html.erb
	        format.xls
	    end
	  end
  end

  def sagent
    if params[:subaction] == "senior_agent"
   	  	@start_from = params[:report1][:start_date] rescue ""
   	  	@start_to = params[:report1][:end_date] rescue ""
        if @start_from > @start_to
          flash[:notice] = "Start date cannot be greater than End date."
        else
          
        end
      elsif params[:id] == "data_dump"
      	@sagents = User.where('role = ?','agent')
        send_data(render_to_string(:template=>"admin/reports/sagent.html.erb" ) , :type=>"text/xls",:filename => "senior_agent.xls")
      else
      	  @start_from = 1.year.ago 
   	  	  @start_to =  Date.today 
      end
      unless params[:id] == "data_dump"
  	    @sagents = User.where('Date(created_at) >= ? and Date(created_at) <= ? and role = ?', @start_from, @start_to, 'agent')
	    respond_to do |format|
	    	format.html # index.html.erb
	        format.xls
	    end
	  end
  end

  def industry_conversion
  	@industries = Industry.all rescue nil
  	send_data(render_to_string(:template=>"admin/reports/industry_conversion.html.erb" ) , :type=>"text/xls",:filename => "industries_conversion_data.xls")
  end

  def company_conversion
  	@companies = Company.all rescue nil
  	send_data(render_to_string(:template=>"admin/reports/company_conversion.html.erb" ) , :type=>"text/xls",:filename => "companies_conversion_data.xls")
  end

end
