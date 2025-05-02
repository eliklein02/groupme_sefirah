require 'httparty'
class Methods
  def fetch_todays_omer
    response = HTTParty.get('https://www.hebcal.com/converter?cfg=json&strict=1')
    omer = ''
    if response['events'].any?
      response['events'].map do |e|
        next unless e.include?('Omer')

        omer = e
        return "Today is the #{omer}"
      end
    end
    "Today is the #{omer}"
  end

  def fetch_top_headlines
    response = HTTParty.get('https://newsapi.org/v2/top-headlines?country=us&apiKey=af68150fdd444dd8bb2fa63e1c9dbf04')
    articles = response['articles']
    [articles[0]['title'], articles[5]['title'], articles[10]['title']].join(' | ')
  end

  def render_omer
    omer = fetch_todays_omer
    render json: omer, status: :ok
  end

  def groups
    groups = HTTParty.get("https://api.groupme.com/v3/groups?token=#{ENV.fetch('GROUPME_API_KEY')}")
    render json: groups
  end

  def send_update
    # news = fetch_top_headlines
    omer = fetch_todays_omer
    puts omer
    # time_of_day = Time.now.hour < 12 ? "morning" : "evening"
    # send_message("Good #{time_of_day}!")
    send_message("REMINDER\n#{omer}")
    # send_message("And for some news...\n#{news}")
  end

  def send_message(message)
    response = HTTParty.post('https://api.groupme.com/v3/bots/post',
                             {
                               headers: { 'Content-Type' => 'application/json' },
                               body: {
                                 'bot_id' => 'aca8d8d26af5651d5e05a36756',
                                 text: message
                               }.to_json
                             })
    puts response.code
  end
end
