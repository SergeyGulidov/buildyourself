xml.instruct!
xml.rss "version" => "2.0",
		"xmlns:dc" => "http://purl.org/dc/elements/1.1/" do
	xml.channel do
		xml.title 'Freshly Added News'
		xml.link root_url
		xml.pubDate CGI.rfc1123_date(@news.first.created_at)
		xml.description "Yoda.lv Latest news from"
		@news.each do |story|
			xml.item do
				xml.description story.message
				xml.pubDate CGI.rfc1123_date(story.created_at)
				xml.author story.user.name || story.user.email
			end
		end
	end
end