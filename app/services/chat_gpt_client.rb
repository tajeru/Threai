require 'httparty'

class ChatGptClient
  include HTTParty
  base_uri 'https://api.openai.com/v1/'

  

  def initialize(api_key)
    @api_key = api_key
  end

  def ask_question(question)
    response = self.class.post(
      '/chat/completions',
      headers: {
        'Authorization' => "Bearer #{@api_key}",
        'Content-Type' => 'application/json'
      },
      body: {
        model: "gpt-3.5-turbo",
        messages: [
          { role: "system", content: "You are a helpful assistant." },
          { role: "user", content: question }
        ],
        max_tokens: 300,
        temperature: 0.7,
        top_p: 0.9,
        n: 6,
        stop: ["\n", "END"],
        presence_penalty: 0.6,
        frequency_penalty: 0.5
      }.to_json
    )
    response.parsed_response
  end
end