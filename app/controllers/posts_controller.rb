class PostsController < ApplicationController

	before_action :authenticate_user!, only: [:new, :create]

	def index
		@posts = Post.all
	end

	def new
		@post = Post.new
		@group = Group.find(params[:group_id]) 
	end

	def create
		@post = Post.new(post_params)
		@group = Group.find(params[:group_id])
		@post.group = @group
		@post.user = current_user

		if @post.save
			redirect_to group_path(@group)
		else
			render :new
		end
	end

	private

	def post_params
		params.require(:post).permit(:content)
	end
end
