xml.instruct!
xml.rss "version" => "2.0",
		"xmlns:dc" => "http://purl.org/dc/elements/1.1/" do
	xml.channel do
		xml.title 'Freshly Added News From Yoda.lv'
		xml.link root_url
		xml.pubDate CGI.rfc1123_date(@news.first.created_at)
		xml.description "Latest news from " + @user.name || @user.email
		unless @news.blank?
			@news.each do |feed|
				xml.item do
					xml.title "At #{feed.created_at.strftime("%H:%M")} #{@user.name || @user.email} wrote:"
					xml.link place_url(feed.place_id)
					xml.description feed.message
					xml.pubDate CGI.rfc1123_date(feed.created_at)
				end
			end
		end
	end
end