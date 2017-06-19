class Contact < ActiveRecord::Base
  # disable database features of ActiveRecord via activerecord-tableless gem
  has_no_table

  # specify attributes via 'column' keyword activerecord-tableless gem
  column :name, :string
  column :email, :string
  column :content, :string

  validates_presence_of :name
  validates_presence_of :email
  validates_presence_of :content
  validates_format_of :email,
    :with => /\A[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}\z/i
  validates_length_of :content, :maximum => 500

  def update_spreadsheet
    # Authenticate a session with your Service Account
    session = GoogleDrive::Session.from_service_account_key("client_secret.json")
     
    # Get the spreadsheet by its title
    spreadsheet = session.spreadsheet_by_title("learn-rails")
    # Get the first worksheet
    worksheet = spreadsheet.worksheets.first
    last_row = 1 + worksheet.num_rows
    worksheet[last_row, 1] = Time.new
    worksheet[last_row, 2] = self.name
    worksheet[last_row, 3] = self.email
    worksheet[last_row, 4] = self.content
    worksheet.save
  end

end