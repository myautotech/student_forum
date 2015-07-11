class FileDataController < ApplicationController
  def download
    file = FileDatum.find(params[:id])
    send_file file.file.path if file
    download_log(file)
  end

  def download_log(file)
    dl = DownloadLog.new
    dl.user_id = current_user.id
    dl.file_datum_id = file.id
    dl.save
  end

  def download_history
    @download_logs = DownloadLog.all
    authorize! :read, DownloadLog
  end
end
