# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'uploads/edit', type: :view do
  let(:organization) { FactoryBot.create(:organization) }
  let(:upload) do
    Upload.create!(
      name: 'MyString',
      files: [],
      stream_id: organization.default_stream.id
    )
  end

  before do
    assign(:upload, upload)
    assign(:organization, organization)
  end

  it 'renders the edit upload form' do
    render

    assert_select 'form[action=?][method=?]', organization_upload_path(organization, upload), 'post' do
      assert_select 'input[name=?]', 'upload[name]'

      assert_select 'input[name=?]', 'upload[files][]'
    end
  end
end
