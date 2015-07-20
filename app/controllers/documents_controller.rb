class DocumentsController < ApplicationController
  before_action :set_document, only: [:edit, :update, :destroy]

  def index
    if current_user.super_admin?
      @documents = Document.documents
    elsif current_user.admin?
      @documents = current_user.customer_documents
    else
      @documents = current_user.live_documents
    end
    readed_notifications
  end

  def new
    @category = Category.find(params[:category_id])
    @document = @category.documents.build
    authorize! :create, @document
  end

  def edit
    authorize! :update, @document
  end

  def create
    @category = Category.find(params[:category_id])
    @document = @category.documents.new(document_params)
    if @document.save
      attach_files(params[:files])
      send_notifications
      redirect_to group_category_path(@category.group, @category)\
      , notice: 'Document was successfully created.'
    else
      render :new
    end
  end

  def update
    if @document.update(document_params)
      attach_files(params[:files])
      redirect_to group_category_path(@category.group, @category)\
      , notice: 'Document was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    authorize! :delete, @document
    @document.update(is_deleted: true)
    redirect_to group_category_path(@category.group, @category)\
    , notice: 'Document was successfully destroyed.'
  end

  def attach_files(files)
    return if files.blank?
    files.each { |file| @document.file_data.create(file: file) }
  end

  def send_notifications
    group = @category.group
    group.group_users.each do |u|
      next if current_user.eql? u
      Notification.create(user_id: u.id, document_id: @document.id)
    end
  end

  def readed_notifications
    current_user.unread_ntfs.each do |nf|
      next unless nf.document_ntfs?
      nf.update(is_readed: true)
    end
  end

  private

  def set_document
    @category = Category.find(params[:category_id])
    @document = @category.documents.find(params[:id])
  end

  def document_params
    params.require(:document).permit(:title, :category_id)
  end
end
