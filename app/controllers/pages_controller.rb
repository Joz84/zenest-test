class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :legal, :cgv, :charte]

  def home
    @companies = Company.filter_by_logo
    @praticiens = Praticien.select_by_emails(Praticien::PRATICIEN_EMAILS_FOR_HOMEPAGE)
  end

  def legal
  end

  def charte
  end

  def cgv
  end
end
