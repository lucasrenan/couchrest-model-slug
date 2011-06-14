require 'spec_helper'

describe Couchrest::Model::Slug do
  it "should be valid" do
    Couchrest::Model::Slug.should be_a(Module)
  end
end