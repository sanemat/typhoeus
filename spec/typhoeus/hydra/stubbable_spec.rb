require 'spec_helper'

describe Typhoeus::Hydra::Stubbable do
  let(:url) { "localhost:3001" }
  let(:request) { Typhoeus::Request.new(url) }
  let(:response) { Typhoeus::Response.new }
  let(:hydra) { Typhoeus::Hydra.new }

  before { Typhoeus.stub(url).and_return(response) }
  after { Typhoeus::Expectation.clear }

  describe "#add" do
    it "checks expactations" do
      hydra.add(request)
    end

    context "when expectation found" do
      it "finishes response" do
        request.should_receive(:finish)
        hydra.add(request)
      end

      it "is a mock" do
        hydra.add(request)
        expect(request.response.mock).to be(true)
      end
    end
  end
end
