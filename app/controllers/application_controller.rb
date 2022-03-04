class ApplicationController < ActionController::Base
  #
  # def repo_name
  #   @repo_name = RepoNameFacade.find_repo_name
  # end
  #
  # def contributors
  #   @contributors = ContributorFacade.find_contributor
  # end
  #
  # def pulls
  #   @pulls = PullsFacade.count_pulls
  # end

  def next_3_holidays
    @holidays = PublicHolidaysFacade.find_holidays
  end
end
