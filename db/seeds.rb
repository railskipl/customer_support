# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

# Examples:

#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user = User.new(first_name: 'admin',last_name: 'admin',email: 'admin@xemasupport.com',password: 'password',role: 'admin',confirmed_at: '2014-04-10 10:19:33.008972')
user.save(:validate=>false)

NatureOfReview.delete_all

[ "Bad attitude",
  "Billing/Accounts",
  "Booking query",
	"Breach of contract",
	"Call centre",
	"Damaged goods",
	"Expiry date",
	"Feedback/response",
	"Hygiene",
	"Late/no delivery",
	"Out of stock",
	"Pricing/bar codes",
	"Repairs/servicing",
	"Spam",
	"Other"].each do |complaint|
			NatureOfReview.create(:title=>complaint,:review_type=>"complaint")
	end

[
	"Billing/accounts",
	"Booking",
	"Call centre efficiency",
	"Contract",
	"Delivery on time",
	"Feedback",
	"Going the extra mile",
	"Great attitude",
	"Pricing",
	"Refund",
	"Repairs",
	"Stock",
	"Other"
	].each do |compliment|
			NatureOfReview.create(:title=>compliment,:review_type=>"compliment")
	end

  Industry.delete_all

	["Air Travel",
  "Banking",
	"Broadcast",
	"Bus Companies",
	"County Head Offices",
	"Doctors",
	"Entertainment",
	"Government",
	"Hospitals",
	"Hotels",
	"Insurance",
	"Internet",
	"Motor",
	"Opticians",
	"Pay TV",
	"Police",
	"Real Estate",
	"Restaurants",
	"Retail",
	"Schools",
	"Supermarkets",
	"Taxi Companies",
	"Telecommunications",
	"University"].each do |industry|
			Industry.create(:title=>industry)
	end

	Company.delete_all

	[ "ABC Bank",
	"Bank of  Africa Kenya Limited",
	"Bank of Baroda",
	"Barclays",
	"CFC Stanbic",
	"Chase Bank",
	"CBA",
	"Co-operative Bank Of Kenya",
	"Credit Bank",
	"Diamond Trust Bank",
	"Eco Bank",
	"Equatorial Commercial Bank Limited",
	"Equity Bank",
	"Family Bank",
	"First Community Bank",
	"Giro Bank",
	"Guardian Bank",
	"I&M",
	"Kenya Commercial Bank",
	"K-rep Bank",
	"National Bank of Kenya",
	"Prime Bank",
	"Standard Chartered Bank"].each do |company|
		Company.create(:title=>company,:industry_id=>2)
	end

	["Kisumu",
		"Mombasa",
		"Nairobi"
	].each do |town|
			Town.create(:title=>town)
		end

["Jubilee House",
"Centre Square",
"Kisumu",
"Oginga Odinga Road",
"Tivoli Centre Road",
"Kisumu East",
"United Mall",
"Mega Plaza",
"Angwana",
"Kisumu Al-Imrani",
"Giro House",
"Amalo Plaza",
"Kisumu Airport",
"Kisumu West",
"Kenya Re-Insurance Plaza"
].each do |location|
	Location.create(:title=>location,:town_id=>1)
end

page = Page.new(:name=>"About us", :title=> "Importance of feedback",
            :description => "Genuine customer feedback provides extremely valuable insight for businesses. Both good and bad feedback is essential. It facilitates companies to correct errors, better the good and keep up with the consumer trends. More often than not it is an all-round value adding process.

However research shows that for every customer complaint there are 26 other unhappy customers who remained silent. This proves that little feedback is given by customers. Frustrating process, distrust for follow up on feedback given, lengthy … , are among other challenges faced by customers giving feedback.

A public feedback platform will eliminate some of the problems in that it is independent, less biased, allows sharing, transparent and possibly faster against one on one feedback. This will better the overall effect on customer service and value creation.

Kenya does not have a forum like this, leaving companies not accountable and paying less attention on customer service. We would like to challenge and change this. {Name} is the platform that will give the customer in Kenya the chance to give ratings, Kudos and also challenge those that do not deliver. Customers are therefore encouraged … Come all let's give a ranking. We deserve better!",:slug=>"importance-of-feedback")

page.save(:validates=>false)

page = Page.new(:name=>"About us", :title=> "How we work",
            :description => "Genuine customer feedback provides extremely valuable insight for businesses. Both good and bad feedback is essential. It facilitates companies to correct errors, better the good and keep up with the consumer trends. More often than not it is an all-round value adding process.

However research shows that for every customer complaint there are 26 other unhappy customers who remained silent. This proves that little feedback is given by customers. Frustrating process, distrust for follow up on feedback given, lengthy … , are among other challenges faced by customers giving feedback.

A public feedback platform will eliminate some of the problems in that it is independent, less biased, allows sharing, transparent and possibly faster against one on one feedback. This will better the overall effect on customer service and value creation.

Kenya does not have a forum like this, leaving companies not accountable and paying less attention on customer service. We would like to challenge and change this. {Name} is the platform that will give the customer in Kenya the chance to give ratings, Kudos and also challenge those that do not deliver. Customers are therefore encouraged … Come all let's give a ranking. We deserve better!",:slug=>"how-we-work")
page.save(:validates=>false)

page = Page.new(:name=>"About us", :title=> "Terms of use",
            :description => "Genuine customer feedback provides extremely valuable insight for businesses. Both good and bad feedback is essential. It facilitates companies to correct errors, better the good and keep up with the consumer trends. More often than not it is an all-round value adding process.

However research shows that for every customer complaint there are 26 other unhappy customers who remained silent. This proves that little feedback is given by customers. Frustrating process, distrust for follow up on feedback given, lengthy … , are among other challenges faced by customers giving feedback.

A public feedback platform will eliminate some of the problems in that it is independent, less biased, allows sharing, transparent and possibly faster against one on one feedback. This will better the overall effect on customer service and value creation.

Kenya does not have a forum like this, leaving companies not accountable and paying less attention on customer service. We would like to challenge and change this. {Name} is the platform that will give the customer in Kenya the chance to give ratings, Kudos and also challenge those that do not deliver. Customers are therefore encouraged … Come all let's give a ranking. We deserve better!",:slug=>"terms-of-use")
page.save(:validates=>false)

page = Page.new(:name=>"csr",  :title=>"CSR", :slug=>"csr",:template_name=>'csr')
page.save(:validates=>false)
ResourceType.create(:name=>"Jobs")
ResourceType.create(:name=>"Articles")
