require 'spec_helper'

describe Notifier do
  context "send" do
    it "calls gcm server" do
      stub_request(:post, "https://android.googleapis.com/gcm/send").
        with(:body => "{\"registration_ids\":[\"some_key\"],\"data\":{\"message\":\"Update thyself!\"}}",
             :headers => {'Authorization'=>'key=test_key', 'Content-Type'=>'application/json'}).
        to_return(:status => 200, :body => "ok!", :headers => {})

      assert_equal "ok!", Notifier.new(['some_key']).send!
    end
  end
end
