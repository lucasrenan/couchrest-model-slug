require 'spec_helper'

describe CouchRest::Model::Slug do
  describe "defining slugs fields" do
    before(:each) do
      @post = Factory.build(:post)
    end
    
    it "should has a slug class method" do
      Post.respond_to?("slug").should be_true
    end
  end
end