# frozen_string_literal: true

require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to test the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator. If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails. There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.

RSpec.describe '/uploads', type: :request do
  # Upload. As you add validations to Upload, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) do
    skip('Add a hash of attributes valid for your model')
  end

  let(:invalid_attributes) do
    skip('Add a hash of attributes invalid for your model')
  end

  let(:organization) { FactoryBot.create(:organization) }

  before do
    sign_in FactoryBot.create(:admin)
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      Upload.create! valid_attributes
      get organization_uploads_url
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      upload = Upload.create! valid_attributes
      get organization_upload_url(upload)
      expect(response).to be_successful
    end
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      get new_organization_upload_url(organization)
      expect(response).to be_successful
    end
  end

  describe 'GET /edit' do
    it 'render a successful response' do
      upload = Upload.create! valid_attributes
      get edit_organization_upload_url(upload)
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Upload' do
        expect do
          post organization_uploads_url(organization), params: { upload: valid_attributes }
        end.to change(Upload, :count).by(1)
      end

      it 'redirects to the created upload' do
        post organization_uploads_url(organization), params: { upload: valid_attributes }
        expect(response).to redirect_to(upload_url(Upload.last))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Upload' do
        expect do
          post organization_uploads_url(organization), params: { upload: invalid_attributes }
        end.to change(Upload, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post organization_uploads_url(organization), params: { upload: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) do
        skip('Add a hash of attributes valid for your model')
      end

      it 'updates the requested upload' do
        upload = Upload.create! valid_attributes
        patch organization_upload_url([organization, upload]), params: { upload: new_attributes }
        upload.reload
        skip('Add assertions for updated state')
      end

      it 'redirects to the upload' do
        upload = Upload.create! valid_attributes
        patch organization_upload_url([organization, upload]), params: { upload: new_attributes }
        upload.reload
        expect(response).to redirect_to(organization_upload_url([organization, upload]))
      end
    end

    context 'with invalid parameters' do
      it "renders a successful response (i.e. to display the 'edit' template)" do
        upload = Upload.create! valid_attributes
        patch organization_upload_url([organization, upload]), params: { upload: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested upload' do
      upload = Upload.create! valid_attributes
      expect do
        delete organization_upload_url([organization, upload])
      end.to change(Upload, :count).by(-1)
    end

    it 'redirects to the uploads list' do
      upload = Upload.create! valid_attributes
      delete organization_upload_url([organization, upload])
      expect(response).to redirect_to(uploads_url)
    end
  end
end