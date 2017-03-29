require 'rails_helper'

describe GithubUserSerializer do
  subject { described_class.new(build(:github_user)) }

  it 'should have expected attribute names' do
    expect(subject.attributes.keys).to eql([
      :github_id, :login, :user_type, :created_at, :updated_at, :name,
      :company, :blog, :location, :hidden, :last_synced_at, :email, :bio,
      :followers, :following
    ])
  end
end
