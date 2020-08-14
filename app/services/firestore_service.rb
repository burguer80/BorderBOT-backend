# frozen_string_literal: true

class FirestoreService

  def initialize
    @firestore = init_firebase
  end

  def get_collection(collection_name)
    @firestore.col(collection_name)
  end

  def get_document(collection_name, document_name)
    @firestore.col(collection_name).doc(document_name)
  end

  def set_document(document, data)
    document.set(data)
  end

  def update_document(document, data)
    @firestore.transaction do |tx|
      tx.update(document, data)
    end
  end

  private

  def init_firebase
    Google::Cloud::Firestore.new(
      project_id: "borderbot-firebase",
      credentials: credentials_json
    )
  end

  def credentials_json
    firebase_admin_sdk = {
      type: "service_account",
      project_id: ENV['project_id'],
      private_key_id: ENV['private_key_id'],
      private_key: "-----BEGIN PRIVATE KEY-----\n#{ENV['private_key']}\n-----END PRIVATE KEY-----\n",
      client_email: ENV['client_email'],
      client_id: ENV['client_id'],
      auth_uri: "https://accounts.google.com/o/oauth2/auth",
      token_uri: "https://oauth2.googleapis.com/token",
      auth_provider_x509_cert_url: "https://www.googleapis.com/oauth2/v1/certs",
      client_x509_cert_url: "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-shjqh%40borderbot-firebase.iam.gserviceaccount.com"
    }
    firebase_admin_sdk.as_json
  end
end
