require 'spec_helper'

describe CouchRest::Model::Slug do
  describe "defining slugs fields and methods" do
    before do
      Factory.build(:post)
    end
    
    it "should has a slug class method" do
      Post.respond_to?("slug").should be_true
    end
    
    it "should has a by_slug view" do
      Post.has_view?("by_slug").should be_true
    end
    
    it "should has a by_slug_without_count view" do
      Post.has_view?("by_slug_without_count").should be_true
    end
    
    it "should return slugged properties" do
      Post.slugged_props.should eq(["title", "summary"])
    end
  end
  
  describe "generating slugs" do
    let!(:post) { Factory.create(:post, :title => "CouchDB", :summary => "Time to Relax") }
    
    it "should generates a slug" do
      post.slug.should eq("couchdb-time-to-relax")
    end
    
    it "should updates the slug" do
      post.title = "Oracle"
      post.summary = "time to spend all your money"
      post.save
      post.slug.should eq("oracle-time-to-spend-all-your-money")
    end
    
    it "should not change the slug if the slugged field does not change" do
      post.save
      post.slug.should eq("couchdb-time-to-relax")
    end
    
    it "should appends a counter if slug exists" do
      slug = Post.generate_count_for_slug("couchdb-time-to-relax")
      slug.should eq("couchdb-time-to-relax-1")
    end
    
    it "should generates uniq slugs" do
      5.times do |i|
        p = Factory.create(:post, :title => post.title, :summary => post.summary)
        p.slug.should eq("couchdb-time-to-relax-#{i + 1}")
      end
    end
  end
  
  describe "querying" do
    context "when slugged field exists" do
      let!(:post) { Factory.create(:post, :title => "Test", :summary => "All the fucking time!") }
    
      it "should return the uniq slugged value" do
        post.to_param.should eq("test-all-the-fucking-time")
      end
      
      it "should find by slug" do
        Post.find("test-all-the-fucking-time").should eq(post)
      end
    end
    
    context "when slugged field not exists" do
      let!(:post) { Factory.create(:post, :title => "", :summary => "") }
    
      it "should return the document id" do
        post.to_param.should eq(post.id)
      end
      
      it "should find by id" do
        Post.find(post.id).should eq(post)
      end
    end
  end
  
end