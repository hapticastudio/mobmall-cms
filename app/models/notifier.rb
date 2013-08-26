class Notifier
  def initialize(ids)
    @ids = ids
  end

  def send!
    raise "No GCM key set in environment" unless ENV['GCM_KEY']
    HTTParty.post(end_point, body: body.to_json, headers: headers).body
  end

  private

  def body
    {
      registration_ids: @ids,
      data: {
        message: "Update thyself!"
      }
    }
  end

  def headers
    { 'Content-Type' => "application/json", 'Authorization' => "key=#{ENV['GCM_KEY']}"}
  end

  def end_point
    "https://android.googleapis.com/gcm/send"
  end
end
