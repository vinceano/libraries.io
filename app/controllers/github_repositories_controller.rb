class GithubRepositoriesController < ApplicationController
  def show
    full_name = [params[:owner], params[:name]].join('/')
    @github_repository = GithubRepository.where(full_name: full_name).first
    @github_repository = GithubRepository.where('lower(full_name) = ?', full_name.downcase).first if @github_repository.nil?
    raise ActiveRecord::RecordNotFound if @github_repository.nil?
    raise ActiveRecord::RecordNotFound unless authorized?
    redirect_to github_repository_path(@github_repository.owner_name, @github_repository.project_name), :status => :moved_permanently if full_name != @github_repository.full_name
    @contributors = @github_repository.github_contributions.order('count DESC').limit(20).includes(:github_user)
    @projects = @github_repository.projects
    @color = @github_repository.color
  end

  def authorized?
    if @github_repository.private?
      current_user && current_user.can_read?(@github_repository)
    else
      true
    end
  end
end
