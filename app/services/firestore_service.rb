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
      project_id: ENV["firestore_project_id"],
      credentials: "config/borderbot-firebase-firebase-adminsdk.json")
  end
end
