require "spec_helper"

describe UserMailer do
  describe "greating" do
    let(:mail) { UserMailer.greating }

    it "renders the headers" do
      mail.subject.should eq("Greating")
      mail.to.should eq(["to@example.org"])
      mail.from.should eq(["from@example.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hi")
    end
  end

end
