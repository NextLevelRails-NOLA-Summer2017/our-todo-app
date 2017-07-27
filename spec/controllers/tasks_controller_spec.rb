require 'rails_helper'

RSpec.describe TasksController, type: :controller do

  before { sign_in(create(:user)) }

  describe 'GET #index' do

    it 'renders the index template' do
      get :index

      expect(response).to render_template(:index)
    end

    it 'returns all the tasks for the user' do
      # user with some tasks
      user = create(:user_with_real_boy_tasks)
      sign_in(user)

      # request the index view
      get :index

      # make sure @tasks isn't empty
      expect(assigns(:tasks)).not_to be_nil
      # make sure there are the same number of tasks that we created
      expect(assigns(:tasks).count).to eq(2)
      # make sure the tasks info is the same as what we made
      expect(assigns(:tasks).first.name).to eq('Do homework')
    end

  end

  describe 'GET #new' do

    it 'renders the new template' do
      get :new

      expect(response).to render_template(:new)
    end

    it 'assigns a new task to @task' do
      # ask for the new view
      get :new

      # make sure it made a skeleton task for us to use and assigns it to @task
      expect(assigns(:task)).to be_a_new(Task)
    end

  end

  describe 'GET #show' do

    it 'renders the show template' do
      task = create(:email)
      # ask for the show view
      get :show, params: { id: task.to_param }

      # make sure we get the show view
      expect(response).to render_template(:show)
    end


    it "assigns the requested task as @task" do
        task = create(:homework)

        get :show, params: { id: task.to_param }

        expect(assigns(:task)).to eq(task)
    end
  end

  describe 'GET #edit' do

    it 'renders the edit template' do
      # make a task
      task = create(:email)

      # ask for the edit template
      get :edit, params: { id: task.to_param }

      # make sure we get the edit template
      expect(response).to render_template(:edit)
    end


    it 'assigns the requested task as @task' do
      # make a task
      task = create(:homework)

      # ask for the edit template
      get :edit, params: { id: task.to_param }

      # make sure the task we got is the task we made
      expect(assigns(:task)).to eq(task)
    end
  end

  describe 'POST #create' do
    let(:user) { create(:user) }
    let(:valid_attributes) { attributes_for(:email, user_id: user.id) }
    let(:invalid_attributes) { attributes_for(:invalid_task) }

    context 'with valid attributes' do
      it 'saves the new task to the database' do
        expect {
          post :create, params: { task: valid_attributes }
        }.to change(Task, :count).by(1)
      end

      it 'redirects to the show view' do
        post :create, params: { task: valid_attributes }

        expect(response).to redirect_to(assigns(:task))
      end
    end

    context 'with invalid attributes' do
      it 'does not save the new task to the database' do
        expect {
          post :create, params: { task: invalid_attributes }
        }.not_to change(Task, :count)
      end

      it 'renders the new view' do
        post :create, params: { task: invalid_attributes }

        expect(response).to render_template(:new)
      end
    end
  end

  describe 'PATCH #update' do
    let(:task) { create(:email) }
    let(:new_attributes) { attributes_for(:homework) }
    let(:invalid_attributes) { attributes_for(:invalid_task) }

    context 'with valid params' do
      it 'updates the selected task' do
        patch :update, params: { id: task.to_param, task: new_attributes }

        task.reload

        expect(task.name).to eq('Do homework')
        expect(task.priority).to eq(1)
      end

      it 'redirects to the task' do
        patch :update, params: { id: task.to_param, task: new_attributes }

        task.reload

        expect(response).to redirect_to(task)
      end
    end

    context 'with invalid params' do
      it 'does not update the selected task' do
        patch :update, params: { id: task.to_param, task: invalid_attributes }

        task.reload

        expect(assigns(:task)).to eq(task)
      end

      it 'renders to the edit template' do
        patch :update, params: { id: task.to_param, task: invalid_attributes }

        task.reload

        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:task) { build(:homework) }

    it 'destroys the requested task' do
      task.save

      expect {
        delete :destroy, params: { id: task.to_param }
      }.to change(Task, :count).by(-1)
    end

    it 'redirects to the index' do
      task.save

      delete :destroy, params: { id: task.to_param }

      expect(response).to redirect_to(tasks_path)
    end
  end

  describe 'unauthenticated' do
    it 'redirects user to login page when not signed in' do
      sign_out(:user)

      get :index
      expect(response).to redirect_to(new_user_session_path)
    end
  end

end








